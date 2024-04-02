# Dotfiles.nix

Dotfiles, powered by [Nix](https://nixos.org/nix/) and [home-manager](https://github.com/rycee/home-manager).

## How to use

1. Install Nix:

   ```bash
   sh <(curl -L https://nixos.org/nix/install)
   ```

2. Enable [Nix Flakes](https://www.tweag.io/blog/2020-05-25-flakes):

   ```bash
   mkdir -p ~/.config/nix

   cat <<EOF >> ~/.config/nix/nix.conf
   experimental-features = nix-command flakes
   EOF

   sudo launchctl kickstart -k system/org.nixos.nix-daemon
   ```

3. Go inside your `~/.config` directory and clone this repo:

   ```bash
   cd ~/.config && \
     git clone https://github.com/behlock/dotfiles.nix.git home-manager && cd home-manager
   ```

4. Install [home-manager](https://nix-community.github.io/home-manager/index.xhtml#sec-install-standalone)

5. Run the flake and activate your env:

   ```bash
   home-manager switch -b backup
   ```

6. Then you can update it with:

   ```bash
   nix flake update && home-manager switch
   ```
