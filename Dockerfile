# PhenoMeNal H2020
# mzQuality
FROM python:3.6.5-slim-jessie

MAINTAINER PhenoMeNal-H2020 Project ( phenomenal-h2020-users@googlegroups.com )

ENV TOOL_NAME="mzQuality" \
    TOOL_VERSION=0.9 \
    TOOL_ENTRYPOINT="qcli.py" \
    TOOL_DOWNLOAD_URL="https://github.com/leidenuniv-lacdr-abs/mzQuality/archive/v0.9.tar.gz" \
    TOOL_TAR_GZ="mzQuality.tar.gz" \
    MINICONDA_SH="miniconda.sh" \
    MINICONDA_DOWNLOAD_URL="https://repo.continuum.io/miniconda/Miniconda3-4.4.10-Linux-x86_64.sh" \
    CONTAINER_VERSION=0.0.1

LABEL software="${TOOL_NAME}" \
      software.version="${TOOL_VERSION}" \
      version="${CONTAINER_VERSION}" \
      base.image="continuumio/miniconda3:4.4.10" \
      description="A tool to assess the quality of targeted mass spectrometry measurements." \
      website="http://www."${TOOL_NAME}".nl" \
      documentation="http://www."${TOOL_NAME}".nl" \
      license="https://github.com/phnmnl/container-"${TOOL_NAME}"/blob/master/LICENSE" \
      tags="Metabolomics"

# Add testing to container
COPY runTest1.sh /usr/local/bin/runTest1.sh
RUN chmod +x /usr/local/bin/runTest1.sh

# install and prepare mzquality
RUN apt-get update && apt-get install -y curl bzip2

# prep folders
RUN mkdir /files && mkdir /files/${TOOL_NAME}

# get mzQuality in
RUN cd /files/${TOOL_NAME} && \
    curl -L --insecure -o $TOOL_TAR_GZ $TOOL_DOWNLOAD_URL && \
    tar -xvzf $TOOL_TAR_GZ --strip-components 1 && \
    rm -rf $TOOL_TAR_GZ

# install dependencies with conda (environments)
RUN cd /tmp && curl --insecure -o $MINICONDA_SH $MINICONDA_DOWNLOAD_URL && \
    chmod +x /tmp/$MINICONDA_SH && \
    /tmp/$MINICONDA_SH -b -p /files/miniconda/ && \
    /files/miniconda/bin/conda update -n base conda && \
    /files/miniconda/bin/conda env create -f /files/${TOOL_NAME}/environment.yml && \
    . /files/miniconda/bin/activate ${TOOL_NAME} && \
    /files/miniconda/bin/conda clean -y --all

# clean up
RUN apt-get autoremove -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# set working directory
WORKDIR /files/${TOOL_NAME}/

CMD python "./${TOOL_ENTRYPOINT}"