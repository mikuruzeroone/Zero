#!/system/bin/sh
set -u
# =========================================================
# AX Performance Engine v7.0
# Common Library
# =========================================================

# Check command exists
has_command() {
    command -v "$1" >/dev/null 2>&1
}

# Execute safely
run_safe() {

    if [ "$DRY_RUN" -eq 1 ]; then
        log_info "[DRY] $*"
        return 0
    fi

    "$@" >/dev/null 2>&1
    rc=$?

    if [ "$rc" -eq 0 ]; then
        log_debug "$*"
    else
        log_warn "$* (exit=$rc)"
    fi

    return "$rc"
}

# Read Android setting
safe_get_setting() {
    settings get "$1" "$2" 2>/dev/null
}

# Write Android setting (only if changed)
safe_put_setting() {

    table="$1"
    key="$2"
    value="$3"

    current="$(safe_get_setting "$table" "$key")"

    [ "$current" = "$value" ] && return 0

    run_safe settings put "$table" "$key" "$value"
}

# Verify value
verify_setting() {

    current="$(safe_get_setting "$1" "$2")"

    [ "$current" = "$3" ]
}

# Check whether a settings key exists
supports_setting() {

    settings get "$1" "$2" >/dev/null 2>&1
}

# Lock
create_lock() {

    if [ -f "$LOCK_FILE" ]; then
        log_error "Another AXPE instance is already running."
        exit 1
    fi

    touch "$LOCK_FILE" || {
        log_error "Cannot create lock."
        exit 1
    }
}

cleanup() {
    rm -f "$LOCK_FILE"
}

die() {
    log_error "$1"
    cleanup
    exit 1
}

trap cleanup EXIT INT TERM