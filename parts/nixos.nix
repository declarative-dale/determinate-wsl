# Flake module for NixOS configuration
# Uses flake-parts to organize the NixOS system configuration

{ inputs, ... }:
{
  flake =
    let
      # Configuration variables
      username = "nixos";
      hostname = "nixos-wsl";
    in
    {
      # NixOS system configuration
      nixosConfigurations.${hostname} = inputs.nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";

        specialArgs = {
          inherit username;
        };

        modules = [
          # Third-party modules
          inputs.determinate.nixosModules.default
          inputs.nixos-wsl.nixosModules.default
          inputs.nix-ld.nixosModules.nix-ld
          inputs.home-manager.nixosModules.home-manager

          # Local modules (auto-imports all .nix files from modules/)
          ../modules

          # System state version
          { system.stateVersion = "25.05"; }
        ];
      };
    };
}
