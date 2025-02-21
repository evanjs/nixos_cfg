{ config, pkgs, lib, ... }:
with lib;
let
  cfg = config.private;
in
{
  options.private = {
    passwords = mkOption {
      type = types.attrsOf (types.either types.str types.attrs);
      default = {};
      internal = true;
    };
  };
  config = {
    private = {
      passwords = {
        freenode = "Ry,Ty#O.YPy=#uV$+]iFV{}7*O<XdpN1jrOfdFw%h4<MH4>J9zRtqZ]zyJ[L=aqb";
        gitterIrc = ""; #":cP:gnN>2R,WBLHC7B~e%Rmp8PXzho+KpbA*nmiAUf>?7oR7eFyewd9Ebm4_EF8=";
        jupyter = "sha1:9b4bc3c71423:cda3bfd503018c2b311a661712c1f738bd7a7139";
        nextcloud = "e=I+GOX{Rc2kMlP64x$VMT8(V9V@pwk54.;SLfeO{JqW#VHNlE3PYCzjTEi8tlpY";
        samba = {
          work = {
            filename = ./work_smb;
          };
        };
        twitchChatOauth = "w6=#XnB^ZofN+4TY8_fn6HN@FkL#:+>G=*XEj:V+pKC4z,9d&U&!TX)>jX6M2LV8";
        zncHash = "b8a08b03da6075c0e4263efcc86188a86fd728f9d9636a2be61f279c95a1d962";
        zncMethod = "sha256";
        zncSalt = "vDf(THZ6gH(QsfyA7,KL";
        znc-savebuff = "U>j]bTR,G@d0z.bd9iR++3+]^yxrXTyfWq=Z5*He,+M)m[S%>xsIdulXZ@un}QMc";
      };
    };
  };
}
