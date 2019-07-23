# To build:
# docker build -t lsstts/at_headerservice:sal3.10.0_3.10.0_salobj4.1.0 --rm=true .
# or
# docker build -t lsstts/at_headerservice --rm=true .

# Clean up:
# docker rm $(docker ps -a -q)

FROM centos:7

LABEL name="CentOS Base Image" \
    vendor="CentOS" \
    license="GPLv2" \
    build-date="20161214"

# Versions
ARG FITSIO_VERSION=1.0.4
ARG SAL_VERSION=3.10.0_001-3.10.0.el7
ARG TS_SAL_VERSION=v3.10.0
ARG TS_XML_VERSION=v3.10.0
ARG TS_SALOBJ_VERSION=v4.1.0
ARG TS_IDL_VERSION=v0.2.0
ARG OSPL_VERSION=6.9.0
ARG HEADERSERVICE_VERSION=0.9.8
ARG SALPYTOOLS_VERSION=0.9.7
ARG ts_install_patch_VERSION=sal_3.10.0-3.10.0_salobj_4.1.0

# Locations
ARG GIT_LSST="https://github.com/lsst-dm"
ARG GIT_LSST_TS="https://github.com/lsst-ts"
ARG INSTALL_PATH=/opt/lsst
ARG REPOS_TMP=/tmp/repos
ARG HSUSER=headerservice

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
RUN pip3 install astropy ipython pyyaml fitsio==$FITSIO_VERSION

# For salobj suport
RUN pip3 install setuptools==41.0.1 jsonschema==3.0.1 Cython==0.29.12

# Make python3 link
RUN ln -s /usr/bin/python3.6 /usr/bin/python3



# ---------------------
# ts_sal rpms
# Add the lsst-ts repo
RUN mkdir -p $REPOS_TMP

# Fetch the setup and yum repo info from Felipe's patch github repo
RUN cd $REPOS_TMP \
    && git clone https://github.com/menanteau/lsst_ts_install_patch.git -b $ts_install_patch_VERSION \
    && cp -v lsst_ts_install_patch/lsst-ts.repo /etc/yum.repos.d

RUN yum -y install OpenSpliceDDS-$OSPL_VERSION \
    ATHeaderService-$SAL_VERSION \
    ATCamera-$SAL_VERSION \
    ATArchiver-$SAL_VERSION \
    EFD-$SAL_VERSION \
    Scheduler-$SAL_VERSION \
    ATPtg-$SAL_VERSION \
    ATMCS-$SAL_VERSION \
    ATSpectrograph-$SAL_VERSION \
    ATTCS-$SAL_VERSION \
    # Needed by ATArchiver
    CatchupArchiver-$SAL_VERSION \
    MTArchiver-$SAL_VERSION \
    PromptProcessing-$SAL_VERSION

# Get the setup conf
RUN cp -v $REPOS_TMP/lsst_ts_install_patch/setup_SAL.env /opt/lsst/setup_SAL.env
# ---------------------

# --- Install HeaderService and salpytools ----
ARG PRODUCT=HeaderService
ARG VERSION=$HEADERSERVICE_VERSION
ARG PRODUCT_DIR=$INSTALL_PATH/$PRODUCT/$VERSION
# Create the init env file
RUN echo "source $INSTALL_PATH/setup_SAL.env" > $INSTALL_PATH/setup_HeaderService.env
# Git clone and version checkout
RUN cd $REPOS_TMP \
    && git clone $GIT_LSST/$PRODUCT.git -b $VERSION\
    && cd $PRODUCT \
    && mkdir -p $PRODUCT_DIR \
    && export PYTHONPATH=$PYTHONPATH:$PRODUCT_DIR/python \
    && python3 setup.py install --prefix=$PRODUCT_DIR --install-lib=$PRODUCT_DIR/python
# Add to the init file
RUN echo "source $PRODUCT_DIR/setpath.sh $PRODUCT_DIR" >> $INSTALL_PATH/setup_HeaderService.env

