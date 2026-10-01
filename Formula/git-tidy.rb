# typed: false
# frozen_string_literal: true

# silee-tools/cli 모노레포 prebuilt 바이너리. release-please.yml 의 GoReleaser
# 가 4종 tar.gz + checksums.txt 를 GitHub Release 에 첨부하고, 그 후속 step 의
# scripts/update-homebrew-formula.py 가 version + sha256 라인을 자동 갱신한다.
# URL 에 #{version} 인터폴레이션 사용 — 스크립트는 version 만 교체하면 URL 도 자동 추적.
class GitTidy < Formula
  desc "A CLI tool that finds done or stale local branches and batch-deletes them"
  homepage "https://github.com/silee-tools/cli/tree/main/apps/git-tidy"
  version "0.8.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/silee-tools/cli/releases/download/git-tidy/v#{version}/git-tidy-v#{version}-darwin-arm64.tar.gz"
      sha256 "2ef42007032087d96422f466ebe33cb1453de89b0a3ffb9f982009d6eefcbd11"
    end
    if Hardware::CPU.intel?
      url "https://github.com/silee-tools/cli/releases/download/git-tidy/v#{version}/git-tidy-v#{version}-darwin-amd64.tar.gz"
      sha256 "bfefe29434789df7f4db5717bcab7dbc6af7b7b0ff5be814bd75f17aa520d985"
    end
  end

  on_linux do
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/silee-tools/cli/releases/download/git-tidy/v#{version}/git-tidy-v#{version}-linux-amd64.tar.gz"
      sha256 "4da8557896cf2d0ad9602a67982bd17d5fe75832d3e5260b8cc780eaa4a1575c"
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/silee-tools/cli/releases/download/git-tidy/v#{version}/git-tidy-v#{version}-linux-arm64.tar.gz"
      sha256 "64dfe5de41a9e63df6f7f6b249dec451e6cedb79a5c391abc993f1db668950d0"
    end
  end

  def install
    bin.install "git-tidy"
    bin.install_symlink "git-tidy" => "gtidy"
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
