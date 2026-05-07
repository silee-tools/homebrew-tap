# typed: false
# frozen_string_literal: true

class Bmm < Formula
  desc "A thin CLI wrapper around beautiful-mermaid for rendering Mermaid diagrams"
  homepage "https://github.com/silee-tools/beautiful-mermaid-cli"
  version "0.1.7"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/silee-tools/beautiful-mermaid-cli/releases/download/v0.1.7/bmm-v0.1.7-darwin-arm64.tar.gz"
      sha256 "26a33dbbc23372f9d74a2dff27dfae6f5ad12fa7f001587a69b75684c76a712d"
    end
    if Hardware::CPU.intel?
      url "https://github.com/silee-tools/beautiful-mermaid-cli/releases/download/v0.1.7/bmm-v0.1.7-darwin-amd64.tar.gz"
      sha256 "bcd30d6910e982e8502ad4515921c0b2de48f16a107d65426691e53a46b65fac"
    end
  end

  on_linux do
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/silee-tools/beautiful-mermaid-cli/releases/download/v0.1.7/bmm-v0.1.7-linux-amd64.tar.gz"
      sha256 "363e2491ec66a3b025c4f5b264da4bf771d0fca6a29e3a9fcba9e2b54b7b20f6"
    end
  end

  def install
    bin.install "bmm"
  end

  test do
    assert_match "bmm", shell_output("#{bin}/bmm --help")
  end
end
