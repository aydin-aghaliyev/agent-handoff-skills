#!/usr/bin/env bash
set -euo pipefail

usage() {
    echo "Usage: handls.sh [open|closed|all] [today]" >&2
    exit 2
}

status_filter="all"
today_only=false
for argument in "$@"; do
    case "$argument" in
        open|closed|all)
            if [[ "$status_filter" != "all" ]]; then
                usage
            fi
            status_filter="$argument"
            ;;
        today)
            if "$today_only"; then
                usage
            fi
            today_only=true
            ;;
        *) usage ;;
    esac
done

if [[ ! -d docs/tasks ]]; then
    echo "docs/tasks/ does not exist" >&2
    exit 1
fi

today="$(date +%F)"
rows="$(mktemp)"
trap 'rm -f "$rows"' EXIT

while IFS= read -r -d '' file; do
    declared_status="$(sed -nE 's/^[[:space:]]*-[[:space:]]*STATUS:[[:space:]]*(OPEN|CLOSED)[[:space:]]*$/\1/p' "$file" | tail -n 1)"
    status="${declared_status:-CLOSED}"
    created="$(git log --diff-filter=A --follow --format=%aI -- "$file" | tail -n 1)"
    created="${created:-untracked}"

    if [[ "$status_filter" != "all" && "${status,,}" != "$status_filter" ]]; then
        continue
    fi
    if "$today_only" && [[ "${created:0:10}" != "$today" ]]; then
        continue
    fi

    if [[ "$status" == "OPEN" ]]; then
        sort_status=0
    else
        sort_status=1
    fi
    printf '%s\t%s\t%s\t%s\n' "$sort_status" "$created" "$status" "$file" >> "$rows"
done < <(find docs/tasks -maxdepth 1 -type f -name '*.md' -print0)

echo '| Status | Created | Handoff |'
echo '| --- | --- | --- |'
sort -t $'\t' -k1,1n -k2,2r "$rows" | while IFS=$'\t' read -r _ created status file; do
    printf '| %s | %s | [%s](%s) |\n' "$status" "$created" "${file##*/}" "$file"
done
