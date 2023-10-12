{ inputs, outputs, ... }: {
  imports = [
    inputs.home-manager.nixosModules.home-manager

    ./nix.nix
    ./ssh.nix
  ];

  home-manager = {
    useUserPackages = true;
    extraSpecialArgs = { inherit inputs outputs; };
  };

  nixpkgs = {
    config.allowUnfree = true;

    overlays = builtins.attrValues outputs.overlays;
  };

  environment.enableAllTerminfo = true;
  hardware.enableRedistributableFirmware = true;
}
