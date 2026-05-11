# typed: false
# frozen_string_literal: true

# saml2aws-auto. saml2aws 로그인 자동화와 zsh 세션 체크를 제공하는 Go CLI.
class Saml2awsAuto < Formula
  desc "Automatic saml2aws AzureAD MFA login using Keychain-backed TOTP"
  homepage "https://github.com/silee-tools/cli/tree/main/apps/saml2aws-auto"
  version "2.0.1"
  license "MIT"

  depends_on "silee-tools/tap/totp"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/silee-tools/cli/releases/download/saml2aws-auto/v#{version}/saml2aws-auto-v#{version}-darwin-arm64.tar.gz"
      sha256 "f68128110894ae668577ba3773c15be1395999f1947fa2fc8994ed9f73b90c04"
    end
    if Hardware::CPU.intel?
      url "https://github.com/silee-tools/cli/releases/download/saml2aws-auto/v#{version}/saml2aws-auto-v#{version}-darwin-amd64.tar.gz"
      sha256 "5899af6ad05591366d3b70f55a5c7cb2be6f4c1673ae0083fc836599278637d8"
    end
  end

  on_linux do
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/silee-tools/cli/releases/download/saml2aws-auto/v#{version}/saml2aws-auto-v#{version}-linux-amd64.tar.gz"
      sha256 "ddddc980ac875f60b889f83dbfa4bb21455bfba8a16aff4b3574957978966c72"
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/silee-tools/cli/releases/download/saml2aws-auto/v#{version}/saml2aws-auto-v#{version}-linux-arm64.tar.gz"
      sha256 "c14a8f96c2df5488341db685f833588f379a5b702d22d85824d3626e8c35f434"
    end
  end

  def install
    bin.install "saml2aws-auto"
    (share/"saml2aws-auto").install "saml2aws-auto.plugin.zsh"
  end

  def caveats
    <<~EOS
      saml2aws-auto 는 saml2aws CLI 를 별도로 요구합니다:
        brew install saml2aws

      zsh plugin:
        zinit snippet "#{share}/saml2aws-auto/saml2aws-auto.plugin.zsh"
        # 또는
        source "#{share}/saml2aws-auto/saml2aws-auto.plugin.zsh"

      환경변수:
        SAML2AWS_USERNAME              # saml2aws CLI native (필수)
        SAML2AWS_AUTO_TOTP_NAME        # Keychain TOTP 항목 이름 (기본: "MS: $SAML2AWS_USERNAME")
    EOS
  end

  test do
    assert_match "saml2aws-auto", shell_output("#{bin}/saml2aws-auto --help 2>&1")
    assert_path_exists share/"saml2aws-auto/saml2aws-auto.plugin.zsh"
  end
end
