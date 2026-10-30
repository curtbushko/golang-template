# Golang Template

This template adds basic settings for starting a golang project.

## Included

### flake.nix and .envrc

A nice way to setup tooling. Run `direnv allow` to enable envrc to load settings.

**Note:** Requires that you are using nix. If you are on Mac, use the [Determinate Systems](https://determinate.systems/nix-installer/) nix installer. 

### Taskfile.yml

Tasks for building, linting and testing. Run `task --list` for available tasks.

**Note:** the build task assumes that the binary to build is the basename of the current repo.

Pre-commit hooks run `task build`, `task lint` and `task test`.

### Linting

`task lint` runs `go vet`, `golangci-lint` and `go-ai-lint`. The Nix dev shell provides the tools and shared lint configurations. Architecture linting is not included.

### .gitignore

Standard golang .gitignore file

## WARRANY

There is no warranty for this template. Use at your own *risk*. There be dragons.
