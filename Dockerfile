# syntax=docker/dockerfile:1
FROM debian:12-slim

ENV JAVA_HOME=/opt/java/jdk1.6.0_45
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

COPY jdk-6u45-linux-x64.bin /tmp/jdk-6u45-linux-x64.bin

RUN set -eux; \
    mkdir -p /opt/java; \
    chmod +x /tmp/jdk-6u45-linux-x64.bin; \
    if grep -q "https://git-lfs.github.com/spec/v1" /tmp/jdk-6u45-linux-x64.bin; then \
        echo "ERROR: The Oracle JDK installer is still a Git LFS pointer." >&2; \
        echo "Ensure 'git lfs fetch --all' (or 'git lfs pull') has been run before building." >&2; \
        exit 1; \
    fi; \
    cd /opt/java; \
    printf 'yes\n' | /tmp/jdk-6u45-linux-x64.bin > /dev/null; \
    rm /tmp/jdk-6u45-linux-x64.bin; \
    ln -sf ${JAVA_HOME}/bin/java /usr/local/bin/java; \
    ln -sf ${JAVA_HOME}/bin/javac /usr/local/bin/javac

RUN java -version

CMD ["/bin/bash"]
