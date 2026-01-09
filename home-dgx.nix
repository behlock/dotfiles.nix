{ pkgs, ... }: {
  home.username = "behlock";
  home.homeDirectory = "/home/behlock";
  home.stateVersion = "24.05";
  programs.home-manager.enable = true;
  nixpkgs.config.allowUnfree = true;

  imports = [ ./packages.nix ./vim.nix ./git.nix ./rest.nix ];
}
