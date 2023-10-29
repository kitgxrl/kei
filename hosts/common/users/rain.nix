{ pkgs, config, ... }: {
  users.mutableUsers = false;

  users.users.rain = {
    isNormalUser = true;
    shell = pkgs.fish;
    description = "Rain";
    extraGroups = [ "wheel" "video" "audio" ];

    hashedPassword = "$6$l04ZF1w0fZiYDk3v$xJqMQPJy1WXEmZ3xnfNgiwSlGwb0vdfctxe/c5mQFmCQrDmE/fIrUf4/Zvo9LVVTkxTQKjO5WR4bF5RMSWWWb0";

    packages = with pkgs; [ home-manager ];
  };

  home-manager.users.rain = import ../../../users/rain/${config.networking.hostName}.nix;
}
