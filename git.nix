{
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
      "syntax-theme" = "base16";
      "minus-style" = "syntax #2a2a2a";
      "minus-emph-style" = "syntax #3a3a3a";
      "plus-style" = "syntax #2a2a2a";
      "plus-emph-style" = "syntax #3a3a3a";
      "line-numbers" = true;
      "line-numbers-minus-style" = "#666666";
      "line-numbers-plus-style" = "#888888";
      "line-numbers-zero-style" = "#444444";
      "line-numbers-left-format" = "{nm:>4} ";
      "line-numbers-right-format" = "{np:>4} ";
      "hunk-header-style" = "omit";
      "file-style" = "#ffffff bold";
      "file-decoration-style" = "none";
    };
  };
  programs.lazygit = {
    enable = true;
    settings = {
      git = {
        pagers = [
          {
            colorArg = "always";
            pager = "delta --dark --paging=never --syntax-theme=base16 --minus-style='syntax #2a2a2a' --plus-style='syntax #2a2a2a' --minus-emph-style='syntax #3a3a3a' --plus-emph-style='syntax #3a3a3a' --line-numbers-minus-style='#666666' --line-numbers-plus-style='#888888'";
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
