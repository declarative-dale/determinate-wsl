# Agenix secrets configuration
# This file defines which public keys can decrypt which secrets
# Reference: https://github.com/ryantm/agenix

let
  # User SSH public keys (extract from ~/.ssh/id_ed25519.pub or use ssh-to-age)
  # To get age public key from SSH key: ssh-keyscan localhost | ssh-to-age
  # Or: cat ~/.ssh/id_ed25519.pub | ssh-to-age
  nixos = ""; # Add your age public key here

  # System SSH host keys (from /etc/ssh/ssh_host_ed25519_key.pub)
  # To get age public key: cat /etc/ssh/ssh_host_ed25519_key.pub | ssh-to-age
  nixos-wsl-system = ""; # Add system's age public key here

  # Combined list of authorized keys
  allKeys = [ nixos nixos-wsl-system ];
in
{
  # Example secret configuration
  # "example-secret.age".publicKeys = allKeys;

  # Add your secrets here:
  # "ssh-key.age".publicKeys = [ nixos ];
  # "api-token.age".publicKeys = allKeys;
  # "github-token.age".publicKeys = [ nixos ];
}
