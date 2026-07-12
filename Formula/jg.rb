# typed: false
# frozen_string_literal: true

# silee-tools/cli 모노레포 prebuilt 바이너리. release-please.yml 의 GoReleaser
# 가 4종 tar.gz + checksums.txt 를 GitHub Release 에 첨부하고, 그 후속 step 의
# scripts/update-homebrew-formula.py 가 version + sha256 라인을 자동 갱신한다.
# URL 에 #{version} 인터폴레이션 사용 — 스크립트는 version 만 교체하면 URL 도 자동 추적.
class Jg < Formula
  desc "A frecency-based CLI for quickly jumping to Git repositories"
  homepage "https://github.com/silee-tools/cli/tree/main/apps/jg"
  version "0.7.1"
  license "MIT"

  depends_on "fzf"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/silee-tools/cli/releases/download/jg/v#{version}/jg-v#{version}-darwin-arm64.tar.gz"
      sha256 "ef033e659d336c2e1e861a8ebd08d8e3d3a144a50d0d9df8ae79299e68318723"
    end
    if Hardware::CPU.intel?
      url "https://github.com/silee-tools/cli/releases/download/jg/v#{version}/jg-v#{version}-darwin-amd64.tar.gz"
      sha256 "55390fca3db452e2159809eb427bf4ab96e06d1b79e286e03d61b8a0fd2a15f1"
    end
  end

  on_linux do
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/silee-tools/cli/releases/download/jg/v#{version}/jg-v#{version}-linux-amd64.tar.gz"
      sha256 "ed9aa031afbff3eb4911cdab4b8f940d2da0ef4c9a3095fc98e31e161f3941d8"
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/silee-tools/cli/releases/download/jg/v#{version}/jg-v#{version}-linux-arm64.tar.gz"
      sha256 "db6a2d9958b5b54b39b0bef2696cd8a1f4e4b62969219738c30bdb2d6499c933"
    end
  end

  def install
    bin.install "jg"
    bin.install_symlink "jg" => "jgw"
    zsh_completion.install "completions/_jg"
    zsh_completion.install "completions/_jgw"
    bash_completion.install "completions/jg.bash" => "jg"
    bash_completion.install "completions/jgw.bash" => "jgw"
    (share/"jg"/"plugin").install "plugin/jg.plugin.zsh"
    (share/"jg"/"plugin").install "plugin/jg.plugin.bash"
  end

  def post_install
    state_dir = var/"silee-tools"/"jg"
    state_dir.mkpath
    state_file = state_dir/"active-channel"
    temp_file = state_dir/"active-channel.tmp-#{Process.pid}"
    temp_file.write <<~EOS
      channel=release
    EOS
    temp_file.rename state_file
  end

  def caveats
    <<~EOS
      Run 'jg setup' to configure shell integration,
      then restart your shell or run: exec $SHELL

      jgw is installed alongside jg as a sibling command for jumping
      between git worktrees of the same repo (or across repos).
    EOS
  end

  test do
    assert_match "jg", shell_output("#{bin}/jg --help 2>&1")
  end
end
