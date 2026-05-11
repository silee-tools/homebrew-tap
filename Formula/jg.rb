# typed: false
# frozen_string_literal: true

# silee-tools/cli 모노레포 prebuilt 바이너리. release-please.yml 의 GoReleaser
# 가 4종 tar.gz + checksums.txt 를 GitHub Release 에 첨부하고, 그 후속 step 의
# scripts/update-homebrew-formula.py 가 version + sha256 라인을 자동 갱신한다.
# URL 에 #{version} 인터폴레이션 사용 — 스크립트는 version 만 교체하면 URL 도 자동 추적.
class Jg < Formula
  desc "A frecency-based CLI for quickly jumping to Git repositories"
  homepage "https://github.com/silee-tools/cli/tree/main/apps/jg"
  version "0.2.2"
  license "MIT"

  depends_on "fzf"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/silee-tools/cli/releases/download/jg/v#{version}/jg-v#{version}-darwin-arm64.tar.gz"
      sha256 "e5f2d84c35c57afef50cabe04db733412e04ce33ce723d4386a3e5285df5f38e"
    end
    if Hardware::CPU.intel?
      url "https://github.com/silee-tools/cli/releases/download/jg/v#{version}/jg-v#{version}-darwin-amd64.tar.gz"
      sha256 "708f330bc1065a7cff5c004923e06af6f7d2a8d73e8f381b5d49d9b76dd5942f"
    end
  end

  on_linux do
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/silee-tools/cli/releases/download/jg/v#{version}/jg-v#{version}-linux-amd64.tar.gz"
      sha256 "0ec0f7ead9ddc53278d0ec0b6b041e5f5333c7707584aae345d8ef2cc733dda9"
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/silee-tools/cli/releases/download/jg/v#{version}/jg-v#{version}-linux-arm64.tar.gz"
      sha256 "17bf2255ab31b441122bcf271d22ab80aaaa1e57da0b3b3867a8aad7d4464592"
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
