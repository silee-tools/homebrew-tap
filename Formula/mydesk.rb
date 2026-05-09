# typed: false
# frozen_string_literal: true

class Mydesk < Formula
  desc "macOS config backup & sync tool (Mackup alternative)"
  homepage "https://github.com/silee-tools/cli/tree/main/apps/mydesk"
  version "0.3.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/silee-tools/cli/releases/download/mydesk/v#{version}/mydesk-v#{version}-darwin-arm64.tar.gz"
      sha256 "4784c04af4248f30cd5e756ba4eb2bd194698cab1c76b109cdbdbc85f435e4ee"
    end
    if Hardware::CPU.intel?
      url "https://github.com/silee-tools/cli/releases/download/mydesk/v#{version}/mydesk-v#{version}-darwin-amd64.tar.gz"
      sha256 "a7dbe551701dc545614fe4cfa24e7f5c8a89ef51d252ee69d502e0a4e41520d7"
    end
  end

  on_linux do
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/silee-tools/cli/releases/download/mydesk/v#{version}/mydesk-v#{version}-linux-amd64.tar.gz"
      sha256 "c090dc2e18dda1f0c6937e080b99d150ed6d97138d6ec69edc5e5948470c5de5"
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/silee-tools/cli/releases/download/mydesk/v#{version}/mydesk-v#{version}-linux-arm64.tar.gz"
      sha256 "b767dc4b13b9c60a772fa26643ebf65b57208d83992fb96817af1bf2c0fe9139"
    end
  end

  def install
    bin.install "mydesk"
  end

  def caveats
    <<~EOS
      Run 'mydesk install-shell' to configure shell integration,
      then restart your shell or run: source ~/.zprofile
    EOS
  end

  test do
    assert_match "mydesk", shell_output("#{bin}/mydesk help 2>&1")
  end
end
