cask "komorebi-switcher" do
  version "0.9.0"
  sha256 "abb592aa0a8c55f86c5ae3e9bd9e92a7a724c53a339fe4f480793773881dea38"

  url "https://github.com/amrbashir/komorebi-switcher/releases/download/v#{version}/komorebi-switcher.dmg"
  name "komorebi-switcher"
  desc "Minimal switcher for Komorebi tiling manager, integrated into the menu bar"
  homepage "https://github.com/amrbashir/komorebi-switcher"

  livecheck do
    url :url
    strategy :github_latest
  end

  app "komorebi-switcher.app"
  binary "#{appdir}/komorebi-switcher.app/Contents/MacOS/komorebi-switcher"

  postflight do
    system_command "/usr/bin/xattr", args: ["-d", "com.apple.quarantine", "#{appdir}/komorebi-switcher.app"]
    system_command "/usr/bin/codesign", args: ["--force", "--deep", "--sign", "-", "#{appdir}/komorebi-switcher.app"]
  end
end
