# Nix development tools - System-level packages
{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # Language servers
    nil # Nix LSP
    nixd # Alternative Nix LSP

    # Formatters
    nixfmt # Standard formatter
    nixfmt-tree # Tree-based formatter
    alejandra # Alternative fast formatter

    # Linting & Analysis
    statix # Nix linter
    deadnix # Find dead Nix code

    # Debugging & Visualization
    nix-tree # Dependency tree visualizer
    nix-output-monitor # Better build output (nom)

    # Documentation & Search
    manix # Nix documentation searcher
    fh # FlakeHub CLI
  ];
}
