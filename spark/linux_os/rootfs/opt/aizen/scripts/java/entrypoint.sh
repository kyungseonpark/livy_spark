#!/bin/bash
# Copyright VMware, Inc.
# SPDX-License-Identifier: APACHE-2.0

# shellcheck disable=SC1091

set -o errexit
set -o nounset
set -o pipefail
# set -o xtrace # Uncomment this line for debugging purposes

# Load libraries
. /opt/aizen/scripts/libaizen.sh
. /opt/aizen/scripts/liblog.sh

print_welcome_page

echo ""
exec "$@"
