# Overlay of the benchmark's mitmproxy/Dockerfile (vendored unchanged in build/hrs-admin-router/app/mitmproxy/; it copies no files).
# What differs from upstream:
# - upstream's compose environment values are baked in (ENV after FROM): SERVER_HOSTNAME, SERVER_PORT.
# Everything else is upstream's, line for line.

FROM mitmproxy/mitmproxy:6.0.2
ENV SERVER_HOSTNAME=haproxy \
    SERVER_PORT=8001

WORKDIR /app

ENTRYPOINT mitmdump --mode reverse:http://${SERVER_HOSTNAME}:${SERVER_PORT} -p 8002 --set block_global=false --no-http2
