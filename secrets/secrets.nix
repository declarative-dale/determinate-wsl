# Agenix secrets configuration
# This file defines which public keys can decrypt which secrets
# Reference: https://github.com/ryantm/agenix

let
  # User SSH public keys (extract from ~/.ssh/id_ed25519.pub or use ssh-to-age)
  # To get age public key from SSH key: ssh-keyscan localhost | ssh-to-age
  # Or: cat ~/.ssh/id_ed25519.pub | ssh-to-age
  userKey = ""; # Add your age public key here

  # System SSH host keys (from /etc/ssh/ssh_host_ed25519_key.pub)
  # To get age public key: cat /etc/ssh/ssh_host_ed25519_key.pub | ssh-to-age
  systemKey = ""; # Add system's age public key here

  # Combined list of authorized keys
  allKeys = [ userKey systemKey ];
in
{
  # Example secret configuration
  # "example-secret.age".publicKeys = allKeys;

  # Add your secrets here:
  # "ssh-key.age".publicKeys = [ userKey ];
  # "api-token.age".publicKeys = allKeys;
  # "github-token.age".publicKeys = [ userKey ];
}
