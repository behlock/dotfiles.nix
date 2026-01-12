{ pkgs, ... }: {
  programs.git = {
    enable = true;
    lfs.enable = true;
    ignores = [ "*~" ".DS_Store" ".direnv" ".env" ".rgignore" ];
    settings = {
      user = {
        name = "behlock";
        email = "behlocks@gmail.com";
      };
      init = { defaultBranch = "main"; };
      pull = { ff = "only"; };
      push = { autoSetupRemote = "true"; };
    };
  };
  programs.delta = {
    enable = true;
    enableGitIntegration = true;
    options = {
      "line-numbers" = true;
      "line-numbers-left-format" = "{nm:>4} ";
      "line-numbers-right-format" = "{np:>4} ";
      "hunk-header-style" = "omit";
      "file-decoration-style" = "none";
      # Dark mode settings (default)
      "dark" = true;
      "syntax-theme" = "base16";
      "minus-style" = "syntax #3a2a2a";
      "minus-emph-style" = "syntax #4a3030";
      "plus-style" = "syntax #2a3a2a";
      "plus-emph-style" = "syntax #304a30";
      "line-numbers-minus-style" = "#666666";
      "line-numbers-plus-style" = "#888888";
      "line-numbers-zero-style" = "#444444";
      "file-style" = "#ffffff bold";
    };
  };

  # Delta wrapper script that auto-detects light/dark mode
  home.packages = [
    (pkgs.writeShellScriptBin "delta-auto" ''
      if [[ "$(defaults read -g AppleInterfaceStyle 2>/dev/null)" == "Dark" ]]; then
        exec delta --dark --syntax-theme=base16 \
          --minus-style='syntax #3a2a2a' --plus-style='syntax #2a3a2a' \
          --minus-emph-style='syntax #4a3030' --plus-emph-style='syntax #304a30' \
          --line-numbers-minus-style='#666666' --line-numbers-plus-style='#888888' \
          --line-numbers-zero-style='#444444' --file-style='#ffffff bold' \
          "$@"
      else
        exec delta --light --syntax-theme=GitHub \
          --minus-style='syntax #ffebe9' --plus-style='syntax #e6ffec' \
          --minus-emph-style='syntax #ffc0c0' --plus-emph-style='syntax #a0f0a0' \
          --line-numbers-minus-style='#cf222e' --line-numbers-plus-style='#1a7f37' \
          --line-numbers-zero-style='#666666' --file-style='#000000 bold' \
          "$@"
      fi
    '')
  ];
  programs.lazygit = {
    enable = true;
    settings = {
      git = {
        pagers = [
          {
            colorArg = "always";
            pager = "delta-auto --paging=never";
          }
        ];
      };
      gui = {
        theme = {
          activeBorderColor = [ "#ffffff" "bold" ];
          inactiveBorderColor = [ "#666666" ];
          optionsTextColor = [ "#aaaaaa" ];
          selectedLineBgColor = [ "#333333" ];
          cherryPickedCommitBgColor = [ "#444444" ];
          cherryPickedCommitFgColor = [ "#ffffff" ];
          unstagedChangesColor = [ "#999999" ];
          defaultFgColor = [ "#cccccc" ];
          searchingActiveBorderColor = [ "#ffffff" ];
        };
        nerdFontsVersion = "3";
      };
    };
  };
}
