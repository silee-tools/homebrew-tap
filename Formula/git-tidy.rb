# typed: false
# frozen_string_literal: true

# silee-tools/cli 모노레포 prebuilt 바이너리. release-please.yml 의 GoReleaser
# 가 4종 tar.gz + checksums.txt 를 GitHub Release 에 첨부하고, 그 후속 step 의
# scripts/update-homebrew-formula.py 가 version + sha256 라인을 자동 갱신한다.
# URL 에 #{version} 인터폴레이션 사용 — 스크립트는 version 만 교체하면 URL 도 자동 추적.
class GitTidy < Formula
  desc "A CLI tool that finds done or stale local branches and batch-deletes them"
  homepage "https://github.com/silee-tools/cli/tree/main/apps/git-tidy"
  version "0.5.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/silee-tools/cli/releases/download/git-tidy/v#{version}/git-tidy-v#{version}-darwin-arm64.tar.gz"
      sha256 "aa2fb68c7fe59198c90b1de8f64e80aa365dae78b6ff9a1efef456bdba219b37"
    end
    if Hardware::CPU.intel?
      url "https://github.com/silee-tools/cli/releases/download/git-tidy/v#{version}/git-tidy-v#{version}-darwin-amd64.tar.gz"
      sha256 "ecd454095e082e21ebfc893adabaa82e99a4d5a6fdd7620b0f4b202f5d636c17"
    end
  end

  on_linux do
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/silee-tools/cli/releases/download/git-tidy/v#{version}/git-tidy-v#{version}-linux-amd64.tar.gz"
      sha256 "6d3f046d5766e8a22ce2b5f099449535e78754ffbf9fd6aa48aee78a7bbd7365"
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/silee-tools/cli/releases/download/git-tidy/v#{version}/git-tidy-v#{version}-linux-arm64.tar.gz"
      sha256 "0851e8620049a9ba7a28b951ed20d4b320db31163b1563ed9aea6a99fdb213cb"
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
