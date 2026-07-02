#!/system/bin/sh
set -u

verify_engine() {

    log_info "===== Verify Engine ====="

    verify_display

    verify_performance

    log_info "Verify Complete"
}