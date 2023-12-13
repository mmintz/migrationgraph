#!/bin/bash

# Set initial environment variables based on DB_CHOICE
if [ "$DB_CHOICE_FROM" = "db1" ]; then
    export DB_HOST=$DB1_HOST \
    DB_PORT=$DB1_PORT \
    DB_NAME=$DB1_NAME \
    DB_USER=$DB1_USER \
    DB_PASSWORD=$DB1_PASSWORD \
    DB_SCHEMA=$DB1_SCHEMA \
    STARTING_TABLE=$APP_BRANDS_STARTING_TABLE \
    STARTING_KEY_COLUMN=$APP_BRANDS_STARTING_KEY_COLUMN \
    KEY_VALUE=$APP_BRANDS_KEY_VALUE \
    EXCLUDED_TABLES=$APP_BRANDS_EXCLUDED_TABLES
else
    export DB_HOST=$DB2_HOST \
    DB_PORT=$DB2_PORT \
    DB_NAME=$DB2_NAME \
    DB_USER=$DB2_USER \
    DB_PASSWORD=$DB2_PASSWORD \
    DB_SCHEMA=$DB2_SCHEMA \
    STARTING_TABLE=$TENANT_STARTING_TABLE \
    STARTING_KEY_COLUMN=$TENANT_STARTING_KEY_COLUMN \
    KEY_VALUE=$TENANT_KEY_VALUE \
    EXCLUDED_TABLES=$TENANT_EXCLUDED_TABLES
fi

# Execute the Jupyter notebooks
python -m jupyter nbconvert --to notebook --execute --stdout bfstraversal.ipynb
python -m jupyter nbconvert --to notebook --execute --stdout queries_to_csv.ipynb
    export DB_HOST=$DB_TO_HOST \
    DB_PORT=$DB_TO_PORT \
    DB_NAME=$DB_TO_NAME \
    DB_USER=$DB_TO_USER \
    DB_PASSWORD=$DB_TO_PASSWORD \
    DB_SCHEMA=$DB_TO_SCHEMA
python -m jupyter nbconvert --to notebook --execute --stdout importing_final.ipynb

python -m jupyter nbconvert --to notebook --execute --stdout all_tenants_sum.ipynb

# Keep the script running (you can remove this line if you don't want the container to keep running after the script completes)
tail -f /dev/null