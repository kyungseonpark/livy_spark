#!/bin/bash
# Copyright VMware, Inc.
# SPDX-License-Identifier: APACHE-2.0

# shellcheck disable=SC1091

set -o errexit
set -o nounset
set -o pipefail
# set -o xtrace # Uncomment this line for debugging purposes

# Load libraries
. /opt/aizen/scripts/libfile.sh
. /opt/aizen/scripts/liblog.sh

#
# Java post-unpack operations
#

# Override default files in the Java security directory. This is used for
# custom base images (with custom CA certificates or block lists is used)

if [[ -n "${JAVA_EXTRA_SECURITY_DIR:-}" ]] && ! is_dir_empty "$JAVA_EXTRA_SECURITY_DIR"; then
    info "Adding custom CAs to the Java security folder"
    cp -Lr "${JAVA_EXTRA_SECURITY_DIR}/." /opt/aizen/java/lib/security
fi
