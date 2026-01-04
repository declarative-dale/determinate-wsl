# Home-manager integration module
# Configures home-manager for the system user

{ username, agenix, ... }:

{
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.${username} = import ./home.nix;
    extraSpecialArgs = {
      inherit username agenix;
    };
  };
}
