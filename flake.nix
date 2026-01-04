{
  description = "An NixOS flake template that you can adapt to your own system";

  # Flake inputs
  inputs = {
    nixpkgs.url = "https://flakehub.com/f/NixOS/nixpkgs/0"; # Stable Nixpkgs (use 0.1 for unstable)
    determinate = {
      url = "https://flakehub.com/f/DeterminateSystems/determinate/3"; # Determinate 3.*
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-wsl = {
      url = "github:nix-community/NixOS-WSL";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  # Flake outputs
  outputs =
    { self, ... }@inputs:
    let
      # Change this if you're building for a system type other than x86 AMD Linux
      system = "x86_64-linux";

      # The flake output name of your system (`nixosConfigurations.${key}`). Change this
      # to make it less generic
      name = "nixos-wsl";
    in
    {
      # A minimal (but updatable!) NixOS configuration output by this flake
      nixosConfigurations.${name} = inputs.nixpkgs.lib.nixosSystem {
        inherit system;

        # NixOS modules
        modules = [
          # Load the Determinate module, which provides Determinate Nix
          inputs.determinate.nixosModules.default

          # Load the NixOS-WSL module
          inputs.nixos-wsl.nixosModules.default

          # Load the hardware configuration from a separate file (a common convention for NixOS)
          ./hardware-configuration.nix
          ./configuration.nix
          # This module provides a minimum viable NixOS configuration
          (
            { config, lib, ... }:
            {
              # Note: bootloader is configured by NixOS-WSL module
              system.stateVersion = "25.05";
            }
          )
        ];

        specialArgs = {
          # Values to pass to modules
        };
      };

      # Nix formatter

      # This applies the formatter that follows RFC 166, which defines a standard format:
      # https://github.com/NixOS/rfcs/pull/166

      # To format all Nix files:
      # git ls-files -z '*.nix' | xargs -0 -r nix fmt
      # To check formatting:
      # git ls-files -z '*.nix' | xargs -0 -r nix develop --command nixfmt --check
      formatter.${system} = inputs.nixpkgs.legacyPackages.${system}.nixfmt-rfc-style;
    };
}
