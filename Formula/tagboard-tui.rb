# typed: false
# frozen_string_literal: true

class TagboardTui < Formula
  desc "Cloud-backed terminal note-taking client"
  homepage "https://github.com/medfojo/tagboard"
  version "0.3.0"

  on_macos do
    on_arm do
      url "https://github.com/medfojo/tagboard/releases/download/v#{version}/tagboard-tui-darwin-arm64"
      sha256 "ea9503adfb7fe88560406a626d0bf20f19d84de9c8d5392552601d9a6f6eccda"
    end

    on_intel do
      url "https://github.com/medfojo/tagboard/releases/download/v#{version}/tagboard-tui-darwin-amd64"
      sha256 "95d4204597e2367842d76086c1b6bdc6193767f0019b2f714e1dddcd4faa5751"
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
