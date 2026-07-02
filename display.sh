#!/system/bin/sh
set -u
# =========================================================
# AX Performance Engine v7.0
# Display Engine
# =========================================================

detect_refresh_rate() {

    REFRESH=$(safe_get_setting system peak_refresh_rate)

    case "$REFRESH" in
        ""|"null"|0)
            REFRESH=$(safe_get_setting system user_refresh_rate)
        ;;
    esac

    case "$REFRESH" in
        ""|"null"|0)
            REFRESH="$DEFAULT_REFRESH"
        ;;
    esac

    log_info "Detected Refresh Rate : ${REFRESH}Hz"
}

set_refresh_rate() {

    [ "$AUTO_REFRESH" -eq 1 ] || return

    safe_put_setting system min_refresh_rate "$REFRESH"
    safe_put_setting system peak_refresh_rate "$REFRESH"
    safe_put_setting system user_refresh_rate "$REFRESH"
}

set_animation_scale() {

    case "$MODE" in

        balanced)
            scale=1.0
        ;;

        performance)
            scale=0.5
        ;;

        extreme)
            scale=0
        ;;

        *)
            scale="$DEFAULT_ANIMATION_SCALE"
        ;;
    esac

    safe_put_setting global window_animation_scale "$scale"
    safe_put_setting global transition_animation_scale "$scale"
    safe_put_setting global animator_duration_scale "$scale"
}

verify_display() {

    current=$(safe_get_setting system peak_refresh_rate)

    if [ "$current" != "$REFRESH" ]; then
        log_warn "Refresh Rate verification failed"

        safe_put_setting system peak_refresh_rate "$REFRESH"
    fi
}

display_engine() {

    log_info "===== Display Engine ====="

    detect_refresh_rate

    set_refresh_rate

    set_animation_scale

    verify_display

    log_info "Display Engine Complete"
}