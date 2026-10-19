#!/usr/bin/env bash
# Make .venv on the ROS 2 Python, add the Aria SDK, and build the workspace.
set -euo pipefail

workspace="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
venv="${ARIA_VENV:-${workspace}/.venv}"
python="${venv}/bin/python"

set +u
source "/opt/ros/${ROS_DISTRO:-humble}/setup.bash"
set -u
uv venv --allow-existing --python /usr/bin/python3 --system-site-packages "${venv}"
touch "${venv}/COLCON_IGNORE"
uv pip install --python "${python}" -r "${workspace}/requirements.txt"
uv pip install --python "${python}" --no-deps projectaria-client-sdk==2.4.0 projectaria-tools==2.1.4

# The Aria wheel names its extensions for Meta's Python build; link them for stock CPython.
aria_dir="$("${python}" -c 'import sysconfig; print(sysconfig.get_path("purelib"))')/aria"
suffix="$("${python}" -c 'import sysconfig; print(sysconfig.get_config_var("EXT_SUFFIX"))')"
for module in sdk sdk_gen2; do
  if [[ ! -e "${aria_dir}/${module}${suffix}" ]]; then
    ln -s "$(cd "${aria_dir}" && ls ${module}.cpython-310-fb-*.so | head -n 1)" "${aria_dir}/${module}${suffix}"
  fi
done

source "${venv}/bin/activate"
cd "${workspace}"
python -m colcon build --symlink-install
echo "Ready. Run: source ${workspace}/activate.sh"
