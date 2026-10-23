# Amrbashir Tap

## DiskTree

```sh
brew install --cask amrbashir/tap/disktree
```

Supports Apple Silicon and Intel Macs running macOS 11 or later. Upgrade with
`brew upgrade --cask disktree`.

The Update DiskTree workflow checks upstream releases every four hours and commits
the version and SHA256 hashes automatically after verifying both macOS downloads.
It can also be run manually from the Actions tab. If GitHub disables scheduled
workflows after repository inactivity, re-enable it there.

## How do I install these formulae?

`brew install amrbashir/tap/<formula>`

Or `brew tap amrbashir/tap` and then `brew install <formula>`.

Or, in a `brew bundle` `Brewfile`:

```ruby
tap "amrbashir/tap"
brew "<formula>"
```

## Documentation

`brew help`, `man brew` or check [Homebrew's documentation](https://docs.brew.sh).
