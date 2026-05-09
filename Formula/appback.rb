# typed: false
# frozen_string_literal: true

# appback 은 Bash 스크립트 도구. release-please.yml 이 source archive 를 패킹.
# 단일 tar.gz 안에 appback-v<X.Y.Z>/ 디렉토리가 있고 그 안에 appback 스크립트 +
# completions + apps 설정 파일들.
class Appback < Formula
  desc "Mac app settings backup & restore CLI"
  homepage "https://github.com/silee-tools/cli/tree/main/apps/appback"
  version "0.3.0"
  url "https://github.com/silee-tools/cli/releases/download/appback/v#{version}/appback-v#{version}.tar.gz"
  sha256 "60887e11592583a1245572f3f7db2470c1e15735936864dc1dd06c5b188619f0"
  license "MIT"

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
