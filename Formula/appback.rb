# typed: false
# frozen_string_literal: true

class Appback < Formula
  desc "Mac app settings backup & restore CLI"
  homepage "https://github.com/silee-tools/appback"
  url "https://github.com/silee-tools/appback/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "17c81f6dd499e1a326fcfb93fa838bdd6b151f76cede265a20808e07c7dd1aec"
  license "MIT"

  head "https://github.com/silee-tools/appback.git", branch: "main"

  depends_on "gum"
  depends_on :macos

  def install
    bin.install "appback"
    (share/"appback/apps").install Dir["apps/*"]
    (share/"appback/completions").install Dir["completions/*"]
    bash_completion.install "completions/appback.bash" => "appback"
  end

  def caveats
    <<~EOS
      Zsh/Fish 사용자는 직접 completions을 설정하세요:
        eval "$(appback --completions)"
    EOS
  end

  test do
    assert_match "appback", shell_output("#{bin}/appback --help")
  end
end
