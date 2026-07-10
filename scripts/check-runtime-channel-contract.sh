#!/bin/sh
set -eu

ROOT=$(CDPATH='' cd -- "$(dirname -- "$0")/.." && pwd)
umask 077
WORK=$(mktemp -d "${TMPDIR:-/tmp}/silee-tools-formula-channel.XXXXXX")
trap 'rm -rf "$WORK"' EXIT HUP INT TERM

check_formula() {
  tool=$1
  formula=$2
  post_install=$(awk '
    /^  def post_install$/ { capture = 1 }
    capture { print }
    capture && /^  end$/ { exit }
  ' "$formula")

  if [ -z "$post_install" ]; then
    printf '%s: missing def post_install\n' "${formula#"$ROOT"/}" >&2
    return 1
  fi

  if printf '%s\n' "$post_install" | grep -Fq 'executable='; then
    printf '%s: post_install must not accept an executable override\n' \
      "${formula#"$ROOT"/}" >&2
    return 1
  fi

  failed=0
  for required in \
    'state_dir = var/"silee-tools"/'\"$tool\" \
    'state_dir.mkpath' \
    'state_file = state_dir/"active-channel"' \
    'temp_file = state_dir/"active-channel.tmp-' \
    'temp_file.write' \
    'channel=release' \
    'temp_file.rename state_file'; do
    if ! printf '%s\n' "$post_install" | grep -Fq "$required"; then
      printf '%s: post_install missing contract fragment: %s\n' \
        "${formula#"$ROOT"/}" "$required" >&2
      failed=1
    fi
  done

  return "$failed"
}

exercise_formula() {
  tool=$1
  formula=$2
  var_dir=${3:-$WORK/$tool/var}
  state=$var_dir/silee-tools/$tool/active-channel

  ruby - "$formula" "$var_dir" <<'RUBY'
require "fileutils"
require "pathname"

formula_path, var_path = ARGV
lines = File.readlines(formula_path)
start = lines.index { |line| line == "  def post_install\n" }
abort "missing def post_install" unless start
finish = ((start + 1)...lines.length).find { |index| lines[index] == "  end\n" }
abort "unterminated def post_install" unless finish
method_source = lines[start..finish].map { |line| line.sub(/^  /, "") }.join

formula = Class.new do
  define_method(:var) { Pathname(var_path) }
end
formula.class_eval(method_source, formula_path, start + 1)
formula.new.post_install
RUBY

  expected=channel=release
  actual=$(cat "$state")
  if [ "$actual" != "$expected" ]; then
    printf '%s: executed post_install wrote unexpected state\n' \
      "${formula#"$ROOT"/}" >&2
    return 1
  fi
}

if [ "${1:-}" = "--exercise" ]; then
  if [ "$#" -ne 3 ]; then
    printf 'usage: %s --exercise <tool> <var-dir>\n' "$0" >&2
    exit 2
  fi
  tool=$2
  var_dir=$3
  formula=$ROOT/Formula/$tool.rb
  check_formula "$tool" "$formula"
  exercise_formula "$tool" "$formula" "$var_dir"
  exit 0
fi

failed=0
for formula in "$ROOT"/Formula/*.rb; do
  tool=${formula##*/}
  tool=${tool%.rb}
  check_formula "$tool" "$formula" || failed=1
  exercise_formula "$tool" "$formula" || failed=1
done

exit "$failed"
