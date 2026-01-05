# Nix Development Environment Module
#
# This module provides a complete Nix development setup including:
# - Language servers (nil, nixd)
# - Formatters (nixfmt, alejandra)
# - Linters (statix, deadnix)
# - Debugging tools (nix-tree, nom)
# - Enhanced direnv with nix-direnv caching
# - Micro editor with LSP plugin pre-configured
# - Shell aliases for common workflows
#
# Usage:
#   Import this module in your configuration.nix or home.nix:
#   imports = [ ./nix-dev ];

{ ... }:

{
  imports = [
    ./packages.nix # System-level Nix development packages
    ./home.nix # Home Manager configuration (direnv, micro)
    ./micro-lsp.nix # Micro editor LSP plugin and configuration
    ./shell-aliases.nix # Shell aliases for productivity
  ];
}
