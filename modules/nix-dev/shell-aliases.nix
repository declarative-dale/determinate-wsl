# Nix development tools - Shell aliases for productivity
{ ... }:

{
  programs.zsh.shellAliases = {
    # Linting shortcuts
    nix-lint = "statix check . && deadnix .";
    nix-lint-verbose = "statix check . && deadnix --verbose .";

    # Auto-fix and format (use with caution!)
    nix-clean = "statix fix . && deadnix --edit . && nix fmt";

    # Flake operations with better output
    nix-check = "nix flake check |& nom";
    nix-update = "nix flake update |& nom";

    # Build operations with nom
    nom-build = "nix build |& nom";
    nom-switch = "sudo nixos-rebuild switch --flake .# |& nom";
    nom-test = "sudo nixos-rebuild test --flake .# |& nom";

    # Show current system dependencies
    nix-deps = "nix-tree /run/current-system";

    # Format all Nix files
    nix-fmt = "nix fmt";

    # Quick documentation search
    nix-doc = "manix";

    # Show dead code statistics
    nix-dead = "deadnix --hidden .";
  };

  programs.bash.shellAliases = {
    # Same aliases for bash users
    nix-lint = "statix check . && deadnix .";
    nix-lint-verbose = "statix check . && deadnix --verbose .";
    nix-clean = "statix fix . && deadnix --edit . && nix fmt";
    nix-check = "nix flake check |& nom";
    nix-update = "nix flake update |& nom";
    nom-build = "nix build |& nom";
    nom-switch = "sudo nixos-rebuild switch --flake .# |& nom";
    nom-test = "sudo nixos-rebuild test --flake .# |& nom";
    nix-deps = "nix-tree /run/current-system";
    nix-fmt = "nix fmt";
    nix-doc = "manix";
    nix-dead = "deadnix --hidden .";
  };
}
