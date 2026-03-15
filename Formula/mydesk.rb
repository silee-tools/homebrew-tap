# typed: false
# frozen_string_literal: true

class Mydesk < Formula
  desc "macOS config backup & sync tool (Mackup alternative)"
  homepage "https://github.com/silee-tools/mydesk"
  url "https://github.com/silee-tools/mydesk/archive/refs/tags/v0.1.1.tar.gz"
  sha256 "ae3a98e28d8d17c8010e5c93128a2f289d2d2b0edad91fe284bbb785e0dc040d"
  license "MIT"

  head "https://github.com/silee-tools/mydesk.git", branch: "main"

  depends_on "go" => :build

  def install
    ldflags = "-s -w -X main.version=#{version}"
    system "go", "build", *std_go_args(ldflags: ldflags)
  end

  def caveats
    <<~EOS
      Run 'mydesk install-shell' to configure shell integration,
      then restart your shell or run: source ~/.zprofile
    EOS
  end

  test do
    assert_match "mydesk", shell_output("#{bin}/mydesk help 2>&1")
  end
end
