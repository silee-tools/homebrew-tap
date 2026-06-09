# typed: false
# frozen_string_literal: true

# silee-tools/cli 모노레포 prebuilt 바이너리. release-please.yml 의 GoReleaser
# 가 4종 tar.gz + checksums.txt 를 GitHub Release 에 첨부하고, 그 후속 step 의
# scripts/update-homebrew-formula.py 가 version + sha256 라인을 자동 갱신한다.
# URL 에 #{version} 인터폴레이션 사용 — 스크립트는 version 만 교체하면 URL 도 자동 추적.
class GitTidy < Formula
  desc "A CLI tool that finds done or stale local branches and batch-deletes them"
  homepage "https://github.com/silee-tools/cli/tree/main/apps/git-tidy"
  version "0.7.1"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/silee-tools/cli/releases/download/git-tidy/v#{version}/git-tidy-v#{version}-darwin-arm64.tar.gz"
      sha256 "63e4d9171fc3ec1f9cd340e6c7c19826e1030843c889ce4f91dcb71d0dc534f8"
    end
    if Hardware::CPU.intel?
      url "https://github.com/silee-tools/cli/releases/download/git-tidy/v#{version}/git-tidy-v#{version}-darwin-amd64.tar.gz"
      sha256 "950a73705aeb8ea46c5e8786ad8622f2f50594cc570f55ebf1b2276832b4dfdb"
    end
  end

  on_linux do
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/silee-tools/cli/releases/download/git-tidy/v#{version}/git-tidy-v#{version}-linux-amd64.tar.gz"
      sha256 "3b62aff6c76df192f0500931b127f95df8b22a2c7f1644e2add9afe7abd9fc7d"
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/silee-tools/cli/releases/download/git-tidy/v#{version}/git-tidy-v#{version}-linux-arm64.tar.gz"
      sha256 "fe703ece4cf9690b2046cd7ae6fe554d67c78c4c59d67fd881cded94f688e9a6"
    end
  end

  def install
    bin.install "git-tidy"
    bin.install_symlink "git-tidy" => "gtidy"
    bin.install_symlink "git-tidy" => "gtidy!"
    zsh_completion.install "completions/_git-tidy"
    bash_completion.install "completions/git-tidy.bash" => "git-tidy"
  end

  test do
    assert_match "git-tidy", shell_output("#{bin}/git-tidy --help 2>&1")
  end
end
