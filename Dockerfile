# syntax=docker/dockerfile:1
FROM debian:12-slim

ARG JDK_VERSION=7u80
ARG JDK_ARCHIVE=jdk-${JDK_VERSION}-linux-x64.tar.gz
ARG JAVA_HOME=/opt/java/jdk1.7.0_80

ENV JAVA_HOME=${JAVA_HOME}
ENV PATH="${JAVA_HOME}/bin:${PATH}"

RUN set -eux; \
    apt-get update; \
    apt-get install -y --no-install-recommends \
        ca-certificates \
        fontconfig \
        libxext6 \
        libxrender1 \
        libxtst6 \
        libxi6 \
        tar; \
    rm -rf /var/lib/apt/lists/*

COPY ${JDK_ARCHIVE} /tmp/${JDK_ARCHIVE}

RUN set -eux; \
    mkdir -p /opt/java; \
    tar -xzf /tmp/${JDK_ARCHIVE} -C /opt/java; \
    rm /tmp/${JDK_ARCHIVE}; \
    ln -sf ${JAVA_HOME}/bin/java /usr/local/bin/java; \
    ln -sf ${JAVA_HOME}/bin/javac /usr/local/bin/javac

RUN java -version

CMD ["/bin/bash"]
