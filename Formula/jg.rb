# typed: false
# frozen_string_literal: true

# silee-tools/cli 모노레포 prebuilt 바이너리. release-please.yml 의 GoReleaser
# 가 4종 tar.gz + checksums.txt 를 GitHub Release 에 첨부하고, 그 후속 step 의
# scripts/update-homebrew-formula.py 가 version + sha256 라인을 자동 갱신한다.
# URL 에 #{version} 인터폴레이션 사용 — 스크립트는 version 만 교체하면 URL 도 자동 추적.
class Jg < Formula
  desc "A frecency-based CLI for quickly jumping to Git repositories"
  homepage "https://github.com/silee-tools/cli/tree/main/apps/jg"
  version "0.2.0"
  license "MIT"

  depends_on "fzf"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/silee-tools/cli/releases/download/jg/v#{version}/jg-v#{version}-darwin-arm64.tar.gz"
      sha256 "cce4d308f4cb86054575dfb2222779314a8bdee8959a15cf789455050c836549"
    end
    if Hardware::CPU.intel?
      url "https://github.com/silee-tools/cli/releases/download/jg/v#{version}/jg-v#{version}-darwin-amd64.tar.gz"
      sha256 "9de800031ee3ba4262f04a4af2f3bf6966c3fc023e4e2a1a697d656f682da067"
    end
  end

  on_linux do
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/silee-tools/cli/releases/download/jg/v#{version}/jg-v#{version}-linux-amd64.tar.gz"
      sha256 "16ed2384a1e4ed75681fcb3f1f2d2f70f271e0ce56194fdf6fe81f75ae48b4b6"
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/silee-tools/cli/releases/download/jg/v#{version}/jg-v#{version}-linux-arm64.tar.gz"
      sha256 "b2069a86d07b49217561db0b88ddca5a23b5938ea0f823bd8eac979b58b28389"
    end
  end

  def install
    bin.install "jg"
    zsh_completion.install "completions/_jg"
    bash_completion.install "completions/jg.bash" => "jg"
    (share/"jg"/"plugin").install "plugin/jg.plugin.zsh"
  end

  def caveats
    <<~EOS
      Run 'jg setup' to configure shell integration,
      then restart your shell or run: exec $SHELL
    EOS
  end

  test do
    assert_match "jg", shell_output("#{bin}/jg --help 2>&1")
  end
end
