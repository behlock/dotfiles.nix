{ pkgs, ... }: {
  home.username = "behlock";
  home.homeDirectory =
    "/${if pkgs.stdenv.isDarwin then "Users" else "home"}/pi";
  home.stateVersion = "22.11";
  programs.home-manager.enable = true;

  imports = [ ./packages.nix ./vim.nix ./git.nix ./rest.nix ];
}
