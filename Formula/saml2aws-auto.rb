# typed: false
# frozen_string_literal: true

# saml2aws-auto. saml2aws 로그인 자동화와 zsh 세션 체크를 제공하는 Go CLI.
class Saml2awsAuto < Formula
  desc "Automatic saml2aws AzureAD MFA login using Keychain-backed TOTP"
  homepage "https://github.com/silee-tools/cli/tree/main/apps/saml2aws-auto"
  version "2.0.7"
  license "MIT"

  depends_on "silee-tools/tap/totp"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/silee-tools/cli/releases/download/saml2aws-auto/v#{version}/saml2aws-auto-v#{version}-darwin-arm64.tar.gz"
      sha256 "2285c164ec3ccd9ecde0d21676e2f217b7a7d8053dc316da8a69b8a023dab073"
    end
    if Hardware::CPU.intel?
      url "https://github.com/silee-tools/cli/releases/download/saml2aws-auto/v#{version}/saml2aws-auto-v#{version}-darwin-amd64.tar.gz"
      sha256 "1dc7dcb2921f54e577d9cde6a4ec17aea6323b2bc845a4096600eafa5b2917ab"
    end
  end

  on_linux do
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/silee-tools/cli/releases/download/saml2aws-auto/v#{version}/saml2aws-auto-v#{version}-linux-amd64.tar.gz"
      sha256 "5f119fadc70f685eb42875bcf00911806cad03f460ae51fe0cdfd962c4b454e0"
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/silee-tools/cli/releases/download/saml2aws-auto/v#{version}/saml2aws-auto-v#{version}-linux-arm64.tar.gz"
      sha256 "3354789beafacfa8bdfffe1cf4839f694e0a62604b2128b60c4054ec0f8d4ba0"
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
        if (( $+commands[saml2aws-auto] )); then
          local saml2aws_auto_bin="${commands[saml2aws-auto]:A}"
          local saml2aws_auto_plugin="${saml2aws_auto_bin:h:h}/share/saml2aws-auto/saml2aws-auto.plugin.zsh"
          [[ -f "$saml2aws_auto_plugin" ]] && source "$saml2aws_auto_plugin"
          unset saml2aws_auto_bin saml2aws_auto_plugin
        fi

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
