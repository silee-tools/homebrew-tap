# typed: false
# frozen_string_literal: true

# saml2aws-auto. saml2aws 로그인 자동화와 zsh 세션 체크를 제공하는 Go CLI.
class Saml2awsAuto < Formula
  desc "Automatic saml2aws AzureAD MFA login using Keychain-backed TOTP"
  homepage "https://github.com/silee-tools/cli/tree/main/apps/saml2aws-auto"
  version "2.0.3"
  license "MIT"

  depends_on "silee-tools/tap/totp"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/silee-tools/cli/releases/download/saml2aws-auto/v#{version}/saml2aws-auto-v#{version}-darwin-arm64.tar.gz"
      sha256 "d370569dc64df515a8a5679b1116b4642ae7034b4b68d854b3302bb2d0e796fd"
    end
    if Hardware::CPU.intel?
      url "https://github.com/silee-tools/cli/releases/download/saml2aws-auto/v#{version}/saml2aws-auto-v#{version}-darwin-amd64.tar.gz"
      sha256 "6a2a42636ad4908b05919b140c27dba7097728f951359613e008edf98a9814f6"
    end
  end

  on_linux do
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/silee-tools/cli/releases/download/saml2aws-auto/v#{version}/saml2aws-auto-v#{version}-linux-amd64.tar.gz"
      sha256 "9541c512d6692c395d086798e866c3846698edcd0eaafba4da2c0052f323afc4"
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/silee-tools/cli/releases/download/saml2aws-auto/v#{version}/saml2aws-auto-v#{version}-linux-arm64.tar.gz"
      sha256 "1c1d87622d18b9e0863dfc330dc1ddac17cb29f93c05ccf3fcd1ff537f03599d"
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
