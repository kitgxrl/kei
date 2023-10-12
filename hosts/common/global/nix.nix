{ inputs, lib, ... }: {
  nix = {
    settings = {
      trusted-users = [ "root" "@wheel" ];
      auto-optimise-store = true;
      experimental-features = [ "nix-command" "flakes" ];
      warn-dirty = false;
      system-features = [ "kvm" "big-parallel" ];
      keep-outputs = true;
      keep-derivations = true;
    };

    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 2d";
    };

    registry = lib.mapAttrs (_: value: { flake = value; }) inputs;

    nixPath = [ "nixpkgs=${inputs.nixpkgs.outPath}" ];
  };
}