# Install the salpytools
ARG PRODUCT=salpytools
ARG VERSION=$SALPYTOOLS_VERSION
ARG PRODUCT_DIR=$INSTALL_PATH/$PRODUCT/$VERSION
# Git clone and version checkout
RUN cd $REPOS_TMP \
    && git clone $GIT_LSST/$PRODUCT.git -b $VERSION\
    && cd $PRODUCT \
    && mkdir -p $PRODUCT_DIR \
    && export PYTHONPATH=$PYTHONPATH:$PRODUCT_DIR/python \
    && python3 setup.py install --prefix=$PRODUCT_DIR --install-lib=$PRODUCT_DIR/python

# Add to the init file
RUN echo "source $PRODUCT_DIR/setpath.sh $PRODUCT_DIR" >> $INSTALL_PATH/setup_HeaderService.env
RUN echo "export LSST_DDS_DOMAIN=auxtelpath" >> $INSTALL_PATH/setup_HeaderService.env
# --- End of HeaderService and salpytools ----

# Install dds from the tarball on the OpenSplice rpms
RUN mkdir -p $REPOS_TMP/dds \
    && cd $REPOS_TMP/dds/ \
    && tar zxvf /opt/OpenSpliceDDS/V6.9.0/HDE/x86_64.linux/tools/python-support.tgz \
    && cd $REPOS_TMP/dds/python/src \
    && source /opt/lsst/setup_SAL.env \
    && python3 setup.py install

# Install ts_salobj
ARG PRODUCT=ts_salobj
ARG VERSION=$TS_SALOBJ_VERSION
ARG PRODUCT_DIR=$INSTALL_PATH/$PRODUCT
ARG INSTALL_DIR=$INSTALL_PATH
RUN mkdir -p $INSTALL_DIR \
    && cd $INSTALL_DIR \
    && git clone $GIT_LSST_TS/$PRODUCT.git \
    && cd $PRODUCT \
    && git checkout $VERSION \
    && pip3 install -e .

# Install ts_idl
ARG PRODUCT=ts_idl
ARG VERSION=$TS_IDL_VERSION
ARG PRODUCT_DIR=$INSTALL_PATH/$PRODUCT
ARG INSTALL_DIR=$INSTALL_PATH
RUN mkdir -p $INSTALL_DIR \
    && cd $INSTALL_DIR \
    && git clone $GIT_LSST_TS/$PRODUCT.git \
    && cd $PRODUCT \
    && git checkout $VERSION

# Build from ts_sal/ts_xml from source using sal_install_fromSource.sh script
RUN cd $REPOS_TMP/lsst_ts_install_patch \
    && ./sal_install_fromSource.sh  -v_sal $TS_SAL_VERSION -v_xml $TS_XML_VERSION -p $INSTALL_PATH/sal-home

# Add extra idl files from the build
RUN cp -pv $INSTALL_PATH/sal-home/ts_sal/test/idl-templates/validated/sal/sal_revCoded_*.idl $PRODUCT_DIR/idl

## Add extra idl files from Felipe's repo
#RUN cd $REPOS_TMP/lsst_ts_install_patch/salobj/idl \
#    && cp -pv *.idl $PRODUCT_DIR/idl

# Setup for salobj (i.e. PYTHONPATH)
RUN echo "source $INSTALL_PATH/setup_SAL.env" > $INSTALL_PATH/setup_salobj.env
RUN echo "export PYTHONPATH=\${PYTHONPATH}:$INSTALL_PATH/ts_idl/python" >> $INSTALL_PATH/setup_salobj.env

# Add $HSUSER as user
RUN useradd -ms /bin/bash $HSUSER
RUN usermod -aG wheel $HSUSER

# Make /opt writable by $HSUSER
RUN chown $HSUSER:$HSUSER /opt

ENV USER $HSUSER
ENV HOME /home/$HSUSER
ENV SHELL /bin/bash

USER $HSUSER
WORKDIR /home/$HSUSER


