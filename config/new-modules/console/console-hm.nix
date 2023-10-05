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
    broot = {
      enable = true;
      enableBashIntegration = true;
      enableZshIntegration = true;
    };
    direnv = {
      enable = true;
      enableBashIntegration = true;
      enableNushellIntegration = true;
      enableZshIntegration = true;
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
      enableZshIntegration = true;
      enableBashIntegration = true;
      enableNushellIntegration = true;
    };

    nushell.enable = true;

    readline.enable = (if (config ? "mine") then (config.mine.console.enable != true) else true);

    zsh = {
      enable = true;
      enableCompletion = true;
      enableAutosuggestions = true;
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

      history.size = 1000000;
    };
  };

  home.sessionVariables = {
    MANPAGER = "sh -c 'col -bx | ${pkgs.bat}/bin/bat --paging=always -l man -p'";
  };
}
