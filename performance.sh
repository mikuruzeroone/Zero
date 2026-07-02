#!/system/bin/sh
set -u
# =========================================================
# AX Performance Engine v7.0
# Performance Engine
# =========================================================

performance_engine() {

    log_info "===== Performance Engine ====="

    apply_performance_mode
    optimize_runtime
    optimize_scheduler
    verify_performance
    apply_kernel_tuning

    log_info "Performance Engine Complete"
}

apply_performance_mode() {

    case "$MODE" in

        balanced)
            PERFORMANCE_LEVEL="balanced"
        ;;

        performance)
            PERFORMANCE_LEVEL="performance"
        ;;

        extreme)
            PERFORMANCE_LEVEL="extreme"
        ;;

        *)
            PERFORMANCE_LEVEL="balanced"
        ;;
    esac

    log_info "Performance Mode : $PERFORMANCE_LEVEL"
}

optimize_runtime() {

    log_debug "Runtime Optimization"

    has_command cmd || return

    cmd activity --help >/dev/null 2>&1 || return

    # เรียกเพียงครั้งเดียว
    run_safe cmd activity idle-maintenance
}

optimize_scheduler() {

    log_debug "Scheduler Optimization"

    has_command cmd || return

    cmd jobscheduler --help >/dev/null 2>&1 || return

    run_safe cmd jobscheduler run -f android 999
}

verify_performance() {

    log_debug "Performance Verify"

    [ "$MODE" = "$PERFORMANCE_LEVEL" ] || \
        log_warn "Performance mode mismatch"
}

write_if() {
 [ -e "$1" ] && echo "$2" > "$1" 2>/dev/null
}
apply_kernel_tuning() {
 case "$MODE" in
  extreme)
   for g in /sys/devices/system/cpu/cpufreq/policy*/scaling_governor; do write_if "$g" performance; done
   write_if /dev/cpuset/top-app/cpus 0-7
   for f in /dev/stune/top-app/schedtune.boost /dev/stune/top-app/uclamp.min; do [ -e "$f" ]&& echo 50>"$f"; done
   ;;
  *)
   for g in /sys/devices/system/cpu/cpufreq/policy*/scaling_governor; do write_if "$g" schedutil; done
   for f in /dev/stune/top-app/schedtune.boost /dev/stune/top-app/uclamp.min; do [ -e "$f" ]&& echo 0>"$f"; done
   ;;
 esac
}
