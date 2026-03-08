# typed: false
# frozen_string_literal: true

class TagboardTui < Formula
  desc "Cloud-backed terminal note-taking client"
  homepage "https://github.com/medfojo/tagboard"
  version "0.4.0"

  on_macos do
    on_arm do
      url "https://github.com/medfojo/tagboard/releases/download/v#{version}/tagboard-tui-darwin-arm64"
      sha256 "242f49cf7c804f71a4153ab6cccf5bb11dc401e1520db93822e8eccdb955f6a5"
    end

    on_intel do
      url "https://github.com/medfojo/tagboard/releases/download/v#{version}/tagboard-tui-darwin-amd64"
      sha256 "d75ba3181219a1f1c21cb70f2fc1f7b47fd41282aa85bde1c938ebd190460bdb"
    end
  end

  def install
    if Hardware::CPU.arm?
      bin.install "tagboard-tui-darwin-arm64" => "tagboard-tui"
    else
      bin.install "tagboard-tui-darwin-amd64" => "tagboard-tui"
    end
  end

  test do
    assert_match "tagboard-tui version", shell_output("#{bin}/tagboard-tui --version")
  end
end
