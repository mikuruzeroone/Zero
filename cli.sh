#!/system/bin/sh
set -u
# =========================================================
# AX Performance Engine v7.0
# CLI
# =========================================================

show_help() {

cat << EOF

AX Performance Engine v7.0

Usage:

  axpe.sh [OPTION]

Options

  --balanced
  --performance
  --extreme

  --status
  --verify
  --benchmark

  --backup
  --restore

  --diagnostic

  --dry-run
  --debug

  --help

EOF

}

parse_args() {

while [ $# -gt 0 ]
do

    case "$1" in

        --balanced)
            MODE="balanced"
        ;;

        --performance)
            MODE="performance"
        ;;

        --extreme)
            MODE="extreme"
        ;;
            --mode)
        shift
        case "$1" in
            balanced|performance|extreme|thermal)
                MODE="$1"
            ;;
            *)
                log_warn "Unknown mode : $1"
            ;;
        esac
    ;;
        --verify)
            VERIFY_ONLY=1
        ;;

        --benchmark)
            BENCHMARK_ONLY=1
        ;;

        --backup)
            BACKUP_ONLY=1
        ;;

        --restore)
            RESTORE_ONLY=1
        ;;

        --status)
            STATUS_ONLY=1
        ;;

        --diagnostic)
            DIAGNOSTIC_ONLY=1
        ;;

        --dry-run)
            DRY_RUN=1
        ;;

        --debug)
            DEBUG=1
        ;;

        --help|-h)
            show_help
            exit 0
        ;;

        *)
            log_warn "Unknown argument : $1"
        ;;

    esac

    shift

done

}