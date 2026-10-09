# Overlay of the benchmark's mysql/Dockerfile (vendored unchanged in build/hrs-admin-router/app/mysql/; it copies no files).
# What differs from upstream:
# - mysql:5.7.15 is now mysql:5.7.44: Docker can no longer pull mysql:5.7.15 (an old schema 1 manifest); 5.7.44 is the last 5.7 release.
# Everything else is upstream's, line for line.

FROM mysql:5.7.44

ENV MYSQL_ROOT_PASSWORD=hrs_admin_router
ENV MYSQL_DATABASE=database

EXPOSE 3306
