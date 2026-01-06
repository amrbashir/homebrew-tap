cask "komorebi-switcher" do
  version "0.9.2"
  sha256 "0721745ccd7563801b824d5ea8669950b63628f442058d6c7789cd1a0b909d8c"

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
