{ lib, config, pkgs, ... }:

with lib;

{
  options.mine.console.enable = mkOption {
    type = types.bool;
    default = true;
    description = "enable console config";
  };

  config = mkIf config.mine.console.enable {

    environment.pathsToLink = [ "/share/zsh" ];

    mine.vim.enable = true;

    programs.zsh = {
      autosuggestions.enable = true;
      enable = true;
      enableCompletion = true;
      ohMyZsh = {
        enable = true;
      };
    };

    programs.autojump = {
      enable = true;
    };

    environment.systemPackages = with pkgs; [
      direnv
      gitFull
      tmux
      lsof
      pass
      gnupg
      unzip
      jq
      bc
      wget
      ripgrep
      ripgrep-all
      sd
      file
      nmap
      traceroute
      nix-top
      fd
      gitAndTools.hub
      sqliteInteractive
      gnumake
      whois
      aspellDicts.en
      bat
      nix-index
      nix-prefetch-scripts
      ranger
      zstd
      tldr
      usbutils
      cht-sh
      cv
      _1password
      du-dust
    ];

    users.defaultUserShell = pkgs.zsh;

    mine.userConfig = {
      programs.direnv = {
        enable = true;
        stdlib = ''

          realpath() {
              [[ $1 = /* ]] && echo "$1" || echo "$PWD/''${1#./}"
          }

          layout_python-venv() {
              local python=''${1:-python3}
              [[ $# -gt 0 ]] && shift
              unset PYTHONHOME
              if [[ -n $VIRTUAL_ENV ]]; then
                  VIRTUAL_ENV=$(realpath "''${VIRTUAL_ENV}")
              else
                  local python_version
                  python_version=$("$python" -c "import platform; print(platform.python_version())")
                  if [[ -z $python_version ]]; then
                      log_error "Could not detect Python version"
                      return 1
                  fi
                  VIRTUAL_ENV=$PWD/.direnv/python-venv-$python_version
              fi
              export VIRTUAL_ENV
              if [[ ! -d $VIRTUAL_ENV ]]; then
                  log_status "no venv found; creating $VIRTUAL_ENV"
                  "$python" -m venv "$VIRTUAL_ENV"
              fi
              PATH_add "$VIRTUAL_ENV/bin"
          }
        '';
      };
    };
  };
}
