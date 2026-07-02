#!/system/bin/sh
set -u

benchmark_engine() {

    timer_start

    performance_engine
    display_engine
    memory_engine
    thermal_engine
    network_engine

    timer_end
}