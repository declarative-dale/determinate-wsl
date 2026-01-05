# Agenix secrets management configuration
# Reference: https://github.com/ryantm/agenix

{ vars, ... }:

{
  # Agenix configuration
  # Secrets directory (where age files will be stored)
  # By default, agenix looks for secrets in ./secrets relative to flake.nix

  # Example secret configuration:
  # age.secrets.example-secret = {
  #   file = ../secrets/example.age;
  #   owner = vars.username;
  #   group = "users";
  # };

  # To create a secret:
  # 1. Generate an age key: ssh-keygen -t ed25519 -f ~/.ssh/id_ed25519
  # 2. Get public key: ssh-keyscan localhost | ssh-to-age
  # 3. Create secrets.nix with public keys
  # 4. Create secret: agenix -e example.age
  # 5. Reference secret in configuration
}
