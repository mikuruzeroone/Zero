#!/system/bin/sh
set -u
# =========================================================
# AX Performance Engine v7.0
# Main Bootstrap
# =========================================================

SCRIPT_DIR="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"

load_module() {
    module="$1"

    if [ -f "$SCRIPT_DIR/$module" ]; then
        . "$SCRIPT_DIR/$module"
        echo "[OK] Loaded: $module"
    else
        echo "[WARN] Skip missing module: $module"
    fi
}

# -----------------------
# Load Modules
# -----------------------

# Core
load_module config.sh
load_module logger.sh
load_module common.sh
load_module cli.sh
load_module feature.sh

# Engines
load_module performance.sh
load_module display.sh
load_module memory.sh
load_module thermal.sh
load_module network.sh
load_module game_engine.sh
load_module verify.sh
load_module benchmark.sh
load_module diagnostic.sh
load_module restore.sh

# -----------------------
# Summary
# -----------------------

summary() {

    echo "Mode      : ${MODE:-balanced}"
echo "Refresh   : ${REFRESH:-Unknown}"
echo "Game      : ${CURRENT_GAME:-None}"
echo "Profile   : ${CURRENT_PROFILE:-balanced}"
}

# -----------------------
# Main
# -----------------------

main() {

    command -v parse_args >/dev/null 2>&1 && parse_args "$@"

    command -v create_lock >/dev/null 2>&1 && create_lock

    command -v rotate_log >/dev/null 2>&1 && rotate_log

    command -v feature_detection >/dev/null 2>&1 && feature_detection

    command -v backup_settings >/dev/null 2>&1 && backup_settings

    command -v game_engine >/dev/null 2>&1 && game_engine

    command -v performance_engine >/dev/null 2>&1 && performance_engine

    command -v display_engine >/dev/null 2>&1 && display_engine

    command -v memory_engine >/dev/null 2>&1 && memory_engine

    command -v thermal_engine >/dev/null 2>&1 && thermal_engine

    command -v network_engine >/dev/null 2>&1 && network_engine

    command -v verify_engine >/dev/null 2>&1 && verify_engine

    summary

    command -v cleanup >/dev/null 2>&1 && cleanup
}

main "$@"