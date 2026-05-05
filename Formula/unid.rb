# typed: false
# frozen_string_literal: true

class Unid < Formula
  desc "CLI tool for rendering ASCII diagrams using Unicode box-drawing characters"
  homepage "https://github.com/silee-tools/unid"
  version "0.3.5"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/silee-tools/unid/releases/download/v0.3.5/unid-v0.3.5-aarch64-apple-darwin.tar.gz"
      sha256 "b96bce9817ee81237d377b5ddd11d1ebf63d3ac64cc489d524b15dc5b339e636"
    end
  end

  on_linux do
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/silee-tools/unid/releases/download/v0.3.5/unid-v0.3.5-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "bb055b3cbe57725908d96941edcea680e219c0430a570df9f0151646bec62279"
    end
  end

  def install
    bin.install "unid"
  end

  test do
    assert_match "unid", shell_output("#{bin}/unid --help 2>&1")
  end
end
