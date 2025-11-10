#!/usr/bin/env bash
set -euo pipefail

readme="${1:-README.md}"
apps_root="${2:-apps}"

# Generate Apps JSON array
apps_json="$(
  find "$apps_root" -mindepth 1 -maxdepth 1 -type d | sort | while read -r app_dir; do
    app_name="$(basename "$app_dir")"
    data_file="$app_dir/data.yml"
    [[ -f "$data_file" ]] || continue

    # Get latest version (sorted by version number, descending)
    current_version="$(
      find "$app_dir" -mindepth 1 -maxdepth 1 -type d -exec basename {} \; \
        | sort -rV | head -n 1 || echo "N/A"
    )"

    # Convert YAML to JSON and assemble fields (Python yq compatible)
    yq -o=json "$data_file" | jq -c \
      --arg app "$app_name" \
      --arg ver "$current_version" '
      {
        key: $app,
        name: (.name // ""),
        description: (.description // ""),
        version: $ver,
        website: (.additionalProperties.website // ""),
        github: (.additionalProperties.github // ""),
        document: (.additionalProperties.document // ""),
        tags: (.tags // [])
      }
    '
  done | jq -s .
)"

# Render table
table_content="$(
  echo '| 应用名称 | key | 描述 | 版本 | 标签 |'
  echo '|---|---|---|---|---|'
  echo "$apps_json" | jq -r '
    def trunc(n):
      if . == null then "" 
      else (if (.|length) > n then .[0:n] + "..." else . end) end;

    def name_link(n; w; g):
      if (w // "") != "" then "["+n+"]("+w+")"
      elif (g // "") != "" then "["+n+"]("+g+")"
      else n end;

    .[] |
    "|" + (name_link(.name // "未命名"; .website // ""; .github // ""))
    + "|" + (.key // "未知")
    + "|" + ((.description // "无描述") | trunc(60))
    + "|" + (.version // "N/A")
    + "|" + ((.tags // [] | if length==0 then "其他" else join(", ") end)) + "|"
  '
)"

# Inject into README
tmp="${readme}.tmp"
awk -v tbl="$table_content" '
  /<!--[ ]*apps:table:start[ ]*-->/ { print; print tbl; skip=1; next }
  /<!--[ ]*apps:table:end[ ]*-->/ { skip=0 }
  !skip
' "$readme" > "$tmp" && mv "$tmp" "$readme"
