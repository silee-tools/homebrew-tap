# typed: false
# frozen_string_literal: true

# silee-tools/cli 모노레포 prebuilt 바이너리. release-please.yml 의 GoReleaser
# 가 4종 tar.gz + checksums.txt 를 GitHub Release 에 첨부하고, 그 후속 step 의
# scripts/update-homebrew-formula.py 가 version + sha256 라인을 자동 갱신한다.
# URL 에 #{version} 인터폴레이션 사용 — 스크립트는 version 만 교체하면 URL 도 자동 추적.
class GitTidy < Formula
  desc "A CLI tool that finds done or stale local branches and batch-deletes them"
  homepage "https://github.com/silee-tools/cli/tree/main/apps/git-tidy"
  version "0.7.3"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/silee-tools/cli/releases/download/git-tidy/v#{version}/git-tidy-v#{version}-darwin-arm64.tar.gz"
      sha256 "958ebe4170d30c2a9212d350242e53ffbba8fdcf711ae7de325286ba6c03ec01"
    end
    if Hardware::CPU.intel?
      url "https://github.com/silee-tools/cli/releases/download/git-tidy/v#{version}/git-tidy-v#{version}-darwin-amd64.tar.gz"
      sha256 "c6fd9c3b0c44782406d5acdeb3d99cb507c71a2324c18b0e93648370330bcc14"
    end
  end

  on_linux do
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/silee-tools/cli/releases/download/git-tidy/v#{version}/git-tidy-v#{version}-linux-amd64.tar.gz"
      sha256 "7bbf6bf1fb30aa5ba4827ff072f84eee2142f517bba0e3946e87ee47f22a86bf"
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/silee-tools/cli/releases/download/git-tidy/v#{version}/git-tidy-v#{version}-linux-arm64.tar.gz"
      sha256 "3e849bd92bb986f6f532f4363f509c923f2b6b400c207c3f8a01e8e498112770"
    end
  end

  def install
    bin.install "git-tidy"
    bin.install_symlink "git-tidy" => "gtidy"
    bin.install_symlink "git-tidy" => "gtidy!"
    zsh_completion.install "completions/_git-tidy"
    bash_completion.install "completions/git-tidy.bash" => "git-tidy"
  end

  def post_install
    state_dir = var/"silee-tools"/"git-tidy"
    state_dir.mkpath
    state_file = state_dir/"active-channel"
    temp_file = state_dir/"active-channel.tmp-#{Process.pid}"
    temp_file.write <<~EOS
      channel=release
    EOS
    temp_file.rename state_file
  end

  test do
    assert_match "git-tidy", shell_output("#{bin}/git-tidy --help 2>&1")
  end
end
