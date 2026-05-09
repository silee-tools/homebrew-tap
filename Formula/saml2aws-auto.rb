# typed: false
# frozen_string_literal: true

# saml2aws-auto-login (formula 명: saml2aws-auto). 외부 의존 0 의 Go CLI.
class Saml2awsAuto < Formula
  desc "Automatic saml2aws AzureAD MFA login using Keychain-backed TOTP"
  homepage "https://github.com/silee-tools/cli/tree/main/apps/saml2aws-auto"
  version "1.0.0"
  license "MIT"

  depends_on "silee-tools/tap/totp"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/silee-tools/cli/releases/download/saml2aws-auto/v#{version}/saml2aws-auto-v#{version}-darwin-arm64.tar.gz"
      sha256 "5a4e79f72c3fc3c87fc7c030ed18003dfbc2525e1a3daf89e329b26626526d9d"
    end
    if Hardware::CPU.intel?
      url "https://github.com/silee-tools/cli/releases/download/saml2aws-auto/v#{version}/saml2aws-auto-v#{version}-darwin-amd64.tar.gz"
      sha256 "c334c9066b0193dd7a855c884a0d974f00b354bfe02795556f492c865ffa2c76"
    end
  end

  on_linux do
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/silee-tools/cli/releases/download/saml2aws-auto/v#{version}/saml2aws-auto-v#{version}-linux-amd64.tar.gz"
      sha256 "c9eac1b07b992ed31bf1e7e98984d35d25f4f81293a7247a9c21f145c24bc854"
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/silee-tools/cli/releases/download/saml2aws-auto/v#{version}/saml2aws-auto-v#{version}-linux-arm64.tar.gz"
      sha256 "a6abc78944e5a265036e222aeebd3d7630e314462c65156518b1ac2049679d78"
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
