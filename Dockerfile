# PhenoMeNal H2020
# mzQuality
FROM python:3.6.5-slim-jessie

MAINTAINER PhenoMeNal-H2020 Project ( phenomenal-h2020-users@googlegroups.com )

ENV TOOL_NAME="mzQuality" \
    TOOL_VERSION=1.0 \
    TOOL_DOWNLOAD_URL="https://github.com/leidenuniv-lacdr-abs/mzQuality/archive/v0.9.4.tar.gz" \
    TOOL_TAR_GZ="mzQuality.tar.gz" \
    CONTAINER_VERSION=1.0

LABEL software="mzQuality"
LABEL software.version=1.0
LABEL version=1.0
LABEL base.image="python:3.6.5-slim-jessie"
LABEL description="A tool to assess the quality of targeted mass spectrometry measurements."
LABEL website="http://www."${TOOL_NAME}".nl"
LABEL documentation="http://www."${TOOL_NAME}".nl"
LABEL license="https://github.com/phnmnl/container-"${TOOL_NAME}"/blob/master/LICENSE"
LABEL tags="Metabolomics"

# Add testing to container
COPY runTest1.sh /usr/local/bin/runTest1.sh

# install and prepare mzquality
RUN apt-get update && apt-get install -y --no-install-recommends curl bzip2 && \
    mkdir /files && mkdir /files/${TOOL_NAME} && \
    cd /files/${TOOL_NAME} && \
    curl -L --insecure -o $TOOL_TAR_GZ $TOOL_DOWNLOAD_URL && \
    tar -xvzf $TOOL_TAR_GZ --strip-components 1 && \
    rm -rf $TOOL_TAR_GZ && \
    pip install -r /files/${TOOL_NAME}/requirements.txt && \
    apt-get remove -y python-pip curl bzip2 && \
    apt-get autoremove -y && \    
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
    chmod +x /usr/local/bin/runTest1.sh

COPY data/combined.tsv /tmp/combined.tsv
COPY data/blank_effect.tsv /tmp/blank_effect.tsv
COPY data/rt_shifts.tsv /tmp/rt_shifts.tsv

ENTRYPOINT ["/files/mzQuality/qcli.py"]
