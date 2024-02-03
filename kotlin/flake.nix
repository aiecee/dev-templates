{
  description = "A nix-flake-based Kotlin development environment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  };

  outputs = { self, nixpkgs }:
    let
      javaVersion = 20;
      overlays = [
        (final: prev: rec {
          jdk = prev."jdk${toString javaVersion}";
          gradle = prev.gradle.override {
            java = jdk;
          };
          kotlin = prev.kotlin.override {
            jre = jdk;
          };
        })
      ];
      supportedSystems = [ "x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin" ];
      forEachSupportSystem = f: nixpkgs.lib.genAttrs supportedSystems (system: f {
        pkgs = import nixpkgs { inherit system; };
      });
    in
    {
      devShells = forEachSupportSystem ({ pkgs }: {
        default = pkgs.mkShell {
          packages = with pkgs; [ kotlin gradle jdk kotlin-language-server ktfmt ktlint detekt ];
        };
      });
    };
}
