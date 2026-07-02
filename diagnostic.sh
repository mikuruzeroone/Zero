#!/system/bin/sh
set -u

diagnostic_engine() {

    log_info "===== Diagnostics ====="

    log_info "Model : $(getprop ro.product.model)"
    log_info "Android : $(getprop ro.build.version.release)"
    log_info "SDK : $(getprop ro.build.version.sdk)"
    log_info "HyperOS : $(getprop ro.mi.os.version.name)"

}