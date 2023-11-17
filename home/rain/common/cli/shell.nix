{ pkgs, ... }: 

let configLoc = "~/dev/kei";

in {
  programs.fish = {
    enable = true;

    shellAbbrs = {
      rgi = "rgi -i";
      nixsw = "sudo nixos-rebuild switch --flake ${configLoc}";
    };

    shellAliases = {
      cat = "bat";
      grep = "rg";
      find = "fd";
    };

    functions = {
      fish_greeting = "";
    };

    interactiveShellInit = ''
      fish_vi_key_bindings
      set fish_cursor_default     block      blink
      set fish_cursor_insert      line       blink
      set fish_cursor_replace_one underscore blink
      set fish_cursor_visual      block
    '';
  };

  programs.starship = {
    enable = true;
    settings = {
      format = "$all";
      palette = "catppuccin_mocha";
    } // builtins.fromTOML (builtins.readFile (pkgs.fetchFromGitHub {
      owner = "catppuccin";
      repo = "starship";
      rev = "5629d2356f62a9f2f8efad3ff37476c19969bd4f";
      sha256 = "1bdm1vzapbpnwjby51dys5ayijldq05mw4wf20r0jvaa072nxi4y";
    } + /palettes/mocha.toml));
  };
}
