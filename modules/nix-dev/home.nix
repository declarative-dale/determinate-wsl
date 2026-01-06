# Nix development tools - Home Manager configuration
{ pkgs, ... }:

{
  programs = {
    # Enhanced direnv with nix-direnv for faster dev shells
    # This caches the dev shell instead of rebuilding every time
    direnv = {
      enable = true;
      enableBashIntegration = true;
      enableZshIntegration = true;
      nix-direnv.enable = true;
    };

    # Enable micro editor
    # Note: Detailed micro configuration is in micro-lsp.nix
    micro.enable = true;
  };
}
