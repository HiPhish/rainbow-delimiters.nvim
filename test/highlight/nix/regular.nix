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

      formatting = pre-commit-hooks.lib.${system}.run {
        src = self;
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
      packages = {
      };
      checks = {
        inherit formatting;
      };
    });
}
