#!/bin/sh

chown -R root:jenkins /var/run/docker.sock
su - jenkins
exec "$@"

