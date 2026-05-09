# typed: false
# frozen_string_literal: true

# silee-tools/cli 모노레포 prebuilt 바이너리. release-please.yml 의 GoReleaser
# 가 4종 tar.gz + checksums.txt 를 GitHub Release 에 첨부하고, 그 후속 step 의
# scripts/update-homebrew-formula.py 가 version + sha256 라인을 자동 갱신한다.
# URL 에 #{version} 인터폴레이션 사용 — 스크립트는 version 만 교체하면 URL 도 자동 추적.
class Jg < Formula
  desc "A frecency-based CLI for quickly jumping to Git repositories"
  homepage "https://github.com/silee-tools/cli/tree/main/apps/jg"
  version "0.2.1"
  license "MIT"

  depends_on "fzf"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/silee-tools/cli/releases/download/jg/v#{version}/jg-v#{version}-darwin-arm64.tar.gz"
      sha256 "5033c042dd3c5e6fdd2e767347ca03d96d01c4b511003f42cf1d8790d3fc034f"
    end
    if Hardware::CPU.intel?
      url "https://github.com/silee-tools/cli/releases/download/jg/v#{version}/jg-v#{version}-darwin-amd64.tar.gz"
      sha256 "d3a7628b8ef718bd9aa70a9ecbdf4347dfb849bf0254b1e49cbc09298dd7d276"
    end
  end

  on_linux do
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/silee-tools/cli/releases/download/jg/v#{version}/jg-v#{version}-linux-amd64.tar.gz"
      sha256 "f78d7904121f6c23c279f2b51cc8c39964e6c8a7afab74895e5199a545e81975"
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/silee-tools/cli/releases/download/jg/v#{version}/jg-v#{version}-linux-arm64.tar.gz"
      sha256 "483466c8a1adaf7a4da1a16e2bc445834a623637caf7f60868709ecb3ce0b34c"
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
