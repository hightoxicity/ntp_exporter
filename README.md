# ntp\_exporter

This is a Prometheus exporter that, when running on a node, checks the drift
of that node's clock against a given NTP server.

## Installation

To build the binary:

```bash
make
```

The binary can also be installed with `go get`:

```bash
go get github.com/sapcc/ntp_exporter
```

To build the Docker container:

```bash
make GOLDFLAGS="-w -linkmode external -extldflags -static" && docker build .
```

## Usage

Command-line options: (Only `-ntp.server` is required.)

```plain
  -log.format value
        Set the log target and format. Example: "logger:syslog?appname=bob&local=7" or "logger:stdout?json=true" (default "logger:stderr")
  -log.level value
        Only log messages with the given severity or above. Valid levels: [debug, info, warn, error, fatal] (default "info")
  -ntp.protocol-version int
        NTP protocol version to use. (default 4)
  -ntp.server string
        NTP server to use (required).
  -ntp.measurement-duration duration
        Repeat the measurements for the specified duration and calculate median in case the drift is unusually high (>10ms). (default 30s)
  -version
        Print version information.
  -web.listen-address string
        Address on which to expose metrics and web interface. (default ":9559")
  -web.telemetry-path string
        Path under which to expose metrics. (default "/metrics")
```
