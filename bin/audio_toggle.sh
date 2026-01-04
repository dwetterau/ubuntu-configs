#!/usr/bin/env bash
set -euo pipefail
log() { printf '[audio-toggle] %s\n' "$*" >&2; }

log "starting"

# Verify pactl
pactl info >/dev/null

# Collect sinks, EXCLUDING HDMI
mapfile -t sinks < <(
  pactl list short sinks |
    awk '{print $2}' |
    grep -vi 'hdmi'
)

if [[ ${#sinks[@]} -eq 0 ]]; then
  log "ERROR: no non-HDMI sinks found"
  exit 1
fi

log "non-HDMI sinks: ${sinks[*]}"

current="$(pactl info | awk -F': ' '/Default Sink/{print $2}')"
log "current=$current"

# If current is HDMI or missing, jump to first non-HDMI
current_index=-1
for i in "${!sinks[@]}"; do
  if [[ "${sinks[$i]}" == "$current" ]]; then
    current_index="$i"
    break
  fi
done

if [[ "$current_index" -lt 0 ]]; then
  log "current sink not eligible; switching to ${sinks[0]}"
  next_sink="${sinks[0]}"
else
  next_sink="${sinks[$(( (current_index + 1) % ${#sinks[@]} ))]}"
fi

log "switching to $next_sink"
pactl set-default-sink "$next_sink"

# Move active streams
while read -r input _; do
  pactl move-sink-input "$input" "$next_sink"
done < <(pactl list short sink-inputs | awk '{print $1, $2}')

log "done"
