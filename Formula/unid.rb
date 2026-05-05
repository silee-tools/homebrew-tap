# typed: false
# frozen_string_literal: true

class Unid < Formula
  desc "CLI tool for rendering ASCII diagrams using Unicode box-drawing characters"
  homepage "https://github.com/silee-tools/unid"
  version "0.3.2"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/silee-tools/unid/releases/download/v0.3.2/unid-v0.3.2-aarch64-apple-darwin.tar.gz"
      sha256 "c9a671c2ab0b3e89bf693746964358432ee5f13cc59491e47be09754d81173ae"
    end
  end

  on_linux do
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/silee-tools/unid/releases/download/v0.3.2/unid-v0.3.2-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "08548ddad784d5336b5532d7597f162b18df45d27627bdca7b0d514c1b21dfa7"
    end
  end

  def install
    bin.install "unid"
  end

  test do
    assert_match "unid", shell_output("#{bin}/unid --help 2>&1")
  end
end
