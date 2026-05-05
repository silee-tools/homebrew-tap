# typed: false
# frozen_string_literal: true

class Bmm < Formula
  desc "A thin CLI wrapper around beautiful-mermaid for rendering Mermaid diagrams"
  homepage "https://github.com/silee-tools/beautiful-mermaid-cli"
  version "0.1.5"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/silee-tools/beautiful-mermaid-cli/releases/download/v0.1.5/bmm-v0.1.5-darwin-arm64.tar.gz"
      sha256 "b89c302612cf7aaa75414b8a5ea2abea015e940430eeae9f2052763221463205"
    end
    if Hardware::CPU.intel?
      url "https://github.com/silee-tools/beautiful-mermaid-cli/releases/download/v0.1.5/bmm-v0.1.5-darwin-amd64.tar.gz"
      sha256 "ad20cee3adaa9fd409b79163140dce0cfa60507a5fd3102e8be802acd326447b"
    end
  end

  on_linux do
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/silee-tools/beautiful-mermaid-cli/releases/download/v0.1.5/bmm-v0.1.5-linux-amd64.tar.gz"
      sha256 "4e46dd3b8299f43a8a63dc3b4cfacce640f21102f7aad1fc3018397b41f8e85c"
    end
  end

  def install
    bin.install "bmm"
  end

  test do
    assert_match "bmm", shell_output("#{bin}/bmm --help")
  end
end
