{ pkgs, ... }:
let
  isAarch64Darwin = pkgs.stdenv.hostPlatform.system == "aarch64-darwin";

  # scipy 1.18 fails its own test suite on this nixpkgs revision (a flaky
  # hypothesis case in stats/tests/test_continuous.py). It reaches us only as a
  # *test* dependency of threadpoolctl (nltk -> joblib -> threadpoolctl), so
  # skipping that test suite drops scipy from the graph entirely rather than
  # building it. Revisit once nixpkgs ships a scipy whose tests pass.
  python312 = pkgs.python312.override {
    packageOverrides = _: prev: {
      threadpoolctl = prev.threadpoolctl.overridePythonAttrs (_: {
        doCheck = false;
        nativeCheckInputs = [ ];
      });
    };
  };

  # One Python environment so the libraries are actually importable from the
  # installed interpreter (separate profile entries are not on sys.path).
  python = python312.withPackages (
    ps:
    [
      ps.nltk # natural language toolkit
      ps.pip # python package manager
    ]
    ++ pkgs.lib.optionals isAarch64Darwin [
      ps.mlx # Apple Silicon only (requires Metal)
    ]
  );
in
{
  # Drop anything nixpkgs does not provide for this platform (e.g. bun,
  # claude-code, flutter, ngrok and opencode have no armv7l build for the Pi)
  # so one list can serve every machine.
  home.packages =
    builtins.filter (pkgs.lib.meta.availableOn pkgs.stdenv.hostPlatform)
      [
        pkgs.act # run github actions locally
        pkgs.android-tools # android sdk
        pkgs.awscli2 # aws cli
        pkgs.bat # cat clone with syntax highlighting and Git integration
        pkgs.bore-cli # TCP tunnels
        pkgs.bun # fast JavaScript runtime and bundler
        pkgs.cargo # rust package manager
        pkgs.certbot # Let's Encrypt client
        pkgs.claude-code # anthropic cli
        pkgs.clippy # rust linter
        pkgs.docker # need no introduction
        pkgs.fd # find alternative (used by the fzf directory widget)
        pkgs.ffmpeg # video and audio converter
        pkgs.flutter # Google's UI toolkit for building natively compiled applications
        pkgs.gh # github cli
        pkgs.ghostscript # postscript interpreter
        pkgs.git-lfs # git extension for versioning large files
        pkgs.heroku # cloud platform as a service
        pkgs.htop # interactive process viewer
        pkgs.httpie # http client
        pkgs.jless # pager for json files
        pkgs.jpegoptim # jpeg optimizer
        pkgs.jq # lightweight and flexible command-line JSON processor
        pkgs.just # command runner for project-specific tasks
        pkgs.k9s # terminal UI to interact with your Kubernetes clusters
        pkgs.ktlint # kotlin linter
        pkgs.kubectl # kubernetes cli
        pkgs.kubectx # switch faster between clusters and namespaces in kubectl
        pkgs.maven # java build tool
        pkgs.mpc # cli for music player daemon
        pkgs.nerd-fonts.jetbrains-mono # patched font with a high number of glyphs
        pkgs.ngrok # tunnel local services to the public internet
        pkgs.nixfmt # format nix files
        pkgs.nodejs # javaScript runtime
        pkgs.opencode # AI coding agent for the terminal
        pkgs.openjdk # Java runtime
        pkgs.pipx # install and run python packages in isolated environments
        pkgs.platformio # embedded software utility
        pkgs.pngquant # png optimizer
        pkgs.pnpm # fast, disk space efficient package manager
        pkgs.poetry # python package manager
        pkgs.portaudio # cross-platform audio I/O library
        pkgs.postgresql_jit # postgres
        pkgs.pre-commit # framework for managing and maintaining multi-language pre-commit hooks
        # pkgs.prettier # code formatter - conflicts with flutter's LICENSE file
        pkgs.pyenv # python version manager
        python # Python 3.12 with nltk, pip (and mlx on Apple Silicon)
        pkgs.qpdf # PDF transformation
        pkgs.railway # railway cli
        pkgs.redis # key-value store
        pkgs.ripgrep # grep alternative
        pkgs.rustc # rust compiler
        pkgs.rustfmt # rust formatter
        pkgs.sops # editor of encrypted files
        pkgs.supabase-cli # supabase cli
        pkgs.svgo # svg optimizer
        pkgs.tailspin # log file highlighter
        pkgs.texliveFull # full TeX Live distribution
        pkgs.tree # display directory tree
        pkgs.typescript # typed superset of JavaScript
        pkgs.uv # fast python package installer
        pkgs.wget # download files from the web
        pkgs.yarn # yarn
        pkgs.yt-dlp # download videos from youtube
      ];
}
