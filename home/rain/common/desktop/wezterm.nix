{
  programs.wezterm = {
    enable = true;

    extraConfig = ''
      return {
        font = wezterm.font 'Jetbrains Mono Nerd Font',
        color_scheme = "Catppuccin Mocha",
        enable_tab_bar = false,
        force_reverse_video_cursor = true,
        window_close_confirmation = "NeverPrompt",
        window_padding = {
          left = 35,
          right = 35,
          top = 35,
          bottom = 35,
        }
      }
    '';
  };
}
