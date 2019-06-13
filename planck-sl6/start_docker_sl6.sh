
DOCKER_IMA=sl6_planck
hostname="`hostname -s`-docker"
ip=$(ifconfig en0 | grep inet | awk '$1=="inet" {print $2}')
xhost + $ip

echo "starting docker with image: $DOCKER_IMA"
docker run -ti -e DISPLAY=$ip:0 \
    -h $hostname \
    -v /tmp/.X11-unix:/tmp/.X11-unix \
    -v /Users/felipe/DOCKER-SANDBOX/planck-sl6/home-felipe:/home/felipe \
    $DOCKER_IMA bash
