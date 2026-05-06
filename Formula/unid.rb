# typed: false
# frozen_string_literal: true

class Unid < Formula
  desc "CLI tool for rendering ASCII diagrams using Unicode box-drawing characters"
  homepage "https://github.com/silee-tools/unid"
  version "0.3.6"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/silee-tools/unid/releases/download/v0.3.6/unid-v0.3.6-aarch64-apple-darwin.tar.gz"
      sha256 "796ee523c2d7dbe742914da94580726d6eb3bea16907608c954c4a4ca0e80005"
    end
  end

  on_linux do
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/silee-tools/unid/releases/download/v0.3.6/unid-v0.3.6-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "864c06dd7b94693f2e6010ebe32a81389fdaf817d42162265ccc6b75834a8c77"
    end
  end

  def install
    bin.install "unid"
  end

  test do
    assert_match "unid", shell_output("#{bin}/unid --help 2>&1")
  end
end
