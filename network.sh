#!/system/bin/sh
set -u
# =========================================================
# AX Performance Engine v7.0
# Network Engine
# =========================================================

network_engine() {

    log_info "===== Network Engine ====="

    detect_network

    verify_network

    log_info "Network Engine Complete"
}

detect_network() {

    NETWORK_TYPE="unknown"

    # Android รุ่นใหม่
    if has_command cmd; then
        WIFI_STATE="$(cmd wifi status 2>/dev/null)"
        if echo "$WIFI_STATE" | grep -qi "enabled"; then
            NETWORK_TYPE="wifi"
        fi
    fi

    # Android รุ่นเก่า
    if [ "$NETWORK_TYPE" = "unknown" ]; then
        WIFI_STATE="$(dumpsys wifi 2>/dev/null)"
        if echo "$WIFI_STATE" | grep -qi "Wi-Fi is enabled"; then
            NETWORK_TYPE="wifi"
        else
            NETWORK_TYPE="mobile"
        fi
    fi

    log_info "Network : $NETWORK_TYPE"
}

verify_network() {

    if ping -c 1 -W 2 8.8.8.8 >/dev/null 2>&1; then
        log_info "Internet : OK"
    else
        log_warn "Internet : Unreachable"
    fi
}

network_summary() {

    log_info "===== Network Summary ====="
    log_info "Type : $NETWORK_TYPE"
}