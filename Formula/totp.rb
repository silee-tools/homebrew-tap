# typed: false
# frozen_string_literal: true

# totp 는 macOS Keychain (cgo) 의존으로 macOS 전용. release-please.yml 의
# GoReleaser 가 darwin amd64/arm64 2종 prebuilt 만 첨부.
class Totp < Formula
  desc "macOS Keychain-backed TOTP code generator"
  homepage "https://github.com/silee-tools/cli/tree/main/apps/totp"
  version "1.1.1"
  license "MIT"

  depends_on :macos

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/silee-tools/cli/releases/download/totp/v#{version}/totp-v#{version}-darwin-arm64.tar.gz"
      sha256 "547f113578b9b82c4bb12b7d5f32e2c12ef7f03fdb085a975dc1cc97de340d16"
    end
    if Hardware::CPU.intel?
      url "https://github.com/silee-tools/cli/releases/download/totp/v#{version}/totp-v#{version}-darwin-amd64.tar.gz"
      sha256 "dc9a196b77cf7a16cc75e713e2a2ed46011643a8f0ef0d2d2ca836d57a0a6768"
    end
  end

  def install
    bin.install "totp"
  end

  def post_install
    state_dir = var/"silee-tools"/"totp"
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
      totp 은 macOS Keychain 의 generic-password 항목을 시크릿 저장소로 사용합니다.
      기존 zsh 함수 totp.plugin.zsh 로 등록한 항목과 마커 호환.

      fzf picker 모드를 쓰려면: brew install fzf
    EOS
  end

  test do
    assert_match "totp", shell_output("#{bin}/totp --help 2>&1")
  end
end
