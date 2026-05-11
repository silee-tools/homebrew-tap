# typed: false
# frozen_string_literal: true

# saml2aws-auto. saml2aws 로그인 자동화와 zsh 세션 체크를 제공하는 Go CLI.
class Saml2awsAuto < Formula
  desc "Automatic saml2aws AzureAD MFA login using Keychain-backed TOTP"
  homepage "https://github.com/silee-tools/cli/tree/main/apps/saml2aws-auto"
  version "2.0.2"
  license "MIT"

  depends_on "silee-tools/tap/totp"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/silee-tools/cli/releases/download/saml2aws-auto/v#{version}/saml2aws-auto-v#{version}-darwin-arm64.tar.gz"
      sha256 "81aa3fc8705db5616f3fdfc7cc9000de52a629608628b99ab4a5c38c76ee356f"
    end
    if Hardware::CPU.intel?
      url "https://github.com/silee-tools/cli/releases/download/saml2aws-auto/v#{version}/saml2aws-auto-v#{version}-darwin-amd64.tar.gz"
      sha256 "533a310aa77c425098811565b7bf54ff4875b2e5be5556f18ade02c3deaa4e5f"
    end
  end

  on_linux do
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/silee-tools/cli/releases/download/saml2aws-auto/v#{version}/saml2aws-auto-v#{version}-linux-amd64.tar.gz"
      sha256 "23ccfd2beff117fa22667aff38678d6318101249b8e227d2d5d882db9a2e1746"
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/silee-tools/cli/releases/download/saml2aws-auto/v#{version}/saml2aws-auto-v#{version}-linux-arm64.tar.gz"
      sha256 "58b47a2b8daea096175319b107643f8b519471dd64299ef9a8230cfa245d1216"
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
