#!/bin/sh
set -eu

herdr="${HERDR_BIN_PATH:-herdr}"

"$herdr" workspace list \
  | jq -r '.result.workspaces[] | "\(.workspace_id) \(.number)"' \
  | while read -r id num; do
      "$herdr" workspace report-metadata "$id" --source workspace-number --token "num=$num" >/dev/null
    done
