# Overlay of the benchmark's haproxy/Dockerfile (that folder is vendored unchanged in app/, moved here from build/hrs-admin-router/app/haproxy/).
# What differs from upstream:
# - the COPY sources point into app/ (this folder is the build context);
# - on a Debian jessie, stretch, buster or bullseye base, apt reads archive.debian.org: those releases have left (or are leaving) the Debian mirrors, so upstream's apt-get fails there;
# - upstream's compose environment values are baked in (ENV after FROM): SERVER_HOSTNAME, SERVER_PORT, with the router's host name hrs_admin_router written hrs-admin-router (Isoloom machine names are DNS labels, no underscores).
# Everything else is upstream's, line for line.

FROM haproxy:2.0.5
RUN . /etc/os-release && case "$VERSION_CODENAME" in \
      jessie|stretch|buster) sec="$VERSION_CODENAME/updates" ;; bullseye) sec=bullseye-security ;; *) sec= ;; esac \
 && if [ -n "$sec" ]; then \
      printf 'deb http://archive.debian.org/debian %s main\ndeb http://archive.debian.org/debian-security %s main\n' \
        "$VERSION_CODENAME" "$sec" > /etc/apt/sources.list && rm -f /etc/apt/sources.list.d/* \
      && echo 'Acquire::Check-Valid-Until "false";' > /etc/apt/apt.conf.d/99archive; fi
ENV SERVER_HOSTNAME=hrs-admin-router \
    SERVER_PORT=80

RUN apt-get update && apt-get install -y curl 

COPY app/haproxy.cfg /usr/local/etc/haproxy/haproxy.cfg
