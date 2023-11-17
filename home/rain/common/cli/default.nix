{ pkgs, ... }: {
  imports = [];

  home.packages = with pkgs; [
    # Utilities

    unzip
    wget

    # Build tools

    gcc
    gnumake
    nodejs

    # Programming tools

    nixfmt
    python3

    # Util Command Replacements

    ripgrep
    fd
  ];

  programs.bottom = {
    enable = true;
    settings = {
      colors = {
        table_header_color = "#f5e0dc";
        all_cpu_color = "#f5e0dc";
        avg_cpu_color = "#eba0ac";
        cpu_core_colors = ["#f38ba8" "#fab387" "#f9e2af" "#a6e3a1" "#74c7ec" "#cba6f7"];
        ram_color = "#a6e3a1";
        swap_color = "#fab387";
        rx_color = "#a6e3a1";
        tx_color = "#f38ba8";
        widget_title_color = "#f2cdcd";
        border_color = "#585b70";
        highlighted_border_color = "#f5c2e7";
        text_color = "#cdd6f4";
        graph_color = "#a6adc8";
        cursor_color = "#f5c2e7";
        selected_text_color = "#11111b";
        selected_bg_color = "#cba6f7";
        high_battery_color = "#a6e3a1";
        medium_battery_color = "#f9e2af";
        low_battery_color = "#f38ba8";
        gpu_core_colors = ["#74c7ec" "#cba6f7" "#f38ba8" "#fab387" "#f9e2af" "#a6e3a1"];
        arc_color = "#89dceb";
      };
    };
  };

  programs.eza = {
    enable = true;
    enableAliases = true;
    git = true;
  };

  programs.bat = {
    enable = true;

    config.theme = "catppuccin";

    themes = {
      catppuccin = builtins.readFile (pkgs.fetchFromGitHub {
        owner = "catppuccin";
        repo = "bat";
        rev = "ba4d16880d63e656acced2b7d4e034e4a93f74b1";
        hash = "sha256-6WVKQErGdaqb++oaXnY3i6/GuH2FhTgK0v4TN4Y0Wbw=";
      } + /Catppuccin-mocha.tmTheme);
    };
  };

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  home.sessionVariables = { 
    EDITOR = "nvim";
    LS_COLORS = "$(${pkgs.vivid}/bin/vivid generate catppuccin-mocha)";
    
    # INFO: Right now catppuccin's bat theme has very poor highlighting
    # for man pages so we'll just use `less` for now
    # MANPAGER = "sh -c 'col -bx | ${pkgs.bat}/bin/bat -l man -p'";
    MANPAGER = "less -R --use-color -Dd+b -Du+c";
  };
}
