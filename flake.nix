{
  description = "An NixOS flake template that you can adapt to your own system";

  # Flake inputs
  inputs = {
    nixpkgs.url = "https://flakehub.com/f/NixOS/nixpkgs/0"; # Stable Nixpkgs (use 0.1 for unstable)

    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };

    determinate = {
      url = "https://flakehub.com/f/DeterminateSystems/determinate/3"; # Determinate 3.*
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-wsl = {
      url = "github:nix-community/NixOS-WSL";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-ld = {
      url = "github:Mic92/nix-ld";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  # Flake outputs using flake-parts
  outputs =
    inputs:
    inputs.flake-parts.lib.mkFlake { inherit inputs; } {
      # Systems to support
      systems = [ "x86_64-linux" ];

      # Import flake modules for organization
      imports = [ ./parts/nixos.nix ];

      # Per-system outputs
      perSystem =
        { pkgs, ... }:
        {
          # Nix formatter (RFC 166)
          formatter = pkgs.nixfmt-rfc-style;

          # Development shell
          devShells.default = pkgs.mkShell {
            packages = with pkgs; [
              nixfmt-rfc-style
              git
            ];
            shellHook = ''
              echo "NixOS WSL development environment"
            '';
          };
        };
    };
}
