# homebrew-tap

Homebrew formulae for silee-tools projects.

## Usage

```sh
brew tap silee-tools/tap
brew install appback
brew install bmm
brew install jg
brew install mydesk
```

## Shell integration

Some tools require an explicit setup command after installation. This matches the formula caveats shown by Homebrew:

```sh
jg setup
mydesk install-shell
```

Restart your shell after running the setup command for the tool you installed.

## Formulae

| Formula | Description |
|---------|-------------|
| appback | Mac app settings backup & restore CLI |
| bmm | A thin CLI wrapper around beautiful-mermaid for rendering Mermaid diagrams |
| jg | A frecency-based CLI for quickly jumping to Git repositories |
| mydesk | macOS config backup & sync tool (Mackup alternative) |
