# typed: false
# frozen_string_literal: true

class Unid < Formula
  desc "CLI tool for rendering ASCII diagrams using Unicode box-drawing characters"
  homepage "https://github.com/silee-tools/unid"
  version "0.3.3"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/silee-tools/unid/releases/download/v0.3.3/unid-v0.3.3-aarch64-apple-darwin.tar.gz"
      sha256 "9a1721c39bc9d83e038ce309caf3fad94f3908aec8b7ecb05668e178d7806454"
    end
  end

  on_linux do
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/silee-tools/unid/releases/download/v0.3.3/unid-v0.3.3-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "612aeb95d6dbaaaa2644c8793207937da49ed444b71a8278ea9ab2a6d530129c"
    end
  end

  def install
    bin.install "unid"
  end

  test do
    assert_match "unid", shell_output("#{bin}/unid --help 2>&1")
  end
end
