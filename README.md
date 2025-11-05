# Debian 12 + Oracle JDK 7 Docker Image

This repository builds a Debian 12 based Docker image containing the 64-bit Oracle JDK 7u80. The image is built and published automatically to GitHub Container Registry via GitHub Actions.

## Image details

- **Base image:** `debian:12-slim`
- **JDK version:** Oracle JDK 7u80 (64-bit)
- **Registry:** `ghcr.io/<OWNER>/<REPO>/debian12-oracle-jdk7`
- **Platforms:** `linux/amd64`

> **Note:** Downloading Oracle JDK 7 requires acceptance of Oracle's license terms. Because the Oracle download servers often require interactive authentication, the build expects a pre-downloaded archive named `jdk-7u80-linux-x64.tar.gz` to exist at the repository root. Ensure that you are permitted to download and use the Oracle JDK in your jurisdiction.

## Building locally

To build the image locally, first place the Oracle JDK 7u80 tarball (`jdk-7u80-linux-x64.tar.gz`) in the repository root, then run:

```bash
docker build --build-arg JDK_VERSION=7u80 \
             -t debian12-oracle-jdk7 .
```

Run the image and verify the JDK installation:

```bash
docker run --rm debian12-oracle-jdk7 java -version
```

## Continuous integration

The GitHub Actions workflow in [`.github/workflows/docker.yml`](.github/workflows/docker.yml) builds and publishes the image on every push to branches other than `main`. Each branch represents a different JDK variant, and the resulting container image is tagged with the branch name in addition to a digest-specific tag derived from the Git commit SHA.
