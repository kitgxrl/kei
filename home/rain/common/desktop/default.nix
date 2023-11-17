{ pkgs, ... }: {
  imports = [];

  home.packages = with pkgs; [
    # Chat Applications

    discord-canary
    element-desktop

    # Misc Tools

    feh
    maim
    xclip
    brightnessctl
    pamixer
    networkmanagerapplet

    # You know...

    qbittorent

    # Video Calls

    zoom-us

    # Music

    spotify
  ];

  services.picom = {
    enable = true;
    backend = "xrender";
    vSync = true;
  };


  gtk = {
    enable = true;
    theme = {
      name = "Catppuccin-Mocha-Standard-Red-Dark";
      package = pkgs.catppuccin-gtk;
    };

    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
  };

  home = {
    pointerCursor = {
      size = 24;
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Classic";

      x11.enable = true;
    };
  };
}
