# Mostly from
# https://github.com/NixOS/nixpkgs/issues/63500#issuecomment-674835273
# and
# https://github.com/meck/meck-xmonad/blob/8f2c9a5c10d2fd38e0dc6e8eb3b7386884faadcd/overlay.nix
self: super: {
  haskellPackages = super.haskellPackages.override (old: {
    overrides = with self.haskell.lib; self.lib.composeExtensions (old.overrides or (_: _: { })) (hself: hsuper: {

      #gi-cairo-connector = markUnbroken (hsuper.gi-cairo-connector);

      #gi-cairo-render = markUnbroken (overrideCabal (hsuper.gi-cairo-render) (drv: {
        #src = self.fetchFromGitHub {
          #owner = "thestr4ng3r";
          #repo = "gi-cairo-render";
          #rev = "8727c43cdf91aeedffc9cb4c5575f56660a86399";
          #sha256 = "16kqh2ck0dad1l4m6q9xs5jqj9q0vgpqrzb2dc90jk8xwslmmhxd";
          #};
          #editedCabalFile = null;
          #postUnpack = ''
          #mv source all
          #mv all/gi-cairo-render source
          #'';
          #}));

          #gi-dbusmenu = markUnbroken (hself.gi-dbusmenu_0_4_8);

          #gi-dbusmenugtk3 = markUnbroken (hself.gi-dbusmenugtk3_0_4_9);

          #gi-gdk = hself.gi-gdk_3_0_23;

          #gi-gdkx11 = markUnbroken (overrideSrc hsuper.gi-gdkx11 {
            #src = self.fetchurl {
              #url = "https://hackage.haskell.org/package/gi-gdkx11-3.0.10/gi-gdkx11-3.0.10.tar.gz";
              #sha256 = "0kfn4l5jqhllz514zw5cxf7181ybb5c11r680nwhr99b97yy0q9f";
            #};
            #version = "3.0.10";
          #});

          #gi-gtk-hs = markUnbroken (hself.gi-gtk-hs_0_3_9);

          #gi-xlib = markUnbroken (hself.gi-xlib_2_0_9);

          #gtk-sni-tray = markUnbroken (hsuper.gtk-sni-tray);

          #gtk-strut = markUnbroken (hsuper.gtk-strut);

      # Version with meck's fix for struts in hidpi
      # https://github.com/taffybar/gtk-strut/pull/5
      #gtk-strut = self.haskellPackages.callCabal2nix "gtk-strut"
        #(self.fetchgit {
          #url = "https://github.com/taffybar/gtk-strut.git";
          #rev = "cc8d4608c26f9989cc3879bbbc6c2835b9648015";
          #sha256 = "0ccg8fi262cy0hw2pahciaw05bycl9lav01bw4rqgjwiyhbkxnpa";
        #})
        #{ };

        xmonad-contrib = overrideSrc hsuper.xmonad-contrib {
          #version = "unstable-2020-06-23";
          version = "v0.18.1";
          src = self.fetchFromGitHub {
            repo = "xmonad-contrib";
            owner = "xmonad";
            #rev = "3dc49721b69f5c69c5d5e1ca21083892de72715d";
            rev = "f5f99c8abf225b6a6f705add858578bad2384912";
            #sha256 = "0d89y59qbd1z77d1g6fgfj71qjr65bclhb0jkhmr5ynn88rqqfv8";
            sha256 = "sha256-CggQ5ykKltTZLZEy02bv8dkGynZb4c5IUmq9GE4dKUQ=";
          };
        };
      });
    });
  }
