cask "komorebi-switcher" do
  version "0.10.3"
  sha256 "dcf7380894bb2efc1b9c1533d19196cee64ab63450db5fc0d1452069c6e740e8"

  url "https://github.com/amrbashir/komorebi-switcher/releases/download/v#{version}/komorebi-switcher.dmg"
  name "komorebi-switcher"
  desc "Minimal switcher for Komorebi tiling manager, integrated into the menu bar"
  homepage "https://github.com/amrbashir/komorebi-switcher"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on :macos

  app "komorebi-switcher.app"
  binary "#{appdir}/komorebi-switcher.app/Contents/MacOS/komorebi-switcher"

  postflight_steps do
    run "/usr/bin/xattr", args: ["-d", "com.apple.quarantine", "{{appdir}}/komorebi-switcher.app"]
    run "/usr/bin/codesign", args: ["--force", "--deep", "--sign", "-", "{{appdir}}/komorebi-switcher.app"]
  end
end
