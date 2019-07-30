#!/bin/bash

# set ClamAV env
COMMAND="dhcpd"

# Starting Container
echo "Starting container .."
if [ "$@" = "dhcpd" ]; then
	echo "Executing: ${COMMAND}"
	exec ${COMMAND}
else
	echo "Not executing: ${COMMAND}"
	echo "Executing: ${@}"
	exec $@
fi
