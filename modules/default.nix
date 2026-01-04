{ lib, ... }:
{
  imports = map (f: ./. + "/${f}") (
    builtins.filter (lib.hasSuffix ".nix") (
      lib.subtractLists [ "default.nix" "home.nix" ] (builtins.attrNames (builtins.readDir ./.))
    )
  );
}
