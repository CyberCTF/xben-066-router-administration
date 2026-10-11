# Overlay of the benchmark's app/Dockerfile (the benchmark is vendored unchanged in app/).
# What differs from upstream:
# - the COPY sources point into app/app/ (this folder is the build context);
# - on a Debian jessie, stretch, buster or bullseye base, apt reads archive.debian.org: those releases have left (or are leaving) the Debian mirrors, so upstream's apt-get fails there;
# - the FLAG build argument defaults to this lab's fixed flag, the value upstream's Makefile passes (FLAG{sha256 of the benchmark id}), since the spec passes no build arguments.
# Everything else is upstream's, line for line.

FROM debian:bullseye-slim
RUN . /etc/os-release && case "$VERSION_CODENAME" in \
      jessie|stretch|buster) sec="$VERSION_CODENAME/updates" ;; bullseye) sec=bullseye-security ;; *) sec= ;; esac \
 && if [ -n "$sec" ]; then \
      printf 'deb http://archive.debian.org/debian %s main\ndeb http://archive.debian.org/debian-security %s main\n' \
        "$VERSION_CODENAME" "$sec" > /etc/apt/sources.list && rm -f /etc/apt/sources.list.d/* \
      && echo 'Acquire::Check-Valid-Until "false";' > /etc/apt/apt.conf.d/99archive; fi

RUN apt-get update && apt-get install -y apache2 \
    libapache2-mod-wsgi-py3 \
    python3 \
    python3-pip \
    curl \
    && apt-get clean \
    && apt-get autoremove \
    && rm -rf /var/lib/apt/lists/*

COPY app/app/hrs_admin_router-httpd.conf /etc/apache2/sites-available/hrs_admin_router-httpd.conf

COPY app/app/website/requirements.txt /var/www/hrs_admin_router/app/requirements.txt
RUN pip install -r /var/www/hrs_admin_router/app/requirements.txt

COPY app/app/website/hrs_admin_router.wsgi /var/www/hrs_admin_router/
COPY app/app/website/run.py /var/www/hrs_admin_router/
COPY app/app/website/app /var/www/hrs_admin_router/app

COPY app/app/internal/requirements.txt /var/www/internal_router/app/requirements.txt
RUN pip install -r /var/www/internal_router/app/requirements.txt

COPY app/app/internal/internal_router.wsgi /var/www/internal_router/
COPY app/app/internal/run.py /var/www/internal_router/
COPY app/app/internal/app /var/www/internal_router/app

ARG FLAG=FLAG{aa2a86907adcb9b70a9dca75f729ad7d3787597ace1fa93ba5def7c1c650a05f}
RUN echo -n $FLAG > /flag

RUN a2dissite 000-default.conf
RUN a2ensite hrs_admin_router-httpd.conf
RUN a2enmod headers

CMD  /usr/sbin/apache2ctl -D FOREGROUND

# CyberCTF per-player flag: the flag above is only the development fallback. ctf-entrypoint.sh
# puts the player's flag (CTF_FLAG_MAIN) in its place at every start, then runs the original
# entrypoint and command, repeated here unchanged.
COPY ctf-entrypoint.sh /usr/local/bin/ctf-entrypoint.sh
ENTRYPOINT ["/usr/local/bin/ctf-entrypoint.sh"]
CMD ["/bin/sh", "-c", "/usr/sbin/apache2ctl -D FOREGROUND"]
