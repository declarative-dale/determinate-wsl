{ lib, ... }:
{
  imports = map (f: ./. + "/${f}")
    (builtins.filter (lib.hasSuffix ".nix")
      (lib.remove "default.nix" (builtins.attrNames (builtins.readDir ./.))));
}
