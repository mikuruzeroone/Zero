#!/system/bin/sh
set -u

memory_engine() {

    log_info "===== Memory Engine ====="

    optimize_memory

    log_info "Memory Engine Complete"
}

optimize_memory() {

    if supports_setting global cached_apps_freezer; then
        safe_put_setting global cached_apps_freezer enabled
    fi

}