# Docker Legacy JDK Images

This repository hosts documentation and shared test assets for a set of Debian 12–based Docker images that package legacy versions of the Oracle JDK. The `main` branch stays lightweight but now includes a small verification workflow so we can continually confirm that the published images still boot and report the correct JDK release.

## Available images

The following images are pre-built and published to GitHub Container Registry:

| Image | Description |
| ----- | ----------- |
| `ghcr.io/dt-activenetwork/docker-legacy-jdk/debian12-oracle-jdk6:latest` | Debian 12 slim base with Oracle JDK 6u45 (64-bit). |
| `ghcr.io/dt-activenetwork/docker-legacy-jdk/debian12-oracle-jdk7:latest` | Debian 12 slim base with Oracle JDK 7u80 (64-bit). |

Each runtime-specific branch (`debian12-oracle-jdk6`, `debian12-oracle-jdk7`, …) contains the Dockerfile, build scripts, and workflow definitions used to produce its corresponding image. Updates to an image should be committed to the appropriate branch, built, and pushed from there.

## Pulling and verifying an image

To fetch the image and verify that the expected JDK version is installed, run:

```bash
# Replace the tag with the image you want to validate
IMAGE="ghcr.io/dt-activenetwork/docker-legacy-jdk/debian12-oracle-jdk7:latest"

docker pull "$IMAGE"
docker run --rm "$IMAGE" sh -c 'java --version 2>&1 || java -version 2>&1'
```

The `java --version`/`java -version` output should match the JDK version listed in the table above. Additional regression or integration tests that apply across images should live on this branch alongside their documentation.

### Continuous verification

GitHub Actions runs a lightweight smoke test (`.github/workflows/verify-images.yml`) whenever changes land on `main`. The workflow logs in to GHCR, pulls each published image, and executes `java --version` (falling back to `java -version` for older distributions) to ensure the reported JDK build still matches the values in the table above.

## Contributing updates

1. Switch to the branch that corresponds to the image you want to change.
2. Update the Dockerfile, scripts, or workflows as needed.
3. Build and test the image locally.
4. Push the branch and publish the updated container image.
5. Reflect any cross-image documentation or test changes back on `main`.
