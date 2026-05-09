# typed: false
# frozen_string_literal: true

# totp 는 macOS Keychain (cgo) 의존으로 macOS 전용. release-please.yml 의
# GoReleaser 가 darwin amd64/arm64 2종 prebuilt 만 첨부.
class Totp < Formula
  desc "macOS Keychain-backed TOTP code generator"
  homepage "https://github.com/silee-tools/cli/tree/main/apps/totp"
  version "1.0.0"
  license "MIT"

  depends_on :macos

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/silee-tools/cli/releases/download/totp/v#{version}/totp-v#{version}-darwin-arm64.tar.gz"
      sha256 "1a638f850f454f7cac5ccd9a359465e1ff7408cca3f465dea3e6b64afe64a34f"
    end
    if Hardware::CPU.intel?
      url "https://github.com/silee-tools/cli/releases/download/totp/v#{version}/totp-v#{version}-darwin-amd64.tar.gz"
      sha256 "5515b03c43eea8d45255090600f2f96c8bb84438e8080649f0383f9e4ab69a85"
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
