#!/bin/bash

if [ ! -f ${BITBUCKET_HOME}/shared/bitbucket.properties ]; then

mkdir -p ${BITBUCKET_HOME}/shared/
cat > ${BITBUCKET_HOME}/shared/bitbucket.properties <<EOF
server.port=7990
server.secure=true
server.scheme=https
server.proxy-port=443
server.proxy-name=git.example.ir
EOF

fi
