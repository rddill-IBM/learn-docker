#!/bin/bash

docker build -f Dockerfile.dev -t rddill/react2 .

# path must match WORKDIR specification ... 
# WORDIR === /usr/app
# -v must start with /usr/app
docker run -it -p 6101:3000 -v /usr/app/node_modules -v $PWD:/usr/app rddill/react2
#docker run -it -p 6101:3000 -v /app/node_modules rddill/react2
# docker run -it -p 6101:3000 rddill/react2
