HSUSER=headerservice
DOCKER_IMA=lsstts/at_headerservice:sal3.10.0_3.10.0_salobj4.1.0
hostname="`hostname -s`-docker"
ip=$(ifconfig en0 | grep inet | awk '$1=="inet" {print $2}')
xhost + $ip

echo "starting docker with image: $DOCKER_IMA"
docker run -ti -e DISPLAY=$ip:0 \
    -h $hostname \
    -v /tmp/.X11-unix:/tmp/.X11-unix \
    -v $HOME/sal-home:/home/$HSUSER \
    $DOCKER_IMA bash
