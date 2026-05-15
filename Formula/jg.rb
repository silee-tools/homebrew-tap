# typed: false
# frozen_string_literal: true

# silee-tools/cli 모노레포 prebuilt 바이너리. release-please.yml 의 GoReleaser
# 가 4종 tar.gz + checksums.txt 를 GitHub Release 에 첨부하고, 그 후속 step 의
# scripts/update-homebrew-formula.py 가 version + sha256 라인을 자동 갱신한다.
# URL 에 #{version} 인터폴레이션 사용 — 스크립트는 version 만 교체하면 URL 도 자동 추적.
class Jg < Formula
  desc "A frecency-based CLI for quickly jumping to Git repositories"
  homepage "https://github.com/silee-tools/cli/tree/main/apps/jg"
  version "0.3.1"
  license "MIT"

  depends_on "fzf"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/silee-tools/cli/releases/download/jg/v#{version}/jg-v#{version}-darwin-arm64.tar.gz"
      sha256 "cf0e2d101d567757840ed10dfa199b1dbfbbd9842a0b756d5c3648692d862e6e"
    end
    if Hardware::CPU.intel?
      url "https://github.com/silee-tools/cli/releases/download/jg/v#{version}/jg-v#{version}-darwin-amd64.tar.gz"
      sha256 "82ce4ee1882c4d5076992c813f18c6fee544738d43c75f247465afb174de1451"
    end
  end

  on_linux do
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/silee-tools/cli/releases/download/jg/v#{version}/jg-v#{version}-linux-amd64.tar.gz"
      sha256 "06dd6e4dc6926a58744040a4e17c7eedb5e3fb489dd1d407c865d0e9ae186778"
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/silee-tools/cli/releases/download/jg/v#{version}/jg-v#{version}-linux-arm64.tar.gz"
      sha256 "0e3fb7b9a2bb8b387485a219da88427ea761bfce8739b06b8ecbb4e2e949bb2b"
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
