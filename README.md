# Debian 12 + Oracle JDK 6 Docker Image

This branch provides a Debian 12 based Docker image containing the 64-bit Oracle JDK 6u45. Oracle no longer publishes direct download links for this legacy release, so the build process expects the pre-downloaded installer to be available in the repository root (see below).

## Image details

- **Base image:** `debian:12-slim`
- **JDK version:** Oracle JDK 6u45 (64-bit)
- **Registry:** `ghcr.io/<OWNER>/<REPO>/debian12-oracle-jdk6`
- **Platforms:** `linux/amd64`

> **Note:** Oracle JDK 6 binaries require acceptance of Oracle's license terms. Obtain `jdk-6u45-linux-x64.bin` directly from Oracle, accept the license, and place the file alongside the Dockerfile before running any builds. The file is tracked via Git Large File Storage (LFS); make sure you have run `git lfs install` (once per machine) and `git lfs pull` so the real binary is present before building.

## Building locally

To build the image locally (after copying `jdk-6u45-linux-x64.bin` into the repository root or fetching it with Git LFS):

```bash
docker build -t debian12-oracle-jdk6 .
```

Run the image and verify the JDK installation:

```bash
docker run --rm debian12-oracle-jdk6 java -version
```

## Continuous integration

The GitHub Actions workflow in [`.github/workflows/docker.yml`](.github/workflows/docker.yml) builds and publishes the image when commits land on the `oracle-jdk6` branch. Each run publishes two tags to GitHub Container Registry: `latest` and the branch name (`oracle-jdk6`), making the branch identity part of the image tag strategy for multi-version maintenance.
