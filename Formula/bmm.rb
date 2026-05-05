# typed: false
# frozen_string_literal: true

class Bmm < Formula
  desc "A thin CLI wrapper around beautiful-mermaid for rendering Mermaid diagrams"
  homepage "https://github.com/silee-tools/beautiful-mermaid-cli"
  version "0.1.4"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/silee-tools/beautiful-mermaid-cli/releases/download/v0.1.4/bmm-v0.1.4-darwin-arm64.tar.gz"
      sha256 "d47dd97691c158ef75fffb268484660e3ca8d18fc040b934007cda3a4d8c2430"
    end
    if Hardware::CPU.intel?
      url "https://github.com/silee-tools/beautiful-mermaid-cli/releases/download/v0.1.4/bmm-v0.1.4-darwin-amd64.tar.gz"
      sha256 "065d7de0450ecf9594d7569cbc66d41e78d0b232d5049cabe59821dd3ed889b6"
    end
  end

  on_linux do
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/silee-tools/beautiful-mermaid-cli/releases/download/v0.1.4/bmm-v0.1.4-linux-amd64.tar.gz"
      sha256 "645a5cf86a9c4d7c4bf0860e0072874e821de4cf0a33882c39a068b773ea17a9"
    end
  end

  def install
    bin.install "bmm"
  end

  test do
    assert_match "bmm", shell_output("#{bin}/bmm --help")
  end
end
