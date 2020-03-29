# Note: This Dockerfile is based on https://hub.docker.com/r/bde2020/hive-metastore-postgresql
# The following changes have been made:
#

FROM postgres:9.5.3

MAINTAINER "Guido Schmutz <guido.schmutz@trivadis.com>"

COPY hive-schema-2.3.0.postgres.sql /hive/hive-schema-2.3.0.postgres.sql
COPY hive-txn-schema-2.3.0.postgres.sql /hive/hive-txn-schema-2.3.0.postgres.sql

COPY init-hive-db.sh /docker-entrypoint-initdb.d/init-user-db.sh
