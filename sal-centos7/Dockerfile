# to build
# docker build -t centos7_sal --rm=true .

# Clean up
# docker rm $(docker ps -a -q)


FROM centos:7

LABEL name="CentOS Base Image" \
    vendor="CentOS" \
    license="GPLv2" \
    build-date="20161214"

# Definitions
ARG FITSIO_VERSION=1.0.4
ARG SAL_VERSION=3.10.0_001
ARG HSUSER=felipe

RUN yum -y install https://centos7.iuscommunity.org/ius-release.rpm
RUN yum -y install python36u python36u-devel python36u-pip
RUN yum -y install python2-pip
RUN yum -y install patch

RUN yum -y install deltarpm
RUN yum -y install xterm boost-python boost-python-devel maven  python-devel java-1.7.0-openjdk-devel
RUN yum -y install epel-release
RUN yum -y install python-astropy ipython
RUN yum -y install wget
RUN yum -y install git
RUN yum -y install make
RUN yum -y install emacs
RUN yum -y install gcc-c++ gcc.x86_64 gcc-gfortran

# Pip2/3 -- once we upgrade it's renamed pip3.6 --> pip3
RUN pip install --upgrade pip
RUN pip3.6 install --upgrade pip
RUN pip3 install astropy
RUN pip3 install ipython
RUN pip3 install pyyaml
RUN pip3 install fitsio==$FITSIO_VERSION

# Make python3 link
RUN ln -s /usr/bin/python3.6 /usr/bin/python3

# ---------------------
# ts_sal rpms
# Add the lsst-ts repo
RUN wget https://lsst-web.ncsa.illinois.edu/~felipe/packages/lsst-ts.repo
RUN mv -v lsst-ts.repo /etc/yum.repos.d

RUN yum -y install OpenSpliceDDS-6.9.0
RUN yum -y install ATHeaderService-$SAL_VERSION
RUN yum -y install ATCamera-$SAL_VERSION
RUN yum -y install ATArchiver-$SAL_VERSION
RUN yum -y install EFD-$SAL_VERSION
RUN yum -y install Scheduler-$SAL_VERSION
RUN yum -y install ATPtg-$SAL_VERSION
RUN yum -y install ATMCS-$SAL_VERSION
RUN yum -y install ATSpectrograph-$SAL_VERSION
RUN yum -y install ATTCS-$SAL_VERSION
# Needed by ATArchiver
RUN yum -y install CatchupArchiver-$SAL_VERSION
RUN yum -y install MTArchiver-$SAL_VERSION
RUN yum -y install PromptProcessing-$SAL_VERSION

# Get the setup conf
RUN wget https://lsst-web.ncsa.illinois.edu/~felipe/packages/setup_SAL.env -O /opt/lsst/setup_SAL.env
# ---------------------

# Add $HSUSER as user
RUN useradd -ms /bin/bash $HSUSER
RUN usermod -aG wheel $HSUSER

# Make /opt writable by $HSUSER
RUN chown felipe:felipe /opt

ENV USER $HSUSER
ENV HOME /home/$HSUSER
ENV SHELL /bin/bash

USER $HSUSER
WORKDIR /home/$HSUSER


