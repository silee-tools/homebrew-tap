# typed: false
# frozen_string_literal: true

class Bmm < Formula
  desc "A thin CLI wrapper around beautiful-mermaid for rendering Mermaid diagrams"
  homepage "https://github.com/silee-tools/beautiful-mermaid-cli"
  version "0.1.6"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/silee-tools/beautiful-mermaid-cli/releases/download/v0.1.6/bmm-v0.1.6-darwin-arm64.tar.gz"
      sha256 "a34022507ca3578f52d90edf7355b458a2511d8616a6985ab4d1f13ba8a3ff67"
    end
    if Hardware::CPU.intel?
      url "https://github.com/silee-tools/beautiful-mermaid-cli/releases/download/v0.1.6/bmm-v0.1.6-darwin-amd64.tar.gz"
      sha256 "09115326af7cecf9d047c89a9a0d56731e4358d6931c40491b18c0814de58a3c"
    end
  end

  on_linux do
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/silee-tools/beautiful-mermaid-cli/releases/download/v0.1.6/bmm-v0.1.6-linux-amd64.tar.gz"
      sha256 "51184fe5f0fdb8d47b86d3d4c47751daf2c0dbab2dab866f0d7ced69ed4bc4c7"
    end
  end

  def install
    bin.install "bmm"
  end

  test do
    assert_match "bmm", shell_output("#{bin}/bmm --help")
  end
end
