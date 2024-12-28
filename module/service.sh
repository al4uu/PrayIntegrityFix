MODPATH="${0%/*}"
. "$MODPATH"/common_func.sh

# Default root method and version
ROOT_METHOD="Unknown"
ROOT_VERSION="Unknown"

# Check for root method and version
if [ -d "/data/adb/ksu" ]; then
    ROOT_METHOD="KernelSU"
    if command -v su &>/dev/null; then
        ROOT_VERSION=$(su --version 2>/dev/null | cut -d ':' -f 1)
    fi
elif [ -d "/data/adb/magisk" ]; then
    ROOT_METHOD="Magisk"
    if command -v magisk &>/dev/null; then
        ROOT_VERSION=$(magisk -V)
    fi
elif [ -d "/data/adb/ap" ]; then
    ROOT_METHOD="APatch"
    if [ -f "/data/adb/ap/version" ]; then
        ROOT_VERSION=$(cat /data/adb/ap/version)
    fi
fi

# Define module and property file paths
MODDIR="/data/adb/modules/playintegrityfix"
MODULE_PROP="${MODDIR}/module.prop"
BACKUP_PROP="${MODULE_PROP}.orig"

# Backup module.prop if it exists and backup doesn't exist
if [ -f "$MODULE_PROP" ] && [ ! -f "$BACKUP_PROP" ]; then
    cp "$MODULE_PROP" "$BACKUP_PROP"
fi

# Modify module.prop with updated root method and version information
if [ -f "$MODULE_PROP" ]; then
    sed -i "s/^description=.*/description=[ ✅ PrayIntegrityFix is working with ${ROOT_METHOD} (${ROOT_VERSION}) ] Universal modular fix for Play Integrity (and SafetyNet) on devices running Android 8-15/" "$MODULE_PROP"
fi

# Conditional sensitive properties

# Magisk Recovery Mode
resetprop_if_match ro.boot.mode recovery unknown
resetprop_if_match ro.bootmode recovery unknown
resetprop_if_match vendor.boot.mode recovery unknown

# SELinux
resetprop_if_diff ro.boot.selinux enforcing
# Use toybox to protect stat access time reading
if [ "$(toybox cat /sys/fs/selinux/enforce)" = "0" ]; then
    chmod 640 /sys/fs/selinux/enforce
    chmod 440 /sys/fs/selinux/policy
fi

# Conditional late sensitive properties

# Wait until boot is completed or timeout after 60 seconds
TIMEOUT=60
WAIT_TIME=0
until [ "$(getprop sys.boot_completed)" = "1" ] || [ $WAIT_TIME -ge $TIMEOUT ]; do
    sleep 1
    WAIT_TIME=$((WAIT_TIME + 1))
done

# If boot is still not completed after timeout, print warning
if [ $WAIT_TIME -ge $TIMEOUT ]; then
    echo "Warning: Boot completed property not set within timeout."
fi

# SafetyNet/Play Integrity + OEM

# Avoid bootloop on some Xiaomi devices
resetprop_if_diff ro.secureboot.lockstate locked

# Avoid breaking Realme fingerprint scanners
resetprop_if_diff ro.boot.flash.locked 1
resetprop_if_diff ro.boot.realme.lockstate 1

# Avoid breaking Oppo fingerprint scanners
resetprop_if_diff ro.boot.vbmeta.device_state locked

# Avoid breaking OnePlus display modes/fingerprint scanners
resetprop_if_diff vendor.boot.verifiedbootstate green

# Avoid breaking OnePlus/Oppo fingerprint scanners on OOS/ColorOS 12+
resetprop_if_diff ro.boot.verifiedbootstate green
resetprop_if_diff ro.boot.veritymode enforcing
resetprop_if_diff vendor.boot.vbmeta.device_state locked

# Other
resetprop_if_diff sys.oem_unlock_allowed 0
