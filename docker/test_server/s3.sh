#!/bin/sh
# `/sbin/setuser memcache` runs the given command as the user `memcache`.
# If you omit that part, the command will be run as root.
export MINIO_ACCESS_KEY=accessKey1
export MINIO_SECRET_KEY=verySecretKey1
exec /sbin/setuser app minio server /home/app/minio_data  >>/var/log/s3.log 2>&1
