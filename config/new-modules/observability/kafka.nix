{ config, pkgs, ... }:
let
  serverAddr = "localhost";
  kafkaListenSockAddr = "${serverAddr}:9092";
  kafkaControllerListenSockAddr = "${serverAddr}:9093";
in
{
  environment.systemPackages = with pkgs; [
    config.services.apache-kafka.package
    kafkactl
  ];

  services.apache-kafka = {
    enable = true;
    clusterId = "IqeJaAAAQQSxg7bpWd5syQ";
    formatLogDirs = true;
    settings = {
      listeners = [
        "PLAINTEXT://${kafkaListenSockAddr}"
        "CONTROLLER://${kafkaControllerListenSockAddr}"
      ];
      "listener.security.protocol.map" = [
        "PLAINTEXT:PLAINTEXT"
        "CONTROLLER:PLAINTEXT"
      ];
      "controller.quorum.voters" = [
        "1@${kafkaControllerListenSockAddr}"
      ];
      "controller.listener.names" = [ "CONTROLLER" ];

      "node.id" = 1;
      "process.roles" = [
        "broker"
        "controller"
      ];

      # "max.message.bytes" = "65536";

      "socket.send.buffer.bytes" = 102400;
      "socket.receive.buffer.bytes" = 102400;
      "socket.request.max.bytes" = 104857600;

      "log.dirs" = [ "/var/log/apache-kafka" ];
      "offsets.topic.replication.factor" = 1;
      "transaction.state.log.replication.factor" = 1;
      "transaction.state.log.min.isr" = 1;
    };
  };

  systemd.services.apache-kafka.serviceConfig.StateDirectory = [ "apache-kafka" ];

  services.vector.settings = {
    sinks = {
      kafka_opcua = {
        type = "kafka";
        bootstrap_servers = "localhost:9092";
      };
    };
  };
}
