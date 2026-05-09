# typed: false
# frozen_string_literal: true

class Unid < Formula
  desc "DSL → Unicode block diagram CLI"
  homepage "https://github.com/silee-tools/cli/tree/main/apps/unid"
  version "0.4.1"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/silee-tools/cli/releases/download/unid/v#{version}/unid-v#{version}-darwin-arm64.tar.gz"
      sha256 "59fdff6cc82a4dd262efb2421f0152616d6dd818ed48bfd40c6a2454da3db8a7"
    end
    if Hardware::CPU.intel?
      url "https://github.com/silee-tools/cli/releases/download/unid/v#{version}/unid-v#{version}-darwin-amd64.tar.gz"
      sha256 "1817f4e68ee6ae386431680cd2943ee3af8cded3e7add50140a111591705ceb5"
    end
  end

  on_linux do
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/silee-tools/cli/releases/download/unid/v#{version}/unid-v#{version}-linux-amd64.tar.gz"
      sha256 "f23c70d93677d7582a475450ae251d15967df74a0e5560e22715ae7b85808f90"
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/silee-tools/cli/releases/download/unid/v#{version}/unid-v#{version}-linux-arm64.tar.gz"
      sha256 "d2fcd3b426d94322ae61e549b30a299789495221fc302bbf682f4b92710cfec7"
    end
  end

  def install
    bin.install "unid"
  end

  test do
    assert_match "unid", shell_output("#{bin}/unid --help 2>&1")
  end
end
