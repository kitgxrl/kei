{ config, ... }: {
  programs.firefox = {
    enable = true;

    profiles.default = {
      isDefault = true;
      extensions = with config.nur.repos.rycee.firefox-addons; [
        ublock-origin
        bitwarden
        sponsorblock
      ];
    };
  };
}
