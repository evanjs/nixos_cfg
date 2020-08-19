self: super:
{
  haskellPackages = super.haskellPackages.override (old: {
    overrides = with self.haskell.lib; self.lib.composeExtensions (old.overrides or (_: _: {})) (hself: hsuper: {
      gi-cairo-render = overrideCabal (hsuper.gi-cairo-render) (drv: {
        src = self.fetchFromGitHub {
          owner = "thestr4ng3r";
          repo = "gi-cairo-render";
          rev = "8727c43cdf91aeedffc9cb4c5575f56660a86399";
          sha256 = "16kqh2ck0dad1l4m6q9xs5jqj9q0vgpqrzb2dc90jk8xwslmmhxd";
        };
        editedCabalFile = null;
        postUnpack = ''
          mv source all
          mv all/gi-cairo-render source
        '';
      });
      gi-dbusmenu = hself.gi-dbusmenu_0_4_8;
      gi-dbusmenugtk3 = hself.gi-dbusmenugtk3_0_4_9;
      gi-gdk = hself.gi-gdk_3_0_23;
      gi-gdkx11 = overrideSrc hsuper.gi-gdkx11 {
        src = self.fetchurl {
          url = "https://hackage.haskell.org/package/gi-gdkx11-3.0.10/gi-gdkx11-3.0.10.tar.gz";
          sha256 = "0kfn4l5jqhllz514zw5cxf7181ybb5c11r680nwhr99b97yy0q9f";
        };
        version = "3.0.10";
      };
      gi-gtk-hs = hself.gi-gtk-hs_0_3_9;
      gi-xlib = hself.gi-xlib_2_0_9;
      gtk-sni-tray = markUnbroken (hsuper.gtk-sni-tray);
      gtk-strut = markUnbroken (hsuper.gtk-strut);
      taffybar = markUnbroken (appendPatch hsuper.taffybar (self.fetchpatch {
        url = "https://github.com/taffybar/taffybar/pull/494/commits/a7443324a549617f04d49c6dfeaf53f945dc2b98.patch";
        sha256 = "0prskimfpapgncwc8si51lf0zxkkdghn33y3ysjky9a82dsbhcqi";
      }));
      xmonad-contrib = overrideSrc hsuper.xmonad-contrib {
        version = "unstable-2020-06-23";
        src = self.fetchFromGitHub {
          repo = "xmonad-contrib";
          owner = "xmonad";
          rev ="3dc49721b69f5c69c5d5e1ca21083892de72715d";
          sha256 = "0d89y59qbd1z77d1g6fgfj71qjr65bclhb0jkhmr5ynn88rqqfv8";
        };
      };
    });
  });
}

