#!/bin/bash
# Copyright VMware, Inc.
# SPDX-License-Identifier: APACHE-2.0

# shellcheck disable=SC1091

set -o errexit
set -o nounset
set -o pipefail
#set -o xtrace

# Load libraries
. /opt/aizen/scripts/libspark.sh
. /opt/aizen/scripts/libos.sh

# Load Spark environment settings
. /opt/aizen/scripts/spark-env.sh

if [ "$SPARK_MODE" == "master" ]; then
    # Master constants
    EXEC=$(command -v start-master.sh)
    ARGS=()
    info "** Starting Spark in master mode **"
else
    # Worker constants
    EXEC=$(command -v start-worker.sh)
    ARGS=("$SPARK_MASTER_URL")
    info "** Starting Spark in worker mode **"
fi
if am_i_root; then
    exec_as_user "$SPARK_DAEMON_USER" "$EXEC" "${ARGS[@]-}"
else
    exec "$EXEC" "${ARGS[@]-}"
fi
