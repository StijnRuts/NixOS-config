#!/usr/bin/env bash
set -euo pipefail

case "${1:-}" in
  ram)
    icon=""
    warning=80
    danger=85
    critical=90
    mem=$(free | grep 'Mem')
    ;;
  swap)
    icon="󰯍"
    warning=60
    danger=75
    critical=85
    mem=$(free | grep 'Swap')
    ;;
  *) echo "usage: $0 {ram|swap}" >&2; exit 2;;
esac

total=$(echo $mem | awk '{printf($2)}')
used=$(echo $mem | awk '{printf($3)}')
pct=$((100 * used / total))

txt="${pct}% ${icon}"

tt=$(echo $mem | awk '{printf "%.1fGiB / %.1fGiB", $3/1024/1024, $2/1024/1024}')

if [ "$pct" -ge "$critical" ]; then
  cls="critical"
elif [ "$pct" -ge "$danger" ]; then
  cls="danger"
elif [ "$pct" -ge "$warning" ]; then
  cls="warning"
else
  cls="good"
  txt=""
fi

printf '{"percentage": %d, "text": "%s", "class": "%s", "tooltip": "%s"}\n' "$pct" "$txt" "$cls" "$tt"

