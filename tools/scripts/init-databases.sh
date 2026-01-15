#!/bin/bash
set -e

# Create multiple databases for Prodaric modules
psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
    -- Lease Management Database
    CREATE DATABASE prodaric_lease;
    GRANT ALL PRIVILEGES ON DATABASE prodaric_lease TO $POSTGRES_USER;

    -- Investment Analysis Database
    CREATE DATABASE prodaric_invest;
    GRANT ALL PRIVILEGES ON DATABASE prodaric_invest TO $POSTGRES_USER;

    -- Market Intelligence Database
    CREATE DATABASE prodaric_market;
    GRANT ALL PRIVILEGES ON DATABASE prodaric_market TO $POSTGRES_USER;

    -- Property Management Database
    CREATE DATABASE prodaric_manage;
    GRANT ALL PRIVILEGES ON DATABASE prodaric_manage TO $POSTGRES_USER;

    -- Analytics Database
    CREATE DATABASE prodaric_analytics;
    GRANT ALL PRIVILEGES ON DATABASE prodaric_analytics TO $POSTGRES_USER;
EOSQL

echo "Multiple databases created successfully!"
