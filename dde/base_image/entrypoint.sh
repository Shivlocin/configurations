#!/bin/bash

if [[ ! -f "/.dockerenv" ]]; then
  echo "This script should only be executed inside of a docker container!"
  echo "Exiting."
  exit 1
fi

# if both not set we do not need to do anything
if [ -z "${HOST_USER_ID}" -a -z "${HOST_USER_GID}" ]; then
    echo "Host UID and GID must be passed as env vars."
    echo "Check docker run." 
    exit 0
fi

usermod -u "${HOST_USER_ID}" "${USER}" &> /dev/null
groupmod -g "${HOST_USER_GID}" "${USER}" &> /dev/null

if [[ -v ENABLE_SSH && $ENABLE_SSH ]]; then
  service ssh start
fi

if [[ -n $1 ]]; then
  su -c "$1" "${USER}"
else
  su "${USER}"
fi
