#!/system/bin/sh
set -u
# =========================================================
# AX Performance Engine v7.0
# Logger Module
# =========================================================

timestamp() {
    date '+%Y-%m-%d %H:%M:%S'
}

_log() {

    [ "$LOG_ENABLE" -eq 0 ] && return

    level="$1"
    shift

    line="[$(timestamp)] [$level] $*"

    printf "%s\n" "$line" >> "$LOG_FILE"

    # แสดงบน Terminal เมื่อเปิด DEBUG
    [ "$DEBUG" -eq 1 ] && printf "%s\n" "$line"
}

log_info() {
    _log INFO "$@"
}

log_warn() {
    _log WARN "$@"
}

log_error() {
    _log ERROR "$@"
}

log_debug() {

    [ "$DEBUG" -eq 1 ] || return

    _log DEBUG "$@"
}

# ------------------------------
# Log Rotation
# ------------------------------

rotate_log() {

    [ -f "$LOG_FILE" ] || return

    size=$(wc -c < "$LOG_FILE" 2>/dev/null)

    [ -z "$size" ] && size=0

    max_size=$((1024 * 1024))

    [ "$size" -lt "$max_size" ] && return

    mv "$LOG_FILE" "${LOG_FILE}.old"

    : > "$LOG_FILE"

    log_info "Log rotated"
}

# ------------------------------
# Performance Timer
# ------------------------------

timer_start() {

    TIMER_START=$(date +%s)
}

timer_end() {

    TIMER_END=$(date +%s)

    ELAPSED=$((TIMER_END - TIMER_START))

    log_info "Elapsed : ${ELAPSED}s"
}