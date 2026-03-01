# typed: false
# frozen_string_literal: true

class TagboardTui < Formula
  desc "Cloud-backed terminal note-taking client"
  homepage "https://github.com/medfojo/tagboard"
  version "0.1.0"

  on_macos do
    on_arm do
      url "https://github.com/medfojo/tagboard/releases/download/v#{version}/tagboard-tui-darwin-arm64"
      sha256 "82d17123b8c85130bcf9fee50f0ba18048be3446ca76f5d74d02daa61ed4cdc9"
    end

    on_intel do
      url "https://github.com/medfojo/tagboard/releases/download/v#{version}/tagboard-tui-darwin-amd64"
      sha256 "520802359c9ba2aa0802f76f05185a8409b70f0d204da0198bd47d8a28566866"
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
