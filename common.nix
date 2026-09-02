# Settings shared by every machine. Each home-<host>.nix only sets the
# username and stateVersion, then imports this file.
{ config, pkgs, ... }: {
  imports = [
    ./packages.nix
    ./vim.nix
    ./git.nix
    ./rest.nix
  ];

  home.homeDirectory = "/${
    if pkgs.stdenv.hostPlatform.isDarwin then "Users" else "home"
  }/${config.home.username}";

  programs.home-manager.enable = true;
  nixpkgs.config.allowUnfree = true;

  # nix-index with a prebuilt database (no `nix-index` run needed), plus
  # `comma` so `, <program>` runs anything without installing it.
  programs.nix-index.enable = true;
  programs.nix-index-database.comma.enable = true;

  # Claude Code settings live in this repo. Symlinked out of the store so
  # Claude Code can still write to the file and the repo stays in sync.
  home.file.".claude/settings.json".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.config/home-manager/claude-settings.json";
}
