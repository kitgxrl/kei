{ pkgs, ... }: 
let
  fixGpg = "gpgconf --launch gpg-agent";
in
{
  home.packages = with pkgs; [ pinentry-gnome gcr ];

  services.gpg-agent = {
    enable = true;
    enableSshSupport = true;
    pinentryFlavor = "gnome3";
  };

  programs = {
    bash.profileExtra = fixGpg;
    zsh.loginExtra = fixGpg;
    fish.loginShellInit = fixGpg;
  };
}
