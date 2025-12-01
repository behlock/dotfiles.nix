{
  programs.git = {
    enable = true;
    lfs.enable = true;
    ignores = [ "*~" ".DS_Store" ".direnv" ".env" ".rgignore" ];
    settings = {
      user = {
        name = "behlock";
        email = "behlocks@gmail.com";
      };
      init = { defaultBranch = "main"; };
      pull = { ff = "only"; };
      push = { autoSetupRemote = "true"; };
    };
  };
  programs.delta = {
    enable = true;
    enableGitIntegration = true;
  };
}
