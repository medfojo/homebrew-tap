# typed: false
# frozen_string_literal: true

class TagboardTui < Formula
  desc "Cloud-backed terminal note-taking client"
  homepage "https://github.com/medfojo/tagboard"
  version "0.0.0"

  on_macos do
    on_arm do
      url "https://github.com/medfojo/tagboard/releases/download/v#{version}/tagboard-tui-darwin-arm64"
      sha256 "0000000000000000000000000000000000000000000000000000000000000000"
    end

    on_intel do
      url "https://github.com/medfojo/tagboard/releases/download/v#{version}/tagboard-tui-darwin-amd64"
      sha256 "0000000000000000000000000000000000000000000000000000000000000000"
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
