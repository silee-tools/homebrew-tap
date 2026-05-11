# typed: false
# frozen_string_literal: true

# saml2aws-auto. saml2aws 로그인 자동화와 zsh 세션 체크를 제공하는 Go CLI.
class Saml2awsAuto < Formula
  desc "Automatic saml2aws AzureAD MFA login using Keychain-backed TOTP"
  homepage "https://github.com/silee-tools/cli/tree/main/apps/saml2aws-auto"
  version "2.0.6"
  license "MIT"

  depends_on "silee-tools/tap/totp"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/silee-tools/cli/releases/download/saml2aws-auto/v#{version}/saml2aws-auto-v#{version}-darwin-arm64.tar.gz"
      sha256 "06d59cbc1c39a7c6f4468d55a5ca99f3c4422735cc99f8d5f5a36881e99597c2"
    end
    if Hardware::CPU.intel?
      url "https://github.com/silee-tools/cli/releases/download/saml2aws-auto/v#{version}/saml2aws-auto-v#{version}-darwin-amd64.tar.gz"
      sha256 "d40c99c7da3e30afcda875785f4028f1753801c7b0bb7abc58be30cb9daa2f5e"
    end
  end

  on_linux do
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/silee-tools/cli/releases/download/saml2aws-auto/v#{version}/saml2aws-auto-v#{version}-linux-amd64.tar.gz"
      sha256 "aa5385545df9c3d01c92ef0f517c604f8367691b1cba6cad9910e049756e9919"
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/silee-tools/cli/releases/download/saml2aws-auto/v#{version}/saml2aws-auto-v#{version}-linux-arm64.tar.gz"
      sha256 "27e9fe4636d88aee2c1dabd051d6d2b797ac39f39e2a5b76b888a8a71faaaa9d"
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
