{
  config,
  pkgs,
  lib,
  ...
}:
{
  #services.vector = {
    #sources = {
      ## OTLP Ingestion for Logs & Traces
      #otlp = {
        #type = "opentelemetry";
        #grpc = {
          #address = "localhost:4317";
        #};
        #http = {
          #address = "localhost:4318";
        #};
      #};
    #};
  #};
  
  # Open Firewall Ports
  networking.firewall.allowedTCPPorts = [ 4317 4318 ];
}
