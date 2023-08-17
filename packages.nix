{ pkgs, ... }: {
  home.packages = [
    pkgs.act # run github actions locally
    pkgs.awscli2 # aws cli
    pkgs.azure-cli # azure cli
    pkgs.bat # cat clone with syntax highlighting and Git integration
    pkgs.bore-cli # TCP tunnels
    pkgs.certbot # Let's Encrypt client
    pkgs.comma # run programs without installing them
    pkgs.docker # need no introduction
    pkgs.ffmpeg # video and audio converter
    pkgs.heroku # cloud platform as a service
    pkgs.htop # interactive process viewer
    pkgs.lazygit # git superpowers in terminal
    pkgs.jpegoptim # jpeg optimizer
    pkgs.jq # lightweight and flexible command-line JSON processor
    pkgs.mpc-cli # cli for music player daemon
    pkgs.nixfmt # format nix files
    pkgs.nodePackages.prettier # code formatter
    pkgs.nodePackages.svgo # svg optimizer
    pkgs.nodePackages.typescript # typed superset of JavaScript
    pkgs.nodejs # javaScript runtime
    pkgs.openjdk # Java runtime
    pkgs.pngquant # png optimizer
    pkgs.poetry # python package manager
    pkgs.pre-commit # framework for managing and maintaining multi-language pre-commit hooks
    pkgs.python311 # Python 3.11
    pkgs.ripgrep # grep alternative
    pkgs.sops # editor of encrypted files
    pkgs.yarn # yarn
    pkgs.yt-dlp # download videos from youtube
    pkgs.zsh
    pkgs.zsh-vi-mode # better vim mode in zsh
    pkgs.zsh-syntax-highlighting # syntax highlighting for zsh
    pkgs.zsh-history-substring-search # search through zsh history
    pkgs.zsh-autosuggestions # fish-like autosuggestions for zsh
  ];
}
