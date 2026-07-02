#!/system/bin/sh
set -u
# =========================================================
# AXPE Feature Detection
# =========================================================

detect_android() {
    ANDROID_VERSION="$(getprop ro.build.version.release)"
    SDK="$(getprop ro.build.version.sdk)"
}

detect_hyperos() {

    HYPEROS_VERSION="$(getprop ro.mi.os.version.name)"

    if [ -n "$HYPEROS_VERSION" ]; then
        IS_HYPEROS=1
    else
        IS_HYPEROS=0
    fi
}

detect_root() {

    if command -v su >/dev/null 2>&1; then
        HAS_ROOT=1
    else
        HAS_ROOT=0
    fi
}

detect_shizuku() {

    if service list | grep -qi shizuku; then
        HAS_SHIZUKU=1
    else
        HAS_SHIZUKU=0
    fi
}

feature_detection() {

    detect_android
    detect_hyperos
    detect_root
    detect_shizuku

    log_info "Android : $ANDROID_VERSION"
    log_info "SDK : $SDK"
    log_info "HyperOS : $IS_HYPEROS"
    log_info "Shizuku : $HAS_SHIZUKU"
}