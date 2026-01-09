{ pkgs, ... }: {
  home.username = "cookie";
  home.homeDirectory = "/home/cookie";
  home.stateVersion = "24.05";
  programs.home-manager.enable = true;
  nixpkgs.config.allowUnfree = true;

  imports = [ ./packages.nix ./vim.nix ./git.nix ./rest.nix ];
}
