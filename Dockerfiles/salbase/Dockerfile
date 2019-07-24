
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

# Additional python3 libraries suport
RUN pip3 install astropy ipython pyyaml

# Make python3 link
RUN ln -s /usr/bin/python3.6 /usr/bin/python3


