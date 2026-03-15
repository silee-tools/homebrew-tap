# typed: false
# frozen_string_literal: true

class Mydesk < Formula
  desc "macOS config backup & sync tool (Mackup alternative)"
  homepage "https://github.com/silee9019/mydesk"
  url "https://github.com/silee9019/mydesk/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "0019dfc4b32d63c1392aa264aed2253c1e0c2fb09216f8e2cc269bbfb8bb49b5"
  license "MIT"

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
