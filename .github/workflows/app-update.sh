#!/usr/bin/env bash
app_name=${1}
repo=$(yq -r '.additionalProperties.github' "apps/${app_name}/data.yml" | cut -d "/" -f 4,5)

# Query GitHub for latest version
auth_header=()
if [ -n "${GITHUB_TOKEN:-}" ]; then
  auth_header=(-H "Authorization: token ${GITHUB_TOKEN:-}")
fi

release=$(curl -fsSL "${auth_header[@]}" "https://api.github.com/repos/${repo}/releases/latest" | jq -r '.tag_name' 2>/dev/null)
tag=$(curl -fsSL "${auth_header[@]}" "https://api.github.com/repos/${repo}/tags?per_page=1" | jq -r '.[0].name' 2>/dev/null)
release="${release#v}"
tag="${tag#v}"
latest_version=$(printf "%s\n%s\n" "$release" "$tag" | grep -v -e '^$' -e '^null$' | sort -V -u | tail -n1)
if [[ -z "${latest_version}" || "${latest_version}" == "null" ]]; then
  echo "Error: could not determine latest version for ${repo}" >&2
  exit 1
fi

current_version=$(find apps/${app_name} -mindepth 1 -maxdepth 1 -type d | sort -rV | head -n 1 | cut -d "/" -f 3)
# Output for GitHub Actions
echo "current=$current_version" >> "$GITHUB_OUTPUT"
echo "latest=$latest_version"  >> "$GITHUB_OUTPUT"

# Rename directory if version changed
if [ "${current_version}" != "${latest_version}" ]; then
  if [[ ! -e "apps/${app_name}/${latest_version}" ]]; then
    mv "apps/${app_name}/${current_version}" "apps/${app_name}/${latest_version}"
    echo "changed=true" >> "$GITHUB_OUTPUT"
  else
    echo "changed=false" >> "$GITHUB_OUTPUT"
  fi
else
  echo "changed=false" >> "$GITHUB_OUTPUT"
fi