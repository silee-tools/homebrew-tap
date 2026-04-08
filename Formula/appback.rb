# typed: false
# frozen_string_literal: true

class Appback < Formula
  desc "Mac app settings backup & restore CLI"
  homepage "https://github.com/silee-tools/appback"
  url "https://github.com/silee-tools/appback/archive/refs/tags/v0.2.1.tar.gz"
  sha256 "e15b570e9fb6c7be2cd24e20c3f8685a0a0d8352a81c044675d0a617d8bb0b3e"
  license "MIT"

  head "https://github.com/silee-tools/appback.git", branch: "main"

  depends_on "gum"
  depends_on :macos

  def install
    bin.install "appback"
    (share/"appback/apps").install Dir["apps/*"]
    bash_completion.install "completions/appback.bash" => "appback"
    zsh_completion.install "completions/_appback"
    # appback --completions 지원을 위해 share에 symlink 생성
    (share/"appback/completions").mkpath
    ln_s bash_completion/"appback", share/"appback/completions/appback.bash"
    ln_s zsh_completion/"_appback", share/"appback/completions/_appback"
  end

  test do
    assert_match "appback", shell_output("#{bin}/appback --help")
  end
end
