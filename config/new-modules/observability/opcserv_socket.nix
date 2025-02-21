{
  config,
  pkgs,
  lib,
  ...
}:
{
  services = {
    vector = {
      settings = {
        sinks = {
          kafka_opcua = {
            encoding = {
              codec = "json";
            };
            inputs = [
              #"handle_opcua_framing"
              "opc_tcp_edhub"
              "opc_tcp_enhub"
            ];
            topic = "opcua";
          };
          opc_file_log_ed = {
            type = "file";
            path = "/tmp/log/vector/opc_debian-%Y-%m-%d.json";
            encoding.codec = "json";
            #compression = "zstd";
            inputs = [
              "opc_tcp_edhub"
            ];
          };
          opc_file_log_en = {
            type = "file";
            path = "/tmp/log/vector/opc_nixos-%Y-%m-%d.json";
            encoding.codec = "json";
            #compression = "zstd";
            inputs = [
              "opc_tcp_enhub"
            ];
          };
        };
        sources = {
          opc_tcp_edhub = {
            type = "exec";
            include_stderr = true;
            # maximum_buffer_size_bytes = 65536000;
            command = [
              "${pkgs.netcat}/bin/nc"
              "172.16.0.108"
              "9374"
            ];
            mode = "streaming";
            framing = {
              method = "length_delimited";
              length_delimited = {
                length_field_is_big_endian = false;
                # length_field_length = 1;
              };
            };
            decoding.codec = "json";
          };
          opc_tcp_enhub = {
            type = "exec";
            include_stderr = true;
            #maximum_buffer_size_bytes = 65536000;
            command = [
              "${pkgs.netcat}/bin/nc"
              "172.16.0.110"
              "9374"
            ];
            mode = "streaming";
            framing = {
              method = "length_delimited";
              length_delimited = {
                length_field_is_big_endian = false;
                # length_field_length = 1;
              };
            };
            decoding.codec = "json";
          };
        };
        #transforms = {
          #handle_opcua_framing = {
            #type = "remap";
            #inputs = [
              #"opc_tcp_edhub"
              #"opc_tcp_enhub"
            #];
            #source = ''
              #log(.message, level:"info")
              ### Read the first 4 bytes (u32 LE) for message length
              ##let len = .bytes[0..4].to_int32()?;

              ### If the length is valid, slice the message based on the length
              ##if len > 0 && .bytes.len() >= len as usize + 4 {
              ##let message = .bytes[4..(4 + len as usize)];
              ##.message = message;
              ##} else {
              ### If not enough data, we might want to drop or handle differently
              ##drop = true;
              ##}
            #'';
          #};
        #};
      };
    };
  };
}
