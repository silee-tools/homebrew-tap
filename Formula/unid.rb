# typed: false
# frozen_string_literal: true

class Unid < Formula
  desc "DSL → Unicode block diagram CLI"
  homepage "https://github.com/silee-tools/cli/tree/main/apps/unid"
  version "0.4.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/silee-tools/cli/releases/download/unid/v#{version}/unid-v#{version}-darwin-arm64.tar.gz"
      sha256 "e97beac5def4ea1edcc32a889a5f7d6de95423f3c8d7654857730fad16034f11"
    end
    if Hardware::CPU.intel?
      url "https://github.com/silee-tools/cli/releases/download/unid/v#{version}/unid-v#{version}-darwin-amd64.tar.gz"
      sha256 "357ad1bf0a9756da7d865c188c7dadbeafa999d06642460fd77316856ee48c5e"
    end
  end

  on_linux do
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/silee-tools/cli/releases/download/unid/v#{version}/unid-v#{version}-linux-amd64.tar.gz"
      sha256 "785aa6e9f27eb9df1fbc0e5cfc35784315c2020d254d00412de6e37251c3befd"
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/silee-tools/cli/releases/download/unid/v#{version}/unid-v#{version}-linux-arm64.tar.gz"
      sha256 "fa9842669bd10c9e8170096a23ed8257a0ce9ded1f8cf7ed409fbb567518a79e"
    end
  end

  def install
    bin.install "unid"
  end

  test do
    assert_match "unid", shell_output("#{bin}/unid --help 2>&1")
  end
end
