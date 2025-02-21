{
  config,
  pkgs,
  lib,
  ...
}:
{
  # Enable Grafana for Visualization
  #services.grafana = {
    #provision = {
      #datasources.settings.datasources = [
        #{
          #name = "Tempo";
          #type = "tempo";
          #url = "http://localhost:3200";
        #}
      #];
    #};
  #};

  #services.vector.settings = {
    #sinks = {
      #tempo = {
        #type = "opentelemetry";
        #inputs = [
          #"otlp"
        #];
        #endpoint = "http://localhost:4317";
      #};
    #};
  #};

  # Open Firewall Ports (Optional)
  #networking.firewall.allowedTCPPorts = [
    # 3200
  #];
}
