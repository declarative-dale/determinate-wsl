# SSH configuration
# Configures SSH agent and generates ed25519 key on first activation

{ pkgs, username, ... }:

{
  # System-level SSH agent
  programs.ssh.startAgent = true;

  # User-level SSH configuration via home-manager
  home-manager.users.${username} =
    { lib, ... }:
    {
      # SSH client configuration
      programs.ssh = {
        enable = true;
        matchBlocks."*".identityFile = "~/.ssh/id_ed25519";
      };

      # Generate ed25519 SSH key on first activation (idempotent)
      home.activation.generateSshKey = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
        if [ ! -f ~/.ssh/id_ed25519 ]; then
          $DRY_RUN_CMD mkdir -p ~/.ssh
          $DRY_RUN_CMD chmod 700 ~/.ssh
          $DRY_RUN_CMD ${pkgs.openssh}/bin/ssh-keygen -t ed25519 -f ~/.ssh/id_ed25519 -N "" -C "${username}@nixos"
          echo "Generated new SSH ed25519 key at ~/.ssh/id_ed25519"
        fi
      '';
    };
}
