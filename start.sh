#!/bin/bash
# Create UWSGI socket for vision API
uwsgi --emperor /etc/uwsgi/vassals --uid root --gid root --enable-threads --daemonize /server/media/uwsgi-emperor.log
# Trigger migration process for vision DB
cd server

python3 manage.py migrate

python3 manage.py collectstatic --noinput
# restart the nginx service to connect with vision UWSGI
service nginx restart
