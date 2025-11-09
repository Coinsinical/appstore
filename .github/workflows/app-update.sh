#!/usr/bin/env bash
app_name=${1}
repo=$(yq -r '.additionalProperties.github' "apps/${app_name}/data.yml" | cut -d "/" -f 4,5)

# Query GitHub for latest version
auth_header=()
if [ -n "${GITHUB_TOKEN:-}" ]; then
  auth_header=(-H "Authorization: token ${GITHUB_TOKEN:-}")
fi

# Try releases/latest first
latest_version=$(curl -fsSL "${auth_header[@]}" "https://api.github.com/repos/${repo}/releases/latest" | jq -r '.tag_name' 2>/dev/null)
if [ -z "$latest_version" ] || [ "$latest_version" = "null" ]; then
  # Fallback to tags list (first tag)
  latest_version=$(curl -fsSL "${auth_header[@]}" "https://api.github.com/repos/${repo}/tags?per_page=1" | jq -r '.[0].name' 2>/dev/null)
fi
latest_version="${latest_version#v}"
if [[ -z "${latest_version}" || "${latest_version}" == "null" ]]; then
  echo "Error: could not determine latest version for ${repo}" >&2
  exit 1
fi

current_version=$(find apps/${app_name}/* -mindepth 1 -maxdepth 1 -type d | sort -rV | head -n 1 | cut -d "/" -f 3)
# Output for GitHub Actions
echo "current=${current_version}"
echo "latest=${latest_version}"
echo "repo=${repo}"

# Rename directory if version changed
if [ "${current_version}" != "${latest_version}" ]; then
  if [[ ! -e "apps/${app_name}/${latest_version}" ]]; then
    mv "apps/${app_name}/${current_version}" "apps/${app_name}/${latest_version}"
    echo "changed=true"
  else
    echo "changed=false"
  fi
else
  echo "changed=false"
fi