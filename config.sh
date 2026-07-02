#!/system/bin/sh
set -u
# =========================================================
# AX Performance Engine (AXPE)
# Version : 7.0
# Device  : Xiaomi 14T Pro
# Platform: HyperOS 3 / Android 16
# Runtime : Shizuku (No Root)
# =========================================================

# ------------------------------
# Version
# ------------------------------
readonly AXPE_NAME="AX Performance Engine"
readonly AXPE_VERSION="7.0.0"
readonly AXPE_BUILD="Stable"

# ------------------------------
# Mode
# balanced | performance | extreme
# ------------------------------
MODE="extreme"

# ------------------------------
# Feature Switches
# ------------------------------
LOG_ENABLE=1
DEBUG=0
DRY_RUN=0

AUTO_REFRESH=1
AUTO_VERIFY=1
AUTO_BACKUP=1
AUTO_RESTORE=1
AUTO_PROFILE=1
AUTO_BENCHMARK=1

# ------------------------------
# Paths
# ------------------------------
readonly AXPE_DIR="/sdcard/AXPE"

readonly LOG_DIR="$AXPE_DIR/log"

readonly BACKUP_DIR="$AXPE_DIR/backup"

readonly CACHE_DIR="$AXPE_DIR/cache"

readonly LOG_FILE="$LOG_DIR/axpe.log"

readonly LOCK_FILE="/data/local/tmp/axpe.lock"

readonly BACKUP_FILE="$BACKUP_DIR/settings.conf"

# ------------------------------
# Display
# ------------------------------
DEFAULT_REFRESH=120

DEFAULT_ANIMATION_SCALE=0.5

# ------------------------------
# Thermal
# ------------------------------
THERMAL_WARNING=420
THERMAL_CRITICAL=450

# ------------------------------
# Device
# ------------------------------
SUPPORTED_MODEL="Xiaomi 14T Pro"

SUPPORTED_DEVICE="2407FPN8EG"

# ------------------------------
# Create Directories
# ------------------------------
mkdir -p "$AXPE_DIR"
mkdir -p "$LOG_DIR"
mkdir -p "$BACKUP_DIR"
mkdir -p "$CACHE_DIR"