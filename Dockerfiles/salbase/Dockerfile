
FROM centos:7

LABEL name="CentOS Base Image" \
    vendor="CentOS" \
    license="GPLv2" \
    build-date="20161214"

# Locations
ARG INSTALL_PATH=/opt/lsst
ARG REPOS_TMP=/tmp/repos

RUN yum -y install https://centos7.iuscommunity.org/ius-release.rpm
RUN yum -y install python36u python36u-devel python36u-pip \
    patch \
    deltarpm \
    xterm boost-python boost-python-devel maven python-devel java-1.7.0-openjdk-devel \
    epel-release \
    wget \
    git \
    make \
    emacs \
    gcc-c++ gcc.x86_64 gcc-gfortran

# Pip2/3 -- once we upgrade it's renamed pip3.6 --> pip3
RUN pip3.6 install --upgrade pip

# For sal/salobj suport
RUN pip3 install astropy ipython pyyaml
RUN pip3 install setuptools==41.0.1 jsonschema==3.0.1 Cython==0.29.12

# Make python3 link
RUN ln -s /usr/bin/python3.6 /usr/bin/python3

## Add $HSUSER as user
#ARG HSUSER=headerservice
#RUN useradd -ms /bin/bash $HSUSER
#RUN usermod -aG wheel $HSUSER

## Make /opt writable by $HSUSER
#RUN chown $HSUSER:$HSUSER /opt

#ENV USER $HSUSER
#ENV HOME /home/$HSUSER
#ENV SHELL /bin/bash

#USER $HSUSER
#WORKDIR /home/$HSUSER


