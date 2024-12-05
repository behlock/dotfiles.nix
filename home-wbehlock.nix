{ pkgs, ... }: {
  home.username = "wbehlock";
  home.homeDirectory =
    "/${if pkgs.stdenv.isDarwin then "Users" else "home"}/wbehlock";
  home.stateVersion = "24.05";
  programs.home-manager.enable = true;
  nixpkgs.config.allowUnfree = true;

  imports = [ ./packages.nix ./vim.nix ./git.nix ./rest.nix ];
}
