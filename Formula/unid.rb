# typed: false
# frozen_string_literal: true

class Unid < Formula
  desc "DSL → Unicode block diagram CLI"
  homepage "https://github.com/silee-tools/cli/tree/main/apps/unid"
  version "0.3.6"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/silee-tools/cli/releases/download/unid/v#{version}/unid-v#{version}-darwin-arm64.tar.gz"
      sha256 "0000000000000000000000000000000000000000000000000000000000000000"
    end
    if Hardware::CPU.intel?
      url "https://github.com/silee-tools/cli/releases/download/unid/v#{version}/unid-v#{version}-darwin-amd64.tar.gz"
      sha256 "0000000000000000000000000000000000000000000000000000000000000000"
    end
  end

  on_linux do
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/silee-tools/cli/releases/download/unid/v#{version}/unid-v#{version}-linux-amd64.tar.gz"
      sha256 "0000000000000000000000000000000000000000000000000000000000000000"
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/silee-tools/cli/releases/download/unid/v#{version}/unid-v#{version}-linux-arm64.tar.gz"
      sha256 "0000000000000000000000000000000000000000000000000000000000000000"
    end
  end

  def install
    bin.install "unid"
  end

  test do
    assert_match "unid", shell_output("#{bin}/unid --help 2>&1")
  end
end
