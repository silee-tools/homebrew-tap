# typed: false
# frozen_string_literal: true

# silee-tools/cli 모노레포 prebuilt 바이너리. release-please.yml 의 GoReleaser
# 가 4종 tar.gz + checksums.txt 를 GitHub Release 에 첨부하고, 그 후속 step 의
# scripts/update-homebrew-formula.py 가 version + sha256 라인을 자동 갱신한다.
# URL 에 #{version} 인터폴레이션 사용 — 스크립트는 version 만 교체하면 URL 도 자동 추적.
class GitTidy < Formula
  desc "A CLI tool that finds done or stale local branches and batch-deletes them"
  homepage "https://github.com/silee-tools/cli/tree/main/apps/git-tidy"
  version "0.7.2"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/silee-tools/cli/releases/download/git-tidy/v#{version}/git-tidy-v#{version}-darwin-arm64.tar.gz"
      sha256 "056cc9e5c93295067315da5b449c4a04c0c81d8f0bb725d8901bd547cc71f850"
    end
    if Hardware::CPU.intel?
      url "https://github.com/silee-tools/cli/releases/download/git-tidy/v#{version}/git-tidy-v#{version}-darwin-amd64.tar.gz"
      sha256 "633fcdb2ba7940b635ce368d5b9ca217b8760fe250f012082062735613b70cf4"
    end
  end

  on_linux do
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/silee-tools/cli/releases/download/git-tidy/v#{version}/git-tidy-v#{version}-linux-amd64.tar.gz"
      sha256 "d621c59c59136ec00bb431f91f2285f0fbbc7d84f672e9c49f0921efc183d211"
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/silee-tools/cli/releases/download/git-tidy/v#{version}/git-tidy-v#{version}-linux-arm64.tar.gz"
      sha256 "a1675b9c4028e8142d40b138bcefb0d5239867522ce7477c66a2f630a2f1c669"
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
