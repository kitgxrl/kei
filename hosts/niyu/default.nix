{ pkgs, inputs, ... }: {
  imports = [
    # Specific for my hardware

    ./hardware.nix

    inputs.hardware.nixosModules.common-cpu-amd
    inputs.hardware.nixosModules.common-gpu-amd
    inputs.hardware.nixosModules.common-pc-ssd

    # Used in all systems

    ../common/global

    # Just me in here..

    ../common/users/rain.nix

    # Optional Imports

    # ...
  ];

  # Set the hostname

  networking.hostName = "niyu";

  # GRUB

  boot.loader = {
    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot/efi";
    };

    grub = {
      efiSupport = true;
      device = "nodev";
      useOSProber = true;
    };
  };

  # Hardware

  hardware = {
    opengl = {
      enable = true;
      extraPackages = with pkgs; [ amdvlk rocm-opencl-icd rocm-opencl-runtime ];
      driSupport = true;
      driSupport32Bit = true;
    };
  };

  # Monitor Configuration

  services.xserver.xrandrHeads = [
    {
      output = "HDMI-1";
      primary = true;
      monitorConfig = ''
        Option "LeftOf" "DP-2"
        Option "TearFree" "true"
        Modeline "1920x1080_144.00" 346.50  1920 1968 2000 2080  1080 1083 1088 1157 +hsync -vsync
        Option "PreferredMode" "1920x1080_144.00"
      '';
    }
    {
      output = "DP-2";
      monitorConfig = ''
        Option "TearFree" "true"
      '';
    }
  ];

  # Ratbagd is used in applications such as `piper`
  # TODO: Configure mouse settings via Nix

  services.ratbagd.enable = true;

  # System Version
  # NOTE: When using nixpkgs-unstable, this should be the next stable release value

  system.stateVersion = "23.11";
}
