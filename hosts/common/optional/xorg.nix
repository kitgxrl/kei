{ pkgs, ... }: {
  # xserver

  services.xserver = {
    enable = true;

    windowManager.herbstluftwm = {
      enable = true;
    };
  };

  # Fonts, I put them here since anything that shares using this file
  # will likely want these for various programs anyways

  fonts.packages = with pkgs; [
    nerdfonts

    noto-fonts
    noto-fonts-emoji
    noto-fonts-cjk-sans
    noto-fonts-cjk-serif

    liberation_tff
    overpass
    rubik
  ];
}
