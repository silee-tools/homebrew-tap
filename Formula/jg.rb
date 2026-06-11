# typed: false
# frozen_string_literal: true

# silee-tools/cli 모노레포 prebuilt 바이너리. release-please.yml 의 GoReleaser
# 가 4종 tar.gz + checksums.txt 를 GitHub Release 에 첨부하고, 그 후속 step 의
# scripts/update-homebrew-formula.py 가 version + sha256 라인을 자동 갱신한다.
# URL 에 #{version} 인터폴레이션 사용 — 스크립트는 version 만 교체하면 URL 도 자동 추적.
class Jg < Formula
  desc "A frecency-based CLI for quickly jumping to Git repositories"
  homepage "https://github.com/silee-tools/cli/tree/main/apps/jg"
  version "0.7.0"
  license "MIT"

  depends_on "fzf"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/silee-tools/cli/releases/download/jg/v#{version}/jg-v#{version}-darwin-arm64.tar.gz"
      sha256 "983229ac0ff7c06880016b59b75156681382799dca3a56462bb79fb73637f998"
    end
    if Hardware::CPU.intel?
      url "https://github.com/silee-tools/cli/releases/download/jg/v#{version}/jg-v#{version}-darwin-amd64.tar.gz"
      sha256 "8f62dd8215b0d695d3cca05e0e0bfeb0ae165c137d7cd8b54db66eadf74b1dbb"
    end
  end

  on_linux do
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/silee-tools/cli/releases/download/jg/v#{version}/jg-v#{version}-linux-amd64.tar.gz"
      sha256 "ac495ef343e2c08322523c54dfcb636abfd94d952f6834f0877641f00420ee2c"
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/silee-tools/cli/releases/download/jg/v#{version}/jg-v#{version}-linux-arm64.tar.gz"
      sha256 "7ca9ed395760a36557d6c462b080005df26f080648b920bd43a59fbdcdf25b45"
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
