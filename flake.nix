{
  description = "Golang flake";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

  outputs = { self, nixpkgs }:
    let
      goVersion = 25; # Change this to update the whole stack

      supportedSystems = [ "x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin" ];
      forEachSupportedSystem = f: nixpkgs.lib.genAttrs supportedSystems (system: f {
        pkgs = import nixpkgs {
          inherit system;
          config.allowUnfree = true;
          overlays = [ self.overlays.default ];
        };
      });
    in
    {
      overlays.default = final: prev: {
        go = final."go_1_${toString goVersion}";
        go-task = prev.go-task.overrideAttrs (oldAttrs: rec {
          version = "3.46.1";
          src = prev.fetchFromGitHub {
            owner = "go-task";
            repo = "task";
            rev = "v${version}";
            hash = "sha256-CKUL2/XB8bGne+9troYnpJFfmAGTAwOihyb3caj1OdA=";
          };
          vendorHash = "sha256-Tm0tqureCRwcP5KKDTa9TO1yZ3Px3ulf9/jKQDDTjDw=";
          ldflags = [
            "-s"
            "-w"
            "-X=github.com/go-task/task/v3/internal/version.version=${version}"
          ];
        });
      };

      devShells = forEachSupportedSystem ({ pkgs }: {
        default = pkgs.mkShell {
          packages = with pkgs; [
            docker
            # go (version is specified by overlay)
            go
            go-task
            gotools
            golangci-lint
          ];

          shellHook = ''
            # Generate ~/.taskrc.yml for go-task configuration
            mkdir -p ~/.task
            cat > ~/.taskrc.yml << 'EOF'
remote:
  insecure: true
  offline: true
  timeout: "30s"
  cache-expiry: "24h"
  cache-dir: ~/.task
  trusted-hosts:
    - github.com
EOF
            echo "Golang development environment loaded"
            echo "Go version: $(go version)"
          '';
        };
      });
    };
}
