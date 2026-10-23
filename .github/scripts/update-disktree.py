"""Update the DiskTree cask from the latest stable upstream GitHub release."""

import hashlib
import io
import json
import os
from pathlib import Path
import re
from urllib.request import Request, urlopen
import zipfile


def download(url):
    headers = {"User-Agent": "amrbashir-homebrew-tap-updater"}
    # Only send the GitHub API credential to the API, never to release downloads.
    if url.startswith("https://api.github.com/") and os.environ.get("GH_TOKEN"):
        headers["Authorization"] = f"Bearer {os.environ['GH_TOKEN']}"
    with urlopen(Request(url, headers=headers), timeout=120) as response:
        return response.read()


def main():
    path = Path(__file__).resolve().parents[2] / "Casks" / "disktree.rb"
    original = path.read_text(encoding="utf-8")
    release = json.loads(download("https://api.github.com/repos/tobi/disktree/releases/latest"))
    tag = release["tag_name"]
    if not re.fullmatch(r"v\d+\.\d+\.\d+", tag):
        raise ValueError(f"Unexpected release tag: {tag!r}")
    if release["draft"] or release["prerelease"]:
        raise ValueError("Expected a stable, published release")
    version = tag[1:]
    if re.search(rf'^  version "{re.escape(version)}"$', original, re.MULTILINE):
        print(f"DiskTree {version} is already current")
        return

    assets = {asset["name"]: asset["browser_download_url"] for asset in release["assets"]}
    hashes = {}
    for arch in ("aarch64", "x86_64"):
        name = f"disktree-{version}-{arch}-macos.zip"
        url = assets[name]
        expected_url = f"https://github.com/tobi/disktree/releases/download/{tag}/{name}"
        if url != expected_url:
            raise ValueError(f"Unexpected asset URL: {url!r}")
        archive = download(url)
        digest = hashlib.sha256(archive).hexdigest()
        checksum = download(assets[name + ".sha256"]).decode().split()[0].lower()
        if digest != checksum:
            raise ValueError(f"SHA256 mismatch for {name}")
        with zipfile.ZipFile(io.BytesIO(archive)) as bundle:
            if "disktree.app/Contents/MacOS/disktree" not in bundle.namelist():
                raise ValueError(f"App executable missing from {name}")
            if bundle.testzip() is not None:
                raise ValueError(f"Corrupt archive: {name}")
        hashes[arch] = digest

    updated, versions = re.subn(r'^  version "[^"]+"$', f'  version "{version}"', original, flags=re.MULTILINE)
    updated, checksums = re.subn(
        r'  sha256 arm:   "[a-f0-9]{64}",\n         intel: "[a-f0-9]{64}"',
        f'  sha256 arm:   "{hashes["aarch64"]}",\n         intel: "{hashes["x86_64"]}"',
        updated,
    )
    if versions != 1 or checksums != 1:
        raise ValueError("Cask format changed; refusing to write a partial update")
    path.write_text(updated, encoding="utf-8", newline="\n")
    print(f"Updated DiskTree to {version}; verified both macOS archives and SHA256 checksums")


if __name__ == "__main__":
    main()
