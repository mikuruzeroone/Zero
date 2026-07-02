#!/system/bin/sh
set -u
# =========================================================
# Smart Profile Engine
# =========================================================

PROFILE="balanced"

load_profile() {

    case "$CURRENT_PROFILE" in

        balanced)

            PROFILE_CPU="normal"
            PROFILE_GPU="normal"
            PROFILE_REFRESH=60
            PROFILE_ANIMATION=1.0

        ;;

        performance)

            PROFILE_CPU="high"
            PROFILE_GPU="high"
            PROFILE_REFRESH=120
            PROFILE_ANIMATION=0.5

        ;;

        extreme)

            PROFILE_CPU="max"
            PROFILE_GPU="max"
            PROFILE_REFRESH=120
            PROFILE_ANIMATION=0

        ;;

        thermal)

            PROFILE_CPU="dynamic"
            PROFILE_GPU="dynamic"
            PROFILE_REFRESH=90
            PROFILE_ANIMATION=0.5

        ;;

    esac

}