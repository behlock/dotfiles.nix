{ pkgs, ... }: {
  home.username = "pi";
  home.homeDirectory = "/home/pi";
  home.stateVersion = "23.11";
  programs.home-manager.enable = true;

  imports = [ ./packages.nix ./vim.nix ./git.nix ./rest.nix ];
}
