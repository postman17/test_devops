#!/bin/bash

set -x
echo "Starting backend ..."

if [[ ${POSTGRES_HOST} ]]; then
    export PGPASSWORD=${POSTGRES_PASSWORD}
    until psql -h $POSTGRES_HOST -U $POSTGRES_USER -d $POSTGRES_NAME -c '\l'; do
      >&2 echo "Postgres is unavailable - sleeping"
      sleep 1
    done
    >&2 echo "Postgres is up - continuing"
    psql -h $POSTGRES_HOST -U $POSTGRES_USER -d template1 -c 'create extension hstore;'
    unset PGPASSWORD
fi


python manage.py collectstatic --noinput
#python manage.py loaddata fixtures.json
python manage.py migrate --noinput
gunicorn -b 0:8028 firstdev.wsgi:application

echo "End"
