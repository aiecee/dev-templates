{
  description = "A nix-flake-based nodejs development environment";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";
  };

  outputs = { self, nixpkgs }:
    let
      allSystems = [
        "x86_64-linux"
        "aarch64-linux"
        "x86_64-darwin"
        "aarch64-darwin"
      ];
      forAllSystems = f: nixpkgs.lib.genAttrs allSystems (system: f {
        pkgs = import nixpkgs { inherit system; };
      });
    in
    {
      devShells = forAllSystems ({ pkgs }: {
        default = pkgs.mkShell {
          packages = with pkgs;
            [
              nodejs
              nodePackages.typescript
              nodePackages.typescript-language-server
              nodePackages.vscode-langservers-extracted
              nodePackages."@tailwindcss/language-server"
            ];
        };
      });
    };
}
