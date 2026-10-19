#!/usr/bin/env bash
# Source this file: ROS 2, the venv with the Aria SDK, its native libraries, and this workspace.

_workspace="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
_venv="${ARIA_VENV:-${_workspace}/.venv}"

source "/opt/ros/${ROS_DISTRO:-humble}/setup.bash"
source "${_venv}/bin/activate"
_aria_dir="$(python -c 'import sysconfig; print(sysconfig.get_path("purelib"))')/aria"
export LD_LIBRARY_PATH="${_aria_dir}${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}"
source "${_workspace}/install/setup.bash"
# A DDS domain of its own keeps other ROS 2 projects on this host and LAN apart.
export ROS_DOMAIN_ID="${ARIA_ROS_DOMAIN_ID:-42}"
unset _workspace _venv _aria_dir
