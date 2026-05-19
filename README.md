# homebrew-tap

Homebrew formulae for silee-tools projects.

## Usage

```sh
brew tap silee-tools/tap
brew install jg
brew install totp
```

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
| jg | A frecency-based CLI for quickly jumping to Git repositories |
| totp | macOS Keychain-backed TOTP code generator |
