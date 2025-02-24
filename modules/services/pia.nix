{
  config,
  pkgs,
  lib,
  inputs,
  ...
}: let
  cfg = config.clover.services.pia;
in {
  options.clover.services.pia = {
    enable = lib.mkEnableOption "enable pia vpn";
  };

  config = lib.mkIf cfg.enable {
    services.openvpn.servers = {
      pia = {
        autoStart = true;
        authUserPass = {
          username = "<redacted>";
          password = "<redacted>";
        };

        config = ''
          client
          dev tun
          proto udp
          remote <redacted> 1198
          resolv-retry infinite
          nobind
          persist-key
          persist-tun
          cipher aes-128-cbc
          auth sha1
          tls-client
          remote-cert-tls server

          auth-user-pass
          compress
          verb 1
          reneg-sec 0
      
          crl-verify ${./crl.pem}
          ca ${./ca.pem}

          disable-occ
        '';
      };
    };
  };
}
