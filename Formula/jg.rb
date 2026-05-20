# typed: false
# frozen_string_literal: true

# silee-tools/cli 모노레포 prebuilt 바이너리. release-please.yml 의 GoReleaser
# 가 4종 tar.gz + checksums.txt 를 GitHub Release 에 첨부하고, 그 후속 step 의
# scripts/update-homebrew-formula.py 가 version + sha256 라인을 자동 갱신한다.
# URL 에 #{version} 인터폴레이션 사용 — 스크립트는 version 만 교체하면 URL 도 자동 추적.
class Jg < Formula
  desc "A frecency-based CLI for quickly jumping to Git repositories"
  homepage "https://github.com/silee-tools/cli/tree/main/apps/jg"
  version "0.4.0"
  license "MIT"

  depends_on "fzf"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/silee-tools/cli/releases/download/jg/v#{version}/jg-v#{version}-darwin-arm64.tar.gz"
      sha256 "3af3be58d834fe687ce29507c5b4a560544f6419e0144b99157e8b688bd418de"
    end
    if Hardware::CPU.intel?
      url "https://github.com/silee-tools/cli/releases/download/jg/v#{version}/jg-v#{version}-darwin-amd64.tar.gz"
      sha256 "2a573bcf934f82a412ed356edf51d2d6dc3b89edb7aa622e3165f0332430301c"
    end
  end

  on_linux do
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/silee-tools/cli/releases/download/jg/v#{version}/jg-v#{version}-linux-amd64.tar.gz"
      sha256 "401409502c4f715b5270731effead12807bb191e004c9cf68bf524bd2b99885a"
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/silee-tools/cli/releases/download/jg/v#{version}/jg-v#{version}-linux-arm64.tar.gz"
      sha256 "089d0f3bf32a008748412b9339e3aebeb7ad78ce873425dbcd4ecbce930d823f"
    end
  end

  def install
    bin.install "jg"
    bin.install_symlink "jg" => "jgw"
    zsh_completion.install "completions/_jg"
    zsh_completion.install "completions/_jgw"
    bash_completion.install "completions/jg.bash" => "jg"
    bash_completion.install "completions/jgw.bash" => "jgw"
    (share/"jg"/"plugin").install "plugin/jg.plugin.zsh"
    (share/"jg"/"plugin").install "plugin/jg.plugin.bash"
  end

  def caveats
    <<~EOS
      Run 'jg setup' to configure shell integration,
      then restart your shell or run: exec $SHELL

      jgw is installed alongside jg as a sibling command for jumping
      between git worktrees of the same repo (or across repos).
    EOS
  end

  test do
    assert_match "jg", shell_output("#{bin}/jg --help 2>&1")
  end
end
