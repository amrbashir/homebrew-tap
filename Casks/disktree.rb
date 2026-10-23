cask "disktree" do
  arch arm: "aarch64", intel: "x86_64"

  version "0.11.0"
  sha256 arm:   "942f2508fbbbd6901f796494492b16250d52227155b0ab59f6a5a446b033600b",
         intel: "16ddba6c3d983651cb6389d1c7fd6a070ba443aafcf03c2bc857e35e73b43f4d"

  url "https://github.com/tobi/disktree/releases/download/v#{version}/disktree-#{version}-#{arch}-macos.zip"
  name "DiskTree"
  desc "Disk usage treemap for finding and removing what fills your disk"
  homepage "https://github.com/tobi/disktree"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: ">= :big_sur"

  app "disktree.app"
  binary "#{appdir}/disktree.app/Contents/MacOS/disktree"
end
