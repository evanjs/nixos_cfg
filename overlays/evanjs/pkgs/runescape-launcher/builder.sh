source $stdenv/setup
PATH=$dpkg/bin:$PATH

dpkg -x $src unpacked
substituteInPlace unpacked/usr/bin/runescape-launcher --replace /usr/share/games/ $out/share/games/

cp -r unpacked/* $out/
