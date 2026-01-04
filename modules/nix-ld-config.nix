# VSCode/VSCodium Remote-WSL configuration for nix-ld
# This module sets up environment variables for the VSCode server
# Based on: https://discourse.nixos.org/t/vscode-remote-wsl-extension-works-on-nixos-without-patching-thanks-to-nix-ld/14615

{
  config,
  lib,
  pkgs,
  username,
  ...
}:

with lib;

let
  cfg = config.nix-ld-config;
in
{
  options.nix-ld-config = {
    enable = mkEnableOption "VSCode/VSCodium server environment setup for nix-ld";

    user = mkOption {
      type = types.str;
      default = username;
      description = "User for which to set up VSCode server environment";
    };
  };

  config = mkIf cfg.enable {
    programs.nix-ld.enable = true;

    # Create server-env-setup script for VSCode/VSCodium server using home-manager
    # The VSCode server doesn't pick up NixOS environment variables automatically
    # so we need to write them to a file that gets sourced
    home-manager.users.${cfg.user} = {
      home.file.".vscode-server/server-env-setup".text = ''
        export NIX_LD="${pkgs.stdenv.cc.bintools.dynamicLinker}"
        export NIX_LD_LIBRARY_PATH="${
          lib.makeLibraryPath [
            pkgs.stdenv.cc.cc
            pkgs.zlib
            pkgs.openssl
            pkgs.curl
            pkgs.icu
            pkgs.gcc-unwrapped
          ]
        }"
      '';

      home.file.".vscodium-server/server-env-setup".text = ''
        export NIX_LD="${pkgs.stdenv.cc.bintools.dynamicLinker}"
        export NIX_LD_LIBRARY_PATH="${
          lib.makeLibraryPath [
            pkgs.stdenv.cc.cc
            pkgs.zlib
            pkgs.openssl
            pkgs.curl
            pkgs.icu
            pkgs.gcc-unwrapped
          ]
        }"
      '';
    };
  };
}
