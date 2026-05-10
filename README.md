# homebrew-tap

Homebrew formulae for silee-tools projects.

## Usage

```sh
brew tap silee-tools/tap
brew install jg
brew install saml2aws-auto
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
| jg | A frecency-based CLI for quickly jumping to Git repositories |
| saml2aws-auto | Automatic saml2aws AzureAD MFA login using Keychain-backed TOTP |
| totp | macOS Keychain-backed TOTP code generator |
