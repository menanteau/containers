DOCKER_USER=saluser
DOCKER_IMA=lsstts/develop-env:20190610_sal3.10.0_salobj4
#DOCKER_IMA=centos7_salobj4
hostname="`hostname -s`-docker"
ip=$(ifconfig en0 | grep inet | awk '$1=="inet" {print $2}')
xhost + $ip

echo "starting docker with image: $DOCKER_IMA"
docker run -it -e DISPLAY=$ip:0 \
    -h $hostname \
    -v /tmp/.X11-unix:/tmp/.X11-unix \
    -v $HOME/salobj-home:/home/$DOCKER_USER/salobj-home \
    $DOCKER_IMA /home/$DOCKER_USER/salobj-home/docker/develop-env/setup_salobj.sh

