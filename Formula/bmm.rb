# typed: false
# frozen_string_literal: true

class Bmm < Formula
  desc "A thin CLI wrapper around beautiful-mermaid for rendering Mermaid diagrams"
  homepage "https://github.com/silee-tools/beautiful-mermaid-cli"
  version "0.1.3"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/silee-tools/beautiful-mermaid-cli/releases/download/v0.1.3/bmm-v0.1.3-darwin-arm64.tar.gz"
      sha256 "9cddc98d0934ab0d13e1c9a5e6f36616f57aaa8490756b9f84e5d901ec8ab45a"
    end
    if Hardware::CPU.intel?
      url "https://github.com/silee-tools/beautiful-mermaid-cli/releases/download/v0.1.3/bmm-v0.1.3-darwin-amd64.tar.gz"
      sha256 "4a43120d843716c5dc9a826eba3f503dbb54b676fb133bdc32d58fdd0b7600eb"
    end
  end

  on_linux do
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/silee-tools/beautiful-mermaid-cli/releases/download/v0.1.3/bmm-v0.1.3-linux-amd64.tar.gz"
      sha256 "04fc329f84820d6bc39e0af365f4b98aba26bf866ab9e289a58709ce5cea0e0e"
    end
  end

  def install
    bin.install "bmm"
  end

  test do
    assert_match "bmm", shell_output("#{bin}/bmm --help")
  end
end
