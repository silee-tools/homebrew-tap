# typed: false
# frozen_string_literal: true

# saml2aws-auto-login (formula 명: saml2aws-auto). 외부 의존 0 의 Go CLI.
class Saml2awsAuto < Formula
  desc "Automatic saml2aws AzureAD MFA login using Keychain-backed TOTP"
  homepage "https://github.com/silee-tools/cli/tree/main/apps/saml2aws-auto"
  version "0.0.0"
  license "MIT"

  depends_on "silee-tools/tap/totp"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/silee-tools/cli/releases/download/saml2aws-auto/v#{version}/saml2aws-auto-v#{version}-darwin-arm64.tar.gz"
      sha256 "0000000000000000000000000000000000000000000000000000000000000000"
    end
    if Hardware::CPU.intel?
      url "https://github.com/silee-tools/cli/releases/download/saml2aws-auto/v#{version}/saml2aws-auto-v#{version}-darwin-amd64.tar.gz"
      sha256 "0000000000000000000000000000000000000000000000000000000000000000"
    end
  end

  on_linux do
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/silee-tools/cli/releases/download/saml2aws-auto/v#{version}/saml2aws-auto-v#{version}-linux-amd64.tar.gz"
      sha256 "0000000000000000000000000000000000000000000000000000000000000000"
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/silee-tools/cli/releases/download/saml2aws-auto/v#{version}/saml2aws-auto-v#{version}-linux-arm64.tar.gz"
      sha256 "0000000000000000000000000000000000000000000000000000000000000000"
    end
  end

  def install
    bin.install "saml2aws-auto-login"
  end

  def caveats
    <<~EOS
      saml2aws-auto-login 은 saml2aws CLI 를 별도로 요구합니다:
        brew install saml2aws

      환경변수:
        SAML2AWS_USERNAME              # saml2aws CLI native (필수)
        SAML2AWS_AUTO_TOTP_NAME        # Keychain TOTP 항목 이름 (기본: "MS: $SAML2AWS_USERNAME")
    EOS
  end

  test do
    assert_match "saml2aws-auto-login", shell_output("#{bin}/saml2aws-auto-login --help 2>&1")
  end
end
