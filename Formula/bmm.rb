# typed: false
# frozen_string_literal: true

# beautiful-mermaid-cli 의 명령어 이름은 bmm. release-please.yml 의 bun build
# --compile 이 4 target prebuilt + checksums.txt 를 만든다.
class Bmm < Formula
  desc "A thin CLI wrapper around beautiful-mermaid for rendering Mermaid diagrams"
  homepage "https://github.com/silee-tools/cli/tree/main/apps/beautiful-mermaid-cli"
  version "0.2.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/silee-tools/cli/releases/download/beautiful-mermaid-cli/v#{version}/beautiful-mermaid-cli-v#{version}-darwin-arm64.tar.gz"
      sha256 "6f1e6ada19be003ebfae509eb65722109e1fac860506344c055f7b67c7e394d5"
    end
    if Hardware::CPU.intel?
      url "https://github.com/silee-tools/cli/releases/download/beautiful-mermaid-cli/v#{version}/beautiful-mermaid-cli-v#{version}-darwin-amd64.tar.gz"
      sha256 "f3d8c5c193383cbb292348b970f0eeaa43744fb5cbd2e67eb68452dfba8c27e7"
    end
  end

  on_linux do
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/silee-tools/cli/releases/download/beautiful-mermaid-cli/v#{version}/beautiful-mermaid-cli-v#{version}-linux-amd64.tar.gz"
      sha256 "c0a2588680b257f40b03d29fbe330150504b23187418bc037f05f9541547a299"
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/silee-tools/cli/releases/download/beautiful-mermaid-cli/v#{version}/beautiful-mermaid-cli-v#{version}-linux-arm64.tar.gz"
      sha256 "d7c2eaa85ca7edfa862b4149e47335911710c4a22d26755c819288763b264711"
    end
  end

  def install
    # bun --compile 산출물은 ${tool}-${version}-${os}-${arch}/ 디렉토리 안에 들어 있음
    bin.install "bmm"
  end

  test do
    assert_match "bmm", shell_output("#{bin}/bmm --help")
  end
end
