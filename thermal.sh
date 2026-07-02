#!/system/bin/sh
set -u
# =========================================================
# AX Performance Engine v7.0
# Thermal Engine
# =========================================================

read_battery_temp() {

    temp=$(dumpsys battery 2>/dev/null | awk '/temperature/ {print $2}')

    [ -z "$temp" ] && temp=0

    BATTERY_TEMP="$temp"
}

thermal_profile() {

    read_battery_temp

    log_info "Battery Temp : $((BATTERY_TEMP / 10)).$((BATTERY_TEMP % 10))°C"

    # ถ้าอุณหภูมิต่ำกว่า 42°C
    # ไม่เปลี่ยน MODE ที่ผู้ใช้เลือก
    if [ "$BATTERY_TEMP" -lt 420 ]; then
        return
    fi

    # เริ่มลดประสิทธิภาพเมื่อร้อน
    if [ "$BATTERY_TEMP" -lt 450 ]; then

        [ "$MODE" = "extreme" ] && MODE="performance"
        [ "$MODE" = "performance" ] && MODE="balanced"

        log_warn "High temperature detected. Reducing performance."

    else

        MODE="balanced"
        REFRESH=60

        log_warn "Critical temperature detected. Limiting refresh rate."

    fi
}

thermal_engine() {

    log_info "===== Thermal Engine ====="

    thermal_profile

    display_engine

    log_info "Thermal Engine Complete"
}