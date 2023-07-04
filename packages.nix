{ pkgs, ... }: {
  home.packages = [
    pkgs.bat # cat clone with syntax highlighting and Git integration
    pkgs.bore-cli # TCP tunnels
    pkgs.comma # run programs without installing them
    pkgs.docker # need no introduction
    pkgs.ffmpeg # video and audio converter
    pkgs.heroku # cloud platform as a service
    pkgs.htop # interactive process viewer
    pkgs.lazygit # git superpowers in terminal
    pkgs.jq # lightweight and flexible command-line JSON processor
    pkgs.nodePackages.prettier # code formatter
    pkgs.nodePackages.typescript # typed superset of JavaScript
    pkgs.nodejs # javaScript runtime
    pkgs.poetry # python package manager
    pkgs.python3 # Python interpreter
    pkgs.ripgrep # grep alternative
    pkgs.nixfmt # format nix files
    pkgs.yarn # yarn
    pkgs.yt-dlp # download videos from youtube
    pkgs.zsh
    # pkgs.zsh-z-unstable # quickly jump to directories you use often
    pkgs.zsh-vi-mode # better vim mode in zsh
    pkgs.zsh-syntax-highlighting # syntax highlighting for zsh
    pkgs.zsh-history-substring-search # search through zsh history
    pkgs.zsh-autosuggestions # fish-like autosuggestions for zsh
  ];
}
