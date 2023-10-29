{ pkgs, outputs, lib, ... }: {
  nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnfreePredicate = (_: true);
    };

    overlays = builtins.attrValues outputs.overlays;
  };

  nix = {
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
      warn-dirty = false;
    };

    package = lib.mkDefault pkgs.nix;
  };

  programs.home-manager.enable = true;

  systemd.user.startServices = "sd-switch";

  home = {
    username = "rain";
    homeDirectory = "/home/rain";
    stateVersion = "23.11";
    sessionPath = [ "$HOME/.local/bin" ];
  };
}
