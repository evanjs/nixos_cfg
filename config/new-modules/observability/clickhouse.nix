{
  config,
  pkgs,
  lib,
  ...
}:
#let
#defaultClickhouseConfigXML = builtins.readFile "${config.services.clickhouse.package}/etc/clickhouse-server/config.xml";
#clickhouseConfigXML = builtins.toXML {
#clickhouse = {
#listen_host = "::";
#tcp_port = 9000;
#http_port = 8123;
#log_level = "trace";
#max_memory_usage = 10000000000;
#path = "/var/lib/clickhouse";
#logger = {
#level = "information";
#log = "/var/log/clickhouse-server/clickhouse.log";
#};
#};
#};
#in
let
  clickhouseExperimentalFeaturesConfigXMLNix = {
    profiles = {
      default = {
        allow_experimental_json_type = true;
      };
    };
  };
  #clickhouseExperimentalFeaturesConfigXML = pkgs.runCommand "clickhouse-experimental-features.xml" {} ''
    #${pkgs.libnixxml}/bin/nixexpr2xml \
    #${__toJSON clickhouseExperimentalFeaturesConfigXMLNix} \
    #--attr-style=simple \
    #--root-element clickhouse > $out
  #'';
  clickhouseExperimentalFeaturesConfigXML = ''
    <clickhouse>
      <profiles>
        <default>
          <allow_experimental_json_type>true</allow_experimental_json_type>
        </default>
      </profiles>
    </clickhouse>
  '';

  clickhouseDateTimeInputFormatConfigXMLNix = {
    profiles = {
      default = {
        date_time_input_format = "best_effort";
      };
    };
  };
  #clickhouseDateTimeInputFormatConfigXML = pkgs.runCommand "clickhouse-datetime-input-format.xml" {} ''
    #${pkgs.libnixxml}/bin/nixexpr2xml \
    #${__toJSON clickhouseDateTimeInputFormatConfigXMLNix} \
    #--attr-style=simple \
    #--root-element clickhouse > $out
  #'';
  clickhouseDateTimeInputFormatConfigXML = ''
    <clickhouse>
      <profiles>
        <default>
          <date_time_input_format>best_effort</date_time_input_format>
        </default>
      </profiles>
    </clickhouse>
  '';
in
{

  systemd.services.vector.serviceConfig = {
    SupplementaryGroups = [
      "clickhouse"
    ];
  };

  # Enable ClickHouse for Structured Logs & Traces
  services.clickhouse = {
    enable = true;
  };

  environment.etc.clickhouse_date_time_input = {
    text = clickhouseDateTimeInputFormatConfigXML;
    target = "clickhouse-server/users.d/datetime.xml";
  };

  environment.etc.clickhouse_experimental_features = {
    text = clickhouseExperimentalFeaturesConfigXML;
    target = "clickhouse-server/users.d/experimental.xml";
  };

  services.grafana = {
    provision = {
      datasources.settings.datasources = [
        {
          name = "ClickHouse";
          type = "grafana-clickhouse-datasource";
          url = "http://localhost:8123";
        }
      ];
    };
  };

  services.traefik = {
    dynamicConfigOptions = {
      routers = {
        clickhouse = {
          middlewares = [
            "httpsRedirect"
          ];
          rule = "Host(`${config.networking.hostName}-clickhouse.takaya-boa.ts.net`)";
          service = "clickhouse";
          entryPoints = [ "websecure" ];
          tls = {
            certResolver = "tailscale";
            domains = [
              "${config.networking.hostName}-clickhouse.takaya-boa.ts.net"
            ];
          };
        };
      };

      services = {
        clickhouse.loadBalancer.servers = [ { url = "http://localhost:8123"; } ];
      };
    };
  };

  services.vector = {
    settings = {
      sinks = {
        clickhouse = {
          type = "clickhouse";
          inputs = [
            #"otlp"
            #"host_metrics"
            "journald"
          ];
          endpoint = "http://localhost:8123";
          database = "logs";
          #table = "otel_traces";
          table = "journald";
          skip_unknown_fields = true;
        };
      };
    };
  };
}
