# typed: false
# frozen_string_literal: true

# totp 는 macOS Keychain (cgo) 의존으로 macOS 전용. release-please.yml 의
# GoReleaser 가 darwin amd64/arm64 2종 prebuilt 만 첨부.
class Totp < Formula
  desc "macOS Keychain-backed TOTP code generator"
  homepage "https://github.com/silee-tools/cli/tree/main/apps/totp"
  version "1.1.0"
  license "MIT"

  depends_on :macos

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/silee-tools/cli/releases/download/totp/v#{version}/totp-v#{version}-darwin-arm64.tar.gz"
      sha256 "404bcf2af22d037c951680fc449f3d1f20382a2087957d1215a6ef4a8e775a45"
    end
    if Hardware::CPU.intel?
      url "https://github.com/silee-tools/cli/releases/download/totp/v#{version}/totp-v#{version}-darwin-amd64.tar.gz"
      sha256 "16fc32cffb70082a5f58502c3ad3d7188183858566181e6c9070f9a1ab23e44e"
    end
  end

  def install
    bin.install "totp"
  end

  def caveats
    <<~EOS
      totp 은 macOS Keychain 의 generic-password 항목을 시크릿 저장소로 사용합니다.
      기존 zsh 함수 totp.plugin.zsh 로 등록한 항목과 마커 호환.

      fzf picker 모드를 쓰려면: brew install fzf
    EOS
  end

  test do
    assert_match "totp", shell_output("#{bin}/totp --help 2>&1")
  end
end
