class Bmm < Formula
  desc "A thin CLI wrapper around beautiful-mermaid for rendering Mermaid diagrams"
  homepage "https://github.com/silee-tools/beautiful-mermaid-cli"
  version "0.1.2"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/silee-tools/beautiful-mermaid-cli/releases/download/v0.1.2/bmm-v0.1.2-darwin-arm64.tar.gz"
      sha256 "51d685cb87a713cb87db20b4eb0ab5ff9ada3f3dddd5e9bad676e5e6c927b749"
    end
    if Hardware::CPU.intel?
      url "https://github.com/silee-tools/beautiful-mermaid-cli/releases/download/v0.1.2/bmm-v0.1.2-darwin-amd64.tar.gz"
      sha256 "5ae6798935a02ebda4b6fd0eda65f1f5696ebf8cfed6686c06b116ef8945029d"
    end
  end

  on_linux do
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/silee-tools/beautiful-mermaid-cli/releases/download/v0.1.2/bmm-v0.1.2-linux-amd64.tar.gz"
      sha256 "fd37dc4fc68f5c303f9b86210e849339138d07a2ef6437847af148d61dcdafd2"
    end
  end

  def install
    bin.install "bmm"
  end

  test do
    assert_match "bmm", shell_output("#{bin}/bmm --help")
  end
end
