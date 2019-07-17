{ stdenv, fetchFromGitHub, zsh }:

# To make use of this derivation, use
# `programs.zsh.promptInit = "source ${pkgs.zsh-powerlevel9k}/share/zsh-powerlevel9k/powerlevel9k.zsh-theme";`

stdenv.mkDerivation rec {
  name = "powerlevel9k-${version}";
  version = "2019-04-02";
  src = fetchFromGitHub {
    owner = "bhilburn";
    repo = "powerlevel9k";
    rev = "3dafd79c41f8601b055e607ffefbfe3250c26040";
    sha256 = "0vc5d7w8djg3ah9jvd87xqbhpin1lpflm6wgmhn3jgijwcjkxpg3";
  };

  installPhase= ''
    install -D powerlevel9k.zsh-theme --target-directory=$out/share/zsh-powerlevel9k
    install -D functions/* --target-directory=$out/share/zsh-powerlevel9k/functions
  '';

  meta = {
    description = "A beautiful theme for zsh";
    homepage = https://github.com/bhilburn/powerlevel9k;
    license = stdenv.lib.licenses.mit;

    platforms = stdenv.lib.platforms.unix;
    maintainers = [ stdenv.lib.maintainers.pierrechevalier83 ];
  };
}
