#!/system/bin/sh
set -u
# =========================================================
# AX Performance Engine v7.1
# Restore Engine
# =========================================================

restore_table() {

    table="$1"
    file="$BACKUP_DIR/$table.txt"

    [ -f "$file" ] || return 0

    log_info "Restore $table"

    while IFS='=' read -r key value
    do
        case "$key" in
            ""|\#*)
                continue
            ;;
        esac

        run_safe settings put "$table" "$key" "$value"

        verify_setting "$table" "$key" "$value" || \
            log_warn "Restore failed : $table/$key"

    done < "$file"
}

restore_settings() {

    log_info "===== Restore Engine ====="

    restore_table system
    restore_table global
    restore_table secure

    log_info "Settings Restore Complete"
}