# typed: false
# frozen_string_literal: true

# git-tidy. Go 바이너리가 없는 순수 zsh 플러그인. silee-tools/cli 모노레포의
# release-please.yml 이 빌드 없이 git-tidy-v#{version}.tar.gz + checksums.txt 만
# 첨부하고, 후속 step 의 scripts/update-homebrew-formula.py 가 version + sha256
# 라인을 자동 갱신한다. 플랫폼 독립이라 OS/Arch 분기와 depends_on 이 없다.
class GitTidy < Formula
  desc "Safely deletes local branches whose upstream is gone"
  homepage "https://github.com/silee-tools/cli/tree/main/apps/git-tidy"
  version "0.1.0"
  license "MIT"

  url "https://github.com/silee-tools/cli/releases/download/git-tidy/v#{version}/git-tidy-v#{version}.tar.gz"
  sha256 "0000000000000000000000000000000000000000000000000000000000000000"

  def install
    (share/"git-tidy").install "git-tidy.plugin.zsh"
  end

  def caveats
    <<~EOS
      zsh plugin 로드 — ~/.zshrc 에 추가:
        source "#{share}/git-tidy/git-tidy.plugin.zsh"

      사용:
        git-tidy            # dry-run (삭제 대상만 표시)
        git-tidy --run      # 실제 삭제
        git-tidy --help     # 사용법
    EOS
  end

  test do
    assert_path_exists share/"git-tidy/git-tidy.plugin.zsh"
  end
end
