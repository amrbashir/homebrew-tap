cask "komorebi-switcher" do
  version "0.9.0"
  sha256 "abb592aa0a8c55f86c5ae3e9bd9e92a7a724c53a339fe4f480793773881dea38"

  url "https://github.com/amrbashir/komorebi-switcher/releases/download/v#{version}/komorebi-switcher.dmg",
      verified: "github.com/amrbashir/komorebi-switcher/"
  name "komorebi-switcher"
  desc "A minimal workspace switcher for the Komorebi tiling window manager, seamlessly integrated into Windows 10/11 taskbar or macOS menu bar."
  homepage "https://github.com/amrbashir/komorebi-switcher"

  livecheck do
    url :url
    strategy :github_latest
  end

  app "komorebi-switcher.app"
end
