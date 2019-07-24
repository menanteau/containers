
ARG salobj_image_tag

FROM salobj:$salobj_image_tag


# Versions
ARG HEADERSERVICE_VERSION=0.9.8
ARG SALPYTOOLS_VERSION=0.9.7
ARG FITSIO_VERSION=1.0.4
ARG GIT_LSST_DM="https://github.com/lsst-dm"
ARG HSUSER=headerservice

RUN pip3 install fitsio==$FITSIO_VERSION

# --- Install HeaderService and salpytools ----
ARG PRODUCT=HeaderService
ARG VERSION=$HEADERSERVICE_VERSION
ARG PRODUCT_DIR=$INSTALL_PATH/$PRODUCT/$VERSION
# Create the init env file
RUN echo "source $INSTALL_PATH/setup_SAL.env" > $INSTALL_PATH/setup_HeaderService.env
# Git clone and version checkout
RUN cd $REPOS_TMP \
    && git clone $GIT_LSST_DM/$PRODUCT.git -b $VERSION\
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
    && git clone $GIT_LSST_DM/$PRODUCT.git -b $VERSION\
    && cd $PRODUCT \
    && mkdir -p $PRODUCT_DIR \
    && export PYTHONPATH=$PYTHONPATH:$PRODUCT_DIR/python \
    && python3 setup.py install --prefix=$PRODUCT_DIR --install-lib=$PRODUCT_DIR/python

# Add to the init file
RUN echo "source $PRODUCT_DIR/setpath.sh $PRODUCT_DIR" >> $INSTALL_PATH/setup_HeaderService.env
RUN echo "export LSST_DDS_DOMAIN=auxtelpath" >> $INSTALL_PATH/setup_HeaderService.env
# --- End of HeaderService and salpytools ----

# Add $HSUSER as user
RUN useradd -ms /bin/bash $HSUSER
RUN usermod -aG wheel $HSUSER

ENV USER $HSUSER
ENV HOME /home/$HSUSER
ENV SHELL /bin/bash

USER $HSUSER
WORKDIR /home/$HSUSER
