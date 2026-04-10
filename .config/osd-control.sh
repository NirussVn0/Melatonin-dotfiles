#!/usr/bin/env bash
#
# OSD Control Script for Melatonin Dotfiles
# Author: Niruss

set -euo pipefail

# --- Configuration ---
readonly NOTIFY_TIMEOUT=1500
readonly NOTIFY_CATEGORY="OSD"
readonly STEP_VOLUME=5
readonly STEP_BRIGHTNESS="5%"

# --- Dependencies Check ---
readonly DEPS=("notify-send" "pamixer" "brightnessctl")
for dep in "${DEPS[@]}"; do
    if ! command -v "$dep" &> /dev/null; then
        echo "Error: Command '$dep' not found. Please install it before proceeding." >&2
        exit 1
    fi
done

# --- Functions ---

# Send OSD Notification
# Arguments:
#   $1: Category/Type (e.g., Volume, Brightness)
#   $2: Value (0-100)
#   $3: Icon name
#   $4: Body text (e.g., 50%, Muted)
send_notification() {
    local type="$1"
    local value="$2"
    local icon="$3"
    local text_body="$4"

    notify-send -u critical \
        -c "$NOTIFY_CATEGORY" \
        -t "$NOTIFY_TIMEOUT" \
        -h "int:value:$value" \
        -h "string:x-canonical-private-synchronous:osd-$type" \
        -h "boolean:transient:true" \
        -i "$icon" \
        "$type" "$text_body"
}

handle_volume() {
    local action="$1"
    
    case "$action" in
        up)   pamixer -i "$STEP_VOLUME" >/dev/null ;;
        down) pamixer -d "$STEP_VOLUME" >/dev/null ;;
        mute) pamixer -t >/dev/null ;;
        *) 
            echo "Usage: $0 volume [up|down|mute]" >&2
            exit 1 
            ;;
    esac

    local volume
    local is_muted
    local icon
    local text_body

    volume=$(pamixer --get-volume)
    is_muted=$(pamixer --get-mute)

    if [[ "$is_muted" == "true" ]]; then
        icon="audio-volume-muted"
        text_body="Muted"
        volume=0
    else
        text_body="${volume}%"
        if (( volume <= 33 )); then
            icon="audio-volume-low"
        elif (( volume <= 66 )); then
            icon="audio-volume-medium"
        else
            icon="audio-volume-high"
        fi
    fi

    send_notification "Volume" "$volume" "$icon" "$text_body"
}

handle_brightness() {
    local action="$1"

    case "$action" in
        up)   brightnessctl set +"$STEP_BRIGHTNESS" -q ;;
        down) brightnessctl set "$STEP_BRIGHTNESS"- -q ;;
        *) 
            echo "Usage: $0 brightness [up|down]" >&2
            exit 1 
            ;;
    esac

    local brightness
    local max_brightness
    local percent
    local icon

    brightness=$(brightnessctl get)
    max_brightness=$(brightnessctl max)
    percent=$(( 100 * brightness / max_brightness ))

    if (( percent <= 33 )); then
        icon="display-brightness-low"
    elif (( percent <= 66 )); then
        icon="display-brightness-medium"
    else
        icon="display-brightness-high"
    fi

    send_notification "Brightness" "$percent" "$icon" "${percent}%"
}

# --- Main Logic ---
main() {
    if [[ $# -lt 2 ]]; then
        echo "Usage: $0 [volume|brightness] [up|down|mute]" >&2
        exit 1
    fi

    local module="$1"
    local action="$2"

    case "$module" in
        volume)
            handle_volume "$action"
            ;;
        brightness)
            handle_brightness "$action"
            ;;
        *)
            echo "Error: Invalid module '$module'. Supported: volume, brightness." >&2
            exit 1
            ;;
    esac
}

main "$@"
