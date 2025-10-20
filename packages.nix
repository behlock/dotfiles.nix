{ pkgs, ... }: {
  home.packages = [
    pkgs.act # run github actions locally
    pkgs.android-tools # android sdk
    pkgs.awscli2 # aws cli
    pkgs.bat # cat clone with syntax highlighting and Git integration
    pkgs.bore-cli # TCP tunnels
    pkgs.cargo # rust package manager
    pkgs.certbot # Let's Encrypt client
    pkgs.comma # run programs without installing them
    pkgs.docker # need no introduction
    pkgs.ffmpeg # video and audio converter
    pkgs.flutter # Google's UI toolkit for building natively compiled applications
    pkgs.heroku # cloud platform as a service
    pkgs.ghostscript # postscript interpreter
    pkgs.git-lfs # git extension for versioning large files
    pkgs.gh # github cli
    pkgs.htop # interactive process viewer
    pkgs.httpie # http client
    pkgs.ktlint # kotlin linter
    pkgs.k9s # terminal UI to interact with your Kubernetes clusters
    pkgs.kubectl # kubernetes cli
    pkgs.kubectx # switch faster between clusters and namespaces in kubectl
    pkgs.lazygit # git superpowers in terminal
    pkgs.jless # pager for json files
    pkgs.jpegoptim # jpeg optimizer
    pkgs.jq # lightweight and flexible command-line JSON processor
    pkgs.maven # java build tool
    pkgs.mpc-cli # cli for music player daemon
    pkgs.nixfmt-classic # format nix files
    pkgs.ngrok # tunnel local services to the public internet
    pkgs.nodePackages_latest.pnpm # fast, disk space efficient package manager
    # pkgs.nodePackages.prettier # code formatter - conflicts with flutter's LICENSE file
    pkgs.nodePackages.svgo # svg optimizer
    pkgs.nodePackages.typescript # typed superset of JavaScript
    pkgs.nodePackages.vercel # vercel CLI
    pkgs.nodejs # javaScript runtime
    pkgs.openjdk # Java runtime
    pkgs.pipx # install and run python packages in isolated environments
    pkgs.platformio # embedded software utility
    pkgs.pngquant # png optimizer
    pkgs.poetry # python package manager
    pkgs.portaudio # cross-platform audio I/O library
    pkgs.postgresql_jit # postgres
    pkgs.pre-commit # framework for managing and maintaining multi-language pre-commit hooks
    pkgs.pyenv # python version manager
    pkgs.python312Packages.nltk # natural language toolkit
    pkgs.python312Packages.pip # python package manager
    pkgs.python312 # Python 3.12
    pkgs.qpdf # PDF transformation
    pkgs.redis # key-value store
    pkgs.ripgrep # grep alternative
    pkgs.rustc # rust compiler
    pkgs.sops # editor of encrypted files
    pkgs.tailspin # log file highlighter
    pkgs.tree # display directory tree
    pkgs.uv # fast python package installer
    pkgs.yarn # yarn
    pkgs.yt-dlp # download videos from youtube
    pkgs.zsh
    pkgs.zsh-vi-mode # better vim mode in zsh
    pkgs.zsh-syntax-highlighting # syntax highlighting for zsh
    pkgs.zsh-history-substring-search # search through zsh history
    pkgs.zsh-autosuggestions # fish-like autosuggestions for zsh
  ];
}
