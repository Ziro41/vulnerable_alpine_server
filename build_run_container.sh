#/bin/sh

docker build --tag 'vulnerable_cronjob' .
docker run --cap-add NET_ADMIN --device /dev/net/tun  -it --name vulnerable_cronjob vulnerable_cronjob zsh
