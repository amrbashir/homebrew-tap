cask "komorebi-switcher" do
  version "0.10.2"
  sha256 "8bd5ca938b30994a9f692b32cd7f79effee4fb44fec82e4bd564bc796f95075f"

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
