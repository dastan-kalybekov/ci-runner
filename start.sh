#!/bin/bash
set -e

if [ -z "${RUNNER_URL}" ] || [ -z "${RUNNER_TOKEN}" ]; then
  echo "❌ RUNNER_URL и RUNNER_TOKEN обязательны!"
  exit 1
fi

if [ ! -f .runner ]; then
  ./config.sh \
    --url "${RUNNER_URL}" \
    --token "${RUNNER_TOKEN}" \
    --name "${RUNNER_NAME:-docker-runner}" \
    --work _work \
    --unattended \
    --replace
fi

exec ./run.sh
