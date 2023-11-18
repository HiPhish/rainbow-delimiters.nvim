{
  description = "Test flake for rainbow-delimiters.nvim";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";

    pre-commit-hooks = {
      url = "github:cachix/pre-commit-hooks.nix";
    };

    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = {
    self,
    nixpkgs,
    flake-utils,
    pre-commit-hooks,
    ...
  }: let
    supportedSystems = [
      "x86_64-linux"
    ];
  in
    flake-utils.lib.eachSystem supportedSystems (system: let
      inherit (nixpkgs) lib;
      pkgs = nixpkgs.legacyPackages.${system};

      formatting = pre-commit-hooks.lib.${system}.run {
        src = lib.cleanSource self;
        hooks = {
          alejandra.enable = true;
          markdownlint.enable = true;
        };
        settings = {
          markdownlint.config = {
            MD004 = false;
          };
        };
      };
    in {
      apps = rec {
        hi = with pkgs; flake-utils.lib.mkApp {
          drv = writeShellScriptBin "hi" ''
            echo "Hello, world"
          '';
        };
        default = hi;
      };
      packages = {
      };
      checks = {
        inherit formatting;
      };
    });
}
