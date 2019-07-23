ARG salbase_image_tag

FROM salbase:${salbase_image_tag}

# ---------------------
# Install the ts_sal rpms
# ---------------------

# SAL/OSPL versions
ARG SAL_VERSION=3.10.0_001-3.10.0.el7
ARG OSPL_VERSION=6.9.0

# Copy the setup and yum repo info
COPY lsst-ts.repo /etc/yum.repos.d
COPY setup_SAL.env /opt/lsst/setup_SAL.env

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

# ---------------------

