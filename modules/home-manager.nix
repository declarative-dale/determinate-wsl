# Home-manager integration module
# Configures home-manager for the system user

{ vars, agenix, ... }:

{
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.${vars.username} = import ./home.nix;
    extraSpecialArgs = {
      inherit vars agenix;
    };
  };
}
