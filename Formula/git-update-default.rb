# typed: false
# frozen_string_literal: true

# silee-tools/cli 모노레포 prebuilt 바이너리. release-please.yml 의 GoReleaser
# 가 4종 tar.gz + checksums.txt 를 GitHub Release 에 첨부하고, 그 후속 step 의
# scripts/update-homebrew-formula.py 가 version + sha256 라인을 자동 갱신한다.
# URL 에 #{version} 인터폴레이션 사용 — 스크립트는 version 만 교체하면 URL 도 자동 추적.
class GitUpdateDefault < Formula
  desc "Switch the current repo to the latest remote default branch"
  homepage "https://github.com/silee-tools/cli/tree/main/apps/git-update-default"
  version "0.2.1"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/silee-tools/cli/releases/download/git-update-default/v#{version}/git-update-default-v#{version}-darwin-arm64.tar.gz"
      sha256 "f729a22c6ebbf266b144a047bbc931d384a8852144da1b5619b2d61ce260651b"
    end
    if Hardware::CPU.intel?
      url "https://github.com/silee-tools/cli/releases/download/git-update-default/v#{version}/git-update-default-v#{version}-darwin-amd64.tar.gz"
      sha256 "30e44013df871b52d4351da878c902a3e98ab0f1f2000ae1c578d728d86d95d7"
    end
  end

  on_linux do
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/silee-tools/cli/releases/download/git-update-default/v#{version}/git-update-default-v#{version}-linux-amd64.tar.gz"
      sha256 "c863288e2a1c1f75d963d13ea6233aeab07ed42709e59da51588e57df5467158"
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/silee-tools/cli/releases/download/git-update-default/v#{version}/git-update-default-v#{version}-linux-arm64.tar.gz"
      sha256 "2a3e01b21fa695b87a65fe5a5c6d04d103c5fb614caa844990c101184082c415"
    end
  end

  def install
    bin.install "git-update-default"
    zsh_completion.install "completions/_git-update-default"
    bash_completion.install "completions/git-update-default.bash" => "git-update-default"
  end

  def post_install
    state_dir = var/"silee-tools"/"git-update-default"
    state_dir.mkpath
    state_file = state_dir/"active-channel"
    temp_file = state_dir/"active-channel.tmp-#{Process.pid}"
    temp_file.write <<~EOS
      channel=release
    EOS
    temp_file.rename state_file
  end

  test do
    assert_match "git-update-default", shell_output("#{bin}/git-update-default --help 2>&1")
  end
end
