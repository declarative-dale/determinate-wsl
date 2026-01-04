# VSCode/VSCodium Remote-WSL configuration for nix-ld
# Sets up environment variables for VSCode server
# Reference: https://discourse.nixos.org/t/vscode-remote-wsl-extension-works-on-nixos-without-patching-thanks-to-nix-ld/14615

{
  config,
  lib,
  pkgs,
  username,
  ...
}:

let
  cfg = config.nix-ld-config;

  # Server environment setup script
  serverEnvSetup = ''
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
in
{
  options.nix-ld-config = {
    enable = lib.mkEnableOption "VSCode/VSCodium server environment setup for nix-ld";

    user = lib.mkOption {
      type = lib.types.str;
      default = username;
      description = "User for which to set up VSCode server environment";
    };
  };

  config = lib.mkIf cfg.enable {
    # Create server-env-setup files for VSCode/VSCodium
    # VSCode server doesn't pick up NixOS environment variables automatically
    home-manager.users.${cfg.user}.home.file = {
      ".vscode-server/server-env-setup".text = serverEnvSetup;
      ".vscodium-server/server-env-setup".text = serverEnvSetup;
    };
  };
}
