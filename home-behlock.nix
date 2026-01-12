{ pkgs, ... }: {
  home.username = "behlock";
  home.homeDirectory =
    "/${if pkgs.stdenv.isDarwin then "Users" else "home"}/behlock";
  home.stateVersion = "23.11";
  programs.home-manager.enable = true;
  nixpkgs.config.allowUnfree = true;

  imports = [ ./packages.nix ./vim.nix ./git.nix ./rest.nix ];
}
