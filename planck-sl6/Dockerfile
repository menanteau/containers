# to build
# docker build -t sl6_planck --rm=true . 

FROM cern/slc6-base

RUN yum -y install deltarpm
RUN yum -y install xorg-x11-fonts-misc 
RUN yum -y install emacs 
RUN yum -y install ipython 
RUN yum -y install wget
RUN yum -y install patch
RUN yum -y install gcc-c++
RUN yum -y install gcc.x86_64
RUN yum -y install gcc-gfortran
RUN yum -y install compat-gcc-34-g77
RUN yum -y install glibc-devel
RUN yum -y install glibc-devel.i686 libgcc.i686 libstdc++-devel.i686 ncurses-devel.i686
RUN yum -y install scipy

RUN useradd -ms /bin/bash felipe 
RUN usermod -aG wheel felipe

ENV USER felipe
ENV HOME /home/felipe
ENV SHELL /bin/bash

USER felipe
WORKDIR /home/felipe

