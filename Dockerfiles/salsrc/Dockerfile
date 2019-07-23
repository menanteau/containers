
ARG salrpm_image_tag

FROM salrpm:$salrpm_image_tag

# code version
ARG TS_SAL_VERSION=v3.10.0
ARG TS_XML_VERSION=v3.10.0

# Locations
ARG INSTALL_PATH=/opt/lsst

# Build from ts_sal/ts_xml from source using sal_install_fromSource.sh script
COPY ./sal_install_fromSource.sh /tmp
RUN cd /tmp \
    && ./sal_install_fromSource.sh  -v_sal $TS_SAL_VERSION -v_xml $TS_XML_VERSION -p $INSTALL_PATH/sal-home

