FROM postgres:9.5.3

MAINTAINER "Guido Schmutz <guido.schmutz@trivadis.com>"

ENV HIVE_USER=hive
ENV HIVE_PASSWORD=hive

COPY hive-schema-2.3.0.postgres.sql /hive/hive-schema-2.3.0.postgres.sql
COPY hive-txn-schema-2.3.0.postgres.sql /hive/hive-txn-schema-2.3.0.postgres.sql
COPY upgrade-2.3.0-to-3.0.0.postgres.sql /hive/upgrade-2.3.0-to-3.0.0.postgres.sql
COPY upgrade-3.0.0-to-3.1.0.postgres.sql /hive/upgrade-3.0.0-to-3.1.0.postgres.sql
COPY upgrade-3.1.0-to-3.2.0.postgres.sql /hive/upgrade-3.1.0-to-3.2.0.postgres.sql

COPY init-hive-db.sh /docker-entrypoint-initdb.d/init-user-db.sh
