#!/system/bin/sh
set -u
# =========================================================
# AX Performance Engine v7.0
# Game Engine
# =========================================================

GAMES_CONF="${AXPE_DIR}/games.conf"

CURRENT_GAME=""
CURRENT_PROFILE="balanced"

detect_running_game() {

    CURRENT_GAME=""

    while IFS='=' read -r pkg profile
    do
        case "$pkg" in
            ""|\#*) continue ;;
        esac

        if pidof "$pkg" >/dev/null 2>&1
        then
            CURRENT_GAME="$pkg"
            CURRENT_PROFILE="$profile"
            break
        fi

    done < "$GAMES_CONF"
}

apply_game_profile() {

    # ถ้าผู้ใช้กำหนด MODE จาก CLI แล้ว
    # ไม่ต้องให้ games.conf เขียนทับ
    [ -n "$MODE" ] && {
        CURRENT_PROFILE="$MODE"
        log_info "Mode (CLI) : $MODE"
        log_info "Profile : $CURRENT_PROFILE"
        return
    }

    case "$(echo "$CURRENT_PROFILE" | tr '[:upper:]' '[:lower:]')" in
        balanced)
            MODE="balanced"
        ;;

        performance|gaming)
            MODE="performance"
        ;;

        extreme)
            MODE="extreme"
        ;;

        thermal)
            MODE="thermal"
        ;;

        *)
            MODE="balanced"
            CURRENT_PROFILE="balanced"
        ;;
    esac

    CURRENT_PROFILE="$MODE"

    log_info "Mode : $MODE"
    log_info "Profile : $CURRENT_PROFILE"
}
set_game_mode() {
    has_command cmd || return

    cmd game --help >/dev/null 2>&1 || return

    cmd game mode performance "$CURRENT_GAME" \
        >/dev/null 2>&1
}

game_engine() {

    log_info "===== Game Engine ====="

    detect_running_game

    [ -z "$CURRENT_GAME" ] && {

        log_info "No supported game running"

        return

    }

    log_info "Game : $CURRENT_GAME"

    apply_game_profile

    set_game_mode

    log_info "Game Engine Complete"
}