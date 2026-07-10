# homebrew-tap

Homebrew formulae for silee-tools projects.

## Usage

```sh
brew tap silee-tools/tap
brew install git-tidy
brew install git-update-default
brew install jg
brew install totp
```

`totp` uses macOS Keychain and is available on macOS only.

## Local verification

Run the repository hygiene check before changing formulae or tap metadata:

```sh
mise run lint
```

If `mise` is not available, run both underlying scripts directly:

```sh
sh scripts/check-editorconfig-hygiene.sh
sh scripts/check-runtime-channel-contract.sh
```

GitHub Actions checks Formula syntax and the runtime channel contract whenever Formula files, the contract script, the mise task, or the workflow changes.

## Shell integration

`jg` requires an explicit setup command after installation. This matches the formula caveats shown by Homebrew:

```sh
jg setup
```

Restart your shell after running the setup command for the tool you installed.

## Formulae

| Formula | Description |
|---------|-------------|
| git-tidy | Safely deletes local branches whose upstream is gone |
| git-update-default | Switch the current repo to the latest remote default branch |
| jg | A frecency-based CLI for quickly jumping to Git repositories |
| totp | macOS Keychain-backed TOTP code generator |
