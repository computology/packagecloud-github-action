#!/bin/bash

set -euo pipefail

echo "PACKAGECLOUD_USERNAME=${PACKAGECLOUD_USERNAME}"
echo "PACKAGECLOUD_REPONAME=${PACKAGECLOUD_REPONAME}"
echo "PACKAGECLOUD_DISTRO=${PACKAGECLOUD_DISTRO}"
echo "PACKAGE_NAME=${PACKAGE_NAME}"

UPLOAD_PATH="${PACKAGECLOUD_USERNAME}/${PACKAGECLOUD_REPONAME}/${PACKAGECLOUD_DISTRO}"

echo "Pushing package: ${PACKAGE_NAME}"
echo "To repository: ${UPLOAD_PATH}"

# Expand package patterns such as dist/*.tar.gz, as in the action's documented use.
# shellcheck disable=SC2086
exec package_cloud push "$UPLOAD_PATH" ${PACKAGE_NAME}
