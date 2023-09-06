# Copyright VMware, Inc.
# SPDX-License-Identifier: APACHE-2.0

FROM eclipse-temurin:8u382-b05-jdk
RUN useradd -u 1001 aizen

RUN apt-get update  \
    && apt-get install -y python3.11  \
    && update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.11 1  \
    && apt-get install -y python3-pip  \
    && apt-get install -y fai-client \
    && apt upgrade \
    && apt update

ARG JAVA_EXTRA_SECURITY_DIR="/aizen/java/extra-security"
ARG TARGETARCH

ENV HOME="/" \
    OS_ARCH="${TARGETARCH:-amd64}" \
    OS_NAME="linux" \
    PATH="/usr/bin:/opt/java/openjdk/bin:/opt/aizen/spark/bin:/opt/aizen/spark/sbin:$PATH"

COPY prebuildfs /
SHELL ["/bin/bash", "-o", "pipefail", "-c"]
# Install required system packages and dependencies
RUN install_packages ca-certificates curl libbz2-1.0 libcom-err2 libcrypt1 libffi7 libgcc-s1 libgssapi-krb5-2 libk5crypto3 libkeyutils1 libkrb5-3 libkrb5support0 liblzma5 libncursesw6 libnsl2 libreadline8 libsqlite3-0 openssl libssl-dev libstdc++6 libtinfo6 libtirpc3 procps zlib1g
RUN apt-get autoremove --purge -y curl && \
    apt-get update && apt-get upgrade -y && \
    apt-get clean && rm -rf /var/lib/apt/lists /var/cache/apt/archives
RUN chmod g+rwX /opt/aizen
RUN mkdir /.local && chmod g+rwX /.local

COPY rootfs /
RUN /opt/aizen/scripts/spark/postunpack.sh
RUN /opt/aizen/scripts/java/postunpack.sh
ENV APP_VERSION="3.2.3" \
    AIZEN_APP_NAME="spark" \
    JAVA_HOME="/opt/java/openjdk" \
    LD_LIBRARY_PATH="/opt/aizen/python/lib:/opt/aizen/spark/venv/lib/python3.8/site-packages/numpy.libs:$LD_LIBRARY_PATH" \
    LIBNSS_WRAPPER_PATH="/opt/aizen/common/lib/libnss_wrapper.so" \
    NSS_WRAPPER_GROUP="/opt/aizen/spark/tmp/nss_group" \
    NSS_WRAPPER_PASSWD="/opt/aizen/spark/tmp/nss_passwd" \
    PYTHONPATH="/opt/aizen/spark/python/:$PYTHONPATH" \
    SPARK_HOME="/opt/aizen/spark" \
    SPARK_USER="spark"

WORKDIR /opt/aizen/spark
USER 1001
ENTRYPOINT [ "/opt/aizen/scripts/spark/entrypoint.sh" ]
CMD [ "/opt/aizen/scripts/spark/run.sh" ]
