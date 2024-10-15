#!/bin/bash
set -e

# Ensure the HIVE_PASSWORD environment variable is set
if [ -z "$HIVE_PASSWORD" ]; then
  echo "HIVE_PASSWORD environment variable is not set."
  exit 1
fi

# Ensure the HIVE_USER environment variable is set
if [ -z "$HIVE_USER" ]; then
  echo "HIVE_USER environment variable is not set."
  exit 1
fi


psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" <<-EOSQL
  CREATE USER '$HIVE_USER' WITH PASSWORD '$HIVE_PASSWORD';
  CREATE DATABASE metastore;
  GRANT ALL PRIVILEGES ON DATABASE metastore TO hive;

  \c metastore

  \i /hive/hive-schema-2.3.0.postgres.sql
  \i /hive/hive-txn-schema-2.3.0.postgres.sql
  \i /hive/upgrade-2.3.0-to-3.0.0.postgres.sql
  \i /hive/upgrade-3.0.0-to-3.1.0.postgres.sql
  \i /hive/upgrade-3.1.0-to-3.2.0.postgres.sql

  \pset tuples_only
  \o /tmp/grant-privs
SELECT 'GRANT SELECT,INSERT,UPDATE,DELETE ON "' || schemaname || '"."' || tablename || '" TO hive ;'
FROM pg_tables
WHERE tableowner = CURRENT_USER and schemaname = 'public';
  \o
  \i /tmp/grant-privs
EOSQL
