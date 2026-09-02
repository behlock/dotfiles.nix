{ pkgs, ... }:
let
  fzfFiles = "rg --files --hidden --follow --glob '!.git/*' --glob '!vendor/*'";
  fzfDirs = "fd --type d --hidden --follow --exclude .git --exclude vendor";
in
{
  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
    defaultCommand = fzfFiles;
    fileWidget.command = fzfFiles;
    changeDirWidget.command = fzfDirs;
    defaultOptions = [ "-m --bind ctrl-a:select-all,ctrl-d:deselect-all" ];
    tmux.enableShellIntegration = true;
  };

  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;
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
      EDITOR = "nvim";
      GIT_EDITOR = "nvim";
      ERL_AFLAGS = "-kernel shell_history enabled";
      SHELL = "${pkgs.zsh}/bin/zsh";
      BAT_THEME = "OneHalfDark";
      KEYTIMEOUT = 1; # Reduce delay for key combinations in order to change to vi mode faster
    };
    # `ls`, `ll`, `lt`, `lla` come from programs.eza
    shellAliases = {
      la = "eza -la";
      rm = "rm -i";
      mv = "mv -i";
      cp = "cp -i";
      grep = "grep --color=auto";
      sudo = "sudo ";
    };
    initContent = builtins.readFile ./zshrc;
  };

  programs.eza = {
    enable = true;
    # Recent eza takes an optional value for -F/--classify, so a bare `-F`
    # swallows the next argument (`ls dir` broke). Be explicit.
    extraOptions = [ "--classify=auto" ];
  };

  programs.tmux = {
    enable = true;
    terminal = "tmux-256color";
    shortcut = "a";
    keyMode = "vi";
    mouse = true;
    focusEvents = true;
    baseIndex = 1;
    escapeTime = 10;
    historyLimit = 102400;
    secureSocket = false;
    disableConfirmationPrompt = true;
    plugins = with pkgs.tmuxPlugins; [
      resurrect
      continuum
    ];
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

  home.file.".inputrc".source = ./inputrc;
}
