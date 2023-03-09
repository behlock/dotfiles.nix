{ pkgs, ... }: {
  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
    defaultCommand = "rg --files --hidden --follow --glob '!.git/*' --glob '!vendor/*'";
    fileWidgetCommand = "rg --files --hidden --follow --glob '!.git/*' --glob '!vendor/*'"; 
    changeDirWidgetCommand = "rg --files --hidden --follow --glob '!.git/*' --glob '!vendor/*'";
    defaultOptions = [ "-m --bind ctrl-a:select-all,ctrl-d:deselect-all" ];
    tmux = {
      enableShellIntegration = true;
    };
  };

  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    enableCompletion = true;
    enableSyntaxHighlighting = true;
    autocd = true;
    history = {
      expireDuplicatesFirst = true;
      extended = true;
      ignoreDups = true;
      ignoreSpace = true;
      path = "$HOME/.zsh_history";
      save = 10000;
      share = true;
      size = 10000;
    };
    profileExtra = builtins.readFile ./profile;
    sessionVariables = {
      PROMPT_COMMAND = "echo";
      EDITOR = "nvim";
      GIT_EDITOR = "nvim";
      ERL_AFLAGS = "-kernel shell_history enabled";
      SHELL = "${pkgs.zsh}/bin/zsh";
      BAT_THEME = "OneHalfDark";
      KEYTIMEOUT= 1; # Reduce delay for key combinations in order to change to vi mode faster
    };
    shellAliases = {
      ls = "exa -F";
      la = "exa -la";
      rm = "rm -i";
      mv = "mv -i";
      cp = "cp -i";
      grep = "grep --color=auto";
      sudo = "sudo ";
    };
    initExtra = builtins.readFile ./zshrc;
  };

  programs.tmux = {
    enable = true;
    terminal = "screen-256color";
    secureSocket = false;
    disableConfirmationPrompt = true;
    extraConfig = builtins.readFile ./tmux.conf;
  };

  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
    nix-direnv.enable = true;
  };

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.exa = { enable = true; };

  home.file.".inputrc".source = ./inputrc;
}
