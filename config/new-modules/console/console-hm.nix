{ config, pkgs, lib, ... }:
{
  programs = {
    git = {
      userName = "Evan Stoll";
      userEmail = "evanjsx@gmail.com";
      enable = true;
      delta = {
        enable = true;
        options = {
          decorations = {
            commit-decoration-style = "bold yellow box ul";
            file-decoration-style = "none";
            file-style = "bold yellow ul";
          };
          features = "decorations";
          line-numbers = true;
          whitespace-error-style = "22 reverse";
        };
      };
    };
    jujutsu = {
      enable = true;
      settings = {
        user = {
          email = "evanjsx@gmail.com";
          name = "Evan Stoll";
        };
      };
    };
    broot = {
      enable = true;
      enableBashIntegration = true;
      enableNushellIntegration = true;
      enableZshIntegration = true;
    };
    direnv = {
      enable = true;

      nix-direnv = {
        enable = true;
      };
    };

    htop.enable = true;

    starship = {
      enable = true;
      enableBashIntegration = true;
      enableNushellIntegration = true;
      enableZshIntegration = true;

      settings = {
        line_break.disabled = true;
        git_branch.style = "bold green";
        git_status.disabled = if pkgs.helpers.isNixOS then false else true;
      };
    };
    
    zoxide = {
      enable = true;
      enableNushellIntegration = true;
    };

    yazi = {
      enable = true;
      enableNushellIntegration = true;
    };

    nh = {
      enable = true;
    };

    nushell = {
      enable = true;

      plugins = with pkgs.nushellPlugins; [
        polars
        query
        semver
        skim
      ];

      settings = {
        buffer_editor = "nvim";
        show_banner = "short";
      };
    };

    readline.enable = (if (config ? "mine") then (config.mine.console.enable != true) else true);

    zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestion.enable = true;
      oh-my-zsh.enable = true;
      
      initExtraBeforeCompInit = ''
        # checks to see if we are in a windows or linux dir
        function isWinDir {
          case $PWD/ in
            /mnt/*) return $(true);;
            *) return $(false);;
          esac
        }
        # wrap the git command to either run windows git or linux
        function git {
          if isWinDir
          then
            git.exe "$@"
          else
            ${pkgs.git}/bin/git "$@"
          fi
        }
      '';

      history = {
        extended = true;
        size = 1000000;
      };
    };
  };

  home.shell = {
    enableNushellIntegration = true;
  };

  home.sessionVariables = {
    MANPAGER = "sh -c 'col -bx | ${pkgs.bat}/bin/bat --paging=always -l man -p'";
  };
}
