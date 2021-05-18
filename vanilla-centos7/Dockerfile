# To build:
# docker build -t vanilla_centos7 --rm=true .

# Clean up:
# docker rm $(docker ps -a -q)

FROM centos:7

LABEL name="CentOS Base Image" \
    vendor="CentOS" \
    license="GPLv2" \
    build-date="20161214"

# Definitions

RUN yum -y install patch
RUN yum -y install deltarpm
RUN yum -y install xterm boost-python boost-python-devel maven  python-devel java-1.7.0-openjdk-devel
RUN yum -y install epel-release
RUN yum -y install python-astropy ipython
RUN yum -y install wget
RUN yum -y install git git-svn
RUN yum -y install make
RUN yum -y install emacs
RUN yum -y install gcc-c++ gcc.x86_64 gcc-gfortran

RUN yum -y install svn git git-svn ruby rubygems
RUN gem install svn2git

## Add $HSUSER as user
RUN useradd -ms /bin/bash felipe
RUN usermod -aG wheel felipe

ENV USER felipe
ENV HOME /home/felipe
ENV SHELL /bin/bash

USER felipe
WORKDIR /home/felipe

