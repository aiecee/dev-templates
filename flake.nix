{
  description = "Collection of nix templates I use for development";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  };

  outputs = { self, nixpkgs }: {
    templates = {
      kotlin = {
        path = ./kotlin;
        description = "Kotlin dev environment";
      };
      node = {
        path = ./node;
        description = "Nodejs dev environment";
      };
    };
  };
}
