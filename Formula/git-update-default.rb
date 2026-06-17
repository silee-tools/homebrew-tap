# typed: false
# frozen_string_literal: true

# silee-tools/cli 모노레포 prebuilt 바이너리. release-please.yml 의 GoReleaser
# 가 4종 tar.gz + checksums.txt 를 GitHub Release 에 첨부하고, 그 후속 step 의
# scripts/update-homebrew-formula.py 가 version + sha256 라인을 자동 갱신한다.
# URL 에 #{version} 인터폴레이션 사용 — 스크립트는 version 만 교체하면 URL 도 자동 추적.
class GitUpdateDefault < Formula
  desc "Switch the current repo to the latest remote default branch"
  homepage "https://github.com/silee-tools/cli/tree/main/apps/git-update-default"
  version "0.1.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/silee-tools/cli/releases/download/git-update-default/v#{version}/git-update-default-v#{version}-darwin-arm64.tar.gz"
      sha256 "7ac9b52932229b9725c8cc71337ddbf6418a4b20ccb87b8ecef5a2a68d5b3be2"
    end
    if Hardware::CPU.intel?
      url "https://github.com/silee-tools/cli/releases/download/git-update-default/v#{version}/git-update-default-v#{version}-darwin-amd64.tar.gz"
      sha256 "fd8f3d1b3a3973b814125b1c4ca669ac56d738d6c2977426c5e9a63b54d30638"
    end
  end

  on_linux do
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/silee-tools/cli/releases/download/git-update-default/v#{version}/git-update-default-v#{version}-linux-amd64.tar.gz"
      sha256 "0d529def08a9108ebcb86eb250b6408d2ef9437918ba1b44fbbb3cb28ca1c07d"
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/silee-tools/cli/releases/download/git-update-default/v#{version}/git-update-default-v#{version}-linux-arm64.tar.gz"
      sha256 "bde95d8f0ce291bf9f35b79214d028707cf2a723ff9e535150cd9cadd7919968"
    end
  end

  def install
    bin.install "git-update-default"
    zsh_completion.install "completions/_git-update-default"
    bash_completion.install "completions/git-update-default.bash" => "git-update-default"
  end

  test do
    assert_match "git-update-default", shell_output("#{bin}/git-update-default --help 2>&1")
  end
end
