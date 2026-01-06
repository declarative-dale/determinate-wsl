# Agenix Secrets Management

This directory contains encrypted secrets managed by [agenix](https://github.com/ryantm/agenix).

## Setup

### 1. Generate SSH Key (if not already done)

Your SSH key generation is already configured in `modules/ssh.nix` and will be created on first activation.

### 2. Get Your Age Public Key

After your SSH key is generated, convert it to an age public key:

```bash
# Get age public key from your SSH key
cat ~/.ssh/id_ed25519.pub | ssh-to-age
```

### 3. Get System Host Key

```bash
# Get system's age public key
sudo cat /etc/ssh/ssh_host_ed25519_key.pub | ssh-to-age
```

### 4. Update secrets.nix

Add the public keys from steps 2 and 3 to `secrets/secrets.nix`:

```nix
let
  userKey = "age1..."; # Your user key
  systemKey = "age1..."; # System host key
  allKeys = [ userKey systemKey ];
in
{
  "example-secret.age".publicKeys = allKeys;
}
```

## Creating Secrets

### Create a new secret:

```bash
agenix -e example-secret.age
```

This will open your `$EDITOR` to enter the secret content.

### Edit an existing secret:

```bash
agenix -e example-secret.age
```

### Re-key all secrets (after adding new keys):

```bash
agenix -r
```

## Using Secrets in NixOS Configuration

In `modules/agenix.nix` or any module:

```nix
{
  age.secrets.example-secret = {
    file = ../secrets/example-secret.age;
    owner = vars.username;
    group = "users";
    mode = "400";
  };
}
```

The decrypted secret will be available at `/run/agenix/example-secret`.

## Example Use Cases

### SSH Private Key
```nix
age.secrets.github-ssh-key = {
  file = ../secrets/github-ssh-key.age;
  owner = vars.username;
  mode = "400";
};

# Then use in SSH config
programs.ssh.matchBlocks."github.com".identityFile = "/run/agenix/github-ssh-key";
```

### API Token
```nix
age.secrets.api-token = {
  file = ../secrets/api-token.age;
  owner = vars.username;
};

# Reference in environment
environment.systemPackages = [
  (pkgs.writeShellScriptBin "use-api" ''
    export API_TOKEN=$(cat /run/agenix/api-token)
    # your script here
  '')
];
```

## Important Notes

- **Never commit** `.age` files without encryption
- **Never commit** private keys
- **Do commit** `secrets.nix` (it only contains public keys)
- Secrets are decrypted at **system activation** time
- Decrypted secrets live in `/run/agenix/` (tmpfs, not persisted)
