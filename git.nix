{
  programs.git = {
    enable = true;
    userName = "behlock";
    userEmail = "behlocks@gmail.com";
    ignores = [ "*~" ".DS_Store" ".direnv" ".env" ".rgignore" ];
    extraConfig = {
      init = { defaultBranch = "main"; };
      pull = { ff = "only"; };
      push = { autoSetupRemote = "true"; };    
    };
    delta = { enable = true; };
  };
}
