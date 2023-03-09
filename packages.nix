{ pkgs, ... }: {
  home.packages = [
    pkgs.bat # cat clone with syntax highlighting and Git integration
    pkgs.comma # run programs without installing them
    pkgs.htop # interactive process viewer
    pkgs.jq # lightweight and flexible command-line JSON processor
    pkgs.nodePackages.prettier # code formatter
    pkgs.nodePackages.typescript # typed superset of JavaScript
    pkgs.nodejs # JavaScript runtime
    pkgs.ripgrep # grep alternative
    pkgs.nixfmt # format nix files
    pkgs.zsh
    # pkgs.zsh-z-unstable # quickly jump to directories you use often
    pkgs.zsh-vi-mode # better vim mode in zsh
    pkgs.zsh-syntax-highlighting # syntax highlighting for zsh
    pkgs.zsh-history-substring-search # search through zsh history
    pkgs.zsh-autosuggestions # fish-like autosuggestions for zsh
  ];
}
