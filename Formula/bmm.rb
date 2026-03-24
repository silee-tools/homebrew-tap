class Bmm < Formula
  desc "A thin CLI wrapper around beautiful-mermaid for rendering Mermaid diagrams"
  homepage "https://github.com/silee-tools/beautiful-mermaid-cli"
  version "0.1.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/silee-tools/beautiful-mermaid-cli/releases/download/v0.1.0/bmm-v0.1.0-darwin-arm64.tar.gz"
      sha256 "54fa69198c1038c259a0089f2512c1dcd5828f452ccb6cab19785f4bd8e48602"
    end
    if Hardware::CPU.intel?
      url "https://github.com/silee-tools/beautiful-mermaid-cli/releases/download/v0.1.0/bmm-v0.1.0-darwin-amd64.tar.gz"
      sha256 "13838e72125ef8c88d97afbaa26e42d463340ed5940e535a23c55a40fbc28a17"
    end
  end

  on_linux do
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/silee-tools/beautiful-mermaid-cli/releases/download/v0.1.0/bmm-v0.1.0-linux-amd64.tar.gz"
      sha256 "318f3dfca11dfea6fd2be288e884347f4c5afa506c414cb9f706cca031066700"
    end
  end

  def install
    bin.install "bmm"
  end

  test do
    assert_match "bmm", shell_output("#{bin}/bmm --help")
  end
end
