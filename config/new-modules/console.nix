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
      # TODO: break direnv out into a module with options for e.g. python, etc
      programs.direnv = {
        enable = true;
        stdlib = ''
          use_pyenv() {
            unset PYENV_VERSION
            # Because each python version is prepended to the PATH, add them in reverse order
            for ((j = $#; j >= 1; j--)); do
              local python_version=''${!j}
              local pyenv_python=$(pyenv root)/versions/''${python_version}/bin/python
              if [[ ! -x "$pyenv_python" ]]; then
                log_error "Error: $pyenv_python can't be executed."
                return 1
              fi

              unset PYTHONHOME
              local ve=$($pyenv_python -c "import pkgutil; print('venv' if pkgutil.find_loader('venv') else ('virtualenv' if pkgutil.find_loader('virtualenv') else '''))")

              case $ve in
                "venv")
                  VIRTUAL_ENV=$(direnv_layout_dir)/python-$python_version
                  export VIRTUAL_ENV
                  if [[ ! -d $VIRTUAL_ENV ]]; then
                    $pyenv_python -m venv "$VIRTUAL_ENV"
                  fi
                  PATH_add "$VIRTUAL_ENV"/bin
                  ;;
                "virtualenv")
                  layout_python "$pyenv_python"
                  ;;
                *)
                  log_error "Error: neither venv nor virtualenv are available to ''${pyenv_python}."
                  return 1
                  ;;
              esac

              # e.g. Given "use pyenv 3.6.9 2.7.16", PYENV_VERSION becomes "3.6.9:2.7.16"
              [[ -z "$PYENV_VERSION" ]] && PYENV_VERSION=$python_version || PYENV_VERSION="''${python_version}:$PYENV_VERSION"
            done

            export PYENV_VERSION
          }

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
