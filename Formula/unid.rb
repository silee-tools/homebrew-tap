# typed: false
# frozen_string_literal: true

class Unid < Formula
  desc "CLI tool for rendering ASCII diagrams using Unicode box-drawing characters"
  homepage "https://github.com/silee-tools/unid"
  version "0.3.4"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/silee-tools/unid/releases/download/v0.3.4/unid-v0.3.4-aarch64-apple-darwin.tar.gz"
      sha256 "2a7fedcdc7342b3a385b623d0b9adbad126f07cb2d68081389421bc5cb2a9260"
    end
  end

  on_linux do
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/silee-tools/unid/releases/download/v0.3.4/unid-v0.3.4-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "fbdc3ac4ca05edc86b43240593154c9271c7570d3ebf0bd356da879822786b8d"
    end
  end

  def install
    bin.install "unid"
  end

  test do
    assert_match "unid", shell_output("#{bin}/unid --help 2>&1")
  end
end
