cask "komorebi-switcher" do
  version "0.9.1"
  sha256 "deef5da9e3a0e76b42e3e4a9ea75dcdc9d8a77de9992379583349ed619f1cf7e"

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
