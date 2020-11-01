PRODUCT_BUILD_PROP_OVERRIDES += BUILD_UTC_DATE=0

ifeq ($(PRODUCT_GMS_CLIENTID_BASE),)
PRODUCT_PROPERTY_OVERRIDES += \
    ro.com.google.clientidbase=android-google
else
PRODUCT_PROPERTY_OVERRIDES += \
    ro.com.google.clientidbase=$(PRODUCT_GMS_CLIENTID_BASE)
endif

PRODUCT_PROPERTY_OVERRIDES += \
    keyguard.no_require_sim=true

PRODUCT_PROPERTY_OVERRIDES += \
    persist.sys.disable_rescue=true \
    persist.debug.wfd.enable=1 \
    persist.sys.wfd.virtual=0 \
    ro.build.selinux=1

# Disable excessive dalvik debug messages
PRODUCT_PROPERTY_OVERRIDES += \
    dalvik.vm.debug.alloc=0

# Backup tool
PRODUCT_COPY_FILES += \
    vendor/gzosp/prebuilt/common/bin/backuptool.sh:install/bin/backuptool.sh \
    vendor/gzosp/prebuilt/common/bin/backuptool.functions:install/bin/backuptool.functions \
    vendor/gzosp/prebuilt/common/bin/50-gzosp.sh:$(TARGET_COPY_OUT_SYSTEM)/addon.d/50-gzosp.sh \
    vendor/gzosp/prebuilt/common/bin/clean_cache.sh:$(TARGET_COPY_OUT_SYSTEM)/bin/clean_cache.sh

ifeq ($(AB_OTA_UPDATER),true)
PRODUCT_COPY_FILES += \
    vendor/gzosp/prebuilt/common/bin/backuptool_ab.sh:$(TARGET_COPY_OUT_SYSTEM)/bin/backuptool_ab.sh \
    vendor/gzosp/prebuilt/common/bin/backuptool_ab.functions:$(TARGET_COPY_OUT_SYSTEM)/bin/backuptool_ab.functions \
    vendor/gzosp/prebuilt/common/bin/backuptool_postinstall.sh:$(TARGET_COPY_OUT_SYSTEM)/bin/backuptool_postinstall.sh
endif

# Backup services whitelist
PRODUCT_COPY_FILES += \
    vendor/gzosp/config/permissions/backup.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/sysconfig/backup.xml

# Signature compatibility validation
PRODUCT_COPY_FILES += \
    vendor/gzosp/prebuilt/common/bin/otasigcheck.sh:install/bin/otasigcheck.sh

# Gzosp-specific init file
PRODUCT_COPY_FILES += \
    vendor/gzosp/prebuilt/common/etc/init.local.rc:root/init.gzosp.rc

# Copy LatinIME for gesture typing
PRODUCT_COPY_FILES += \
    vendor/gzosp/prebuilt/common/lib/libjni_latinimegoogle.so:$(TARGET_COPY_OUT_SYSTEM)/lib/libjni_latinimegoogle.so

# SELinux file system labels
PRODUCT_COPY_FILES += \
    vendor/gzosp/prebuilt/common/etc/init.d/50selinuxrelabel:$(TARGET_COPY_OUT_SYSTEM)/etc/init.d/50selinuxrelabel

# Enable SIP+VoIP on all targets
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.software.sip.voip.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/android.software.sip.voip.xml

# Fix Dialer
#PRODUCT_COPY_FILES +=  \
#    vendor/gzosp/prebuilt/common/sysconfig/dialer_experience.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/sysconfig/dialer_experience.xml

# privapp permissions
PRODUCT_COPY_FILES += \
    vendor/gzosp/prebuilt/common/etc/permissions/privapp-permissions-gzr.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/privapp-permissions-gzr.xml \
    vendor/gzosp/prebuilt/common/etc/permissions/privapp-permissions-google.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/privapp-permissions-google.xml \
    vendor/gzosp/config/permissions/privapp-permissions-gzosp-product.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/permissions/privapp-permissions-gzosp.xml

# Fonts
PRODUCT_PACKAGES += \
    FontArbutusSourceOverlay \
    FontArvoLatoOverlay \
    FontRubikRubikOverlay \
    FontGoogleSansOverlay \

#-include vendor/gzosp/config/fonts.mk

PRODUCT_PACKAGES += \
     OverlayStub

# Power whitelist
PRODUCT_COPY_FILES += \
    vendor/gzosp/config/permissions/gzosp-power-whitelist.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/sysconfig/gzosp-power-whitelist.xml

# Required packages
PRODUCT_PACKAGES += \
    CellBroadcastReceiver \
    Development \
    SpareParts \
    LockClock \
    su

# Optional packages
PRODUCT_PACKAGES += \
    Basic \
    LiveWallpapersPicker \
    PhaseBeam \
    ThemePicker

# Include explicitly to work around GMS issues
PRODUCT_PACKAGES += \
    libprotobuf-cpp-full \
    librsjni

# AudioFX
PRODUCT_PACKAGES += \
    AudioFX

# Disable vendor restrictions
PRODUCT_RESTRICT_VENDOR_FILES := false

# Extra Optional packages
PRODUCT_PACKAGES += \
    Calculator \
    LatinIME \
    BluetoothExt \
    Launcher3Dark


# Extra tools
PRODUCT_PACKAGES += \
    openvpn \
    e2fsck \
    mke2fs \
    tune2fs \
    fsck.exfat \
    mkfs.exfat \
    ntfsfix \
    ntfs-3g


PRODUCT_PACKAGES += \
    charger_res_images

# Stagefright FFMPEG plugin
PRODUCT_PACKAGES += \
    libffmpeg_extractor \
    libffmpeg_omx \
    media_codecs_ffmpeg.xml

PRODUCT_PROPERTY_OVERRIDES += \
    media.sf.omx-plugin=libffmpeg_omx.so \
    media.sf.extractor-plugin=libffmpeg_extractor.so

# Storage manager
PRODUCT_PROPERTY_OVERRIDES += \
    ro.storage_manager.enabled=true

# easy way to extend to add more packages
-include vendor/extra/product.mk

PRODUCT_PACKAGES += \
    AndroidDarkThemeOverlay \
    SettingsDarkThemeOverlay

# Common overlay
DEVICE_PACKAGE_OVERLAYS += vendor/gzosp/overlay/common

# Versioning System
# gzosp first version.
PRODUCT_VERSION_MAJOR = 11
PRODUCT_VERSION_MINOR = R-Alpha
PRODUCT_VERSION_MAINTENANCE = 1.0
GZOSP_POSTFIX := -$(shell date +"%Y%m%d-%H%M")
ifdef GZOSP_BUILD_EXTRA
    GZOSP_POSTFIX := -$(GZOSP_BUILD_EXTRA)
endif

ifndef GZOSP_BUILD_TYPE
    GZOSP_BUILD_TYPE := UNOFFICIAL
endif

# Set all versions
GZOSP_VERSION := Gzosp-$(GZOSP_BUILD)-$(PRODUCT_VERSION_MAJOR).$(PRODUCT_VERSION_MINOR).$(PRODUCT_VERSION_MAINTENANCE)-$(GZOSP_BUILD_TYPE)$(GZOSP_POSTFIX)
GZOSP_MOD_VERSION := Gzosp-$(GZOSP_BUILD)-$(PRODUCT_VERSION_MAJOR).$(PRODUCT_VERSION_MINOR).$(PRODUCT_VERSION_MAINTENANCE)-$(GZOSP_BUILD_TYPE)$(GZOSP_POSTFIX)

PRODUCT_BUILD_PROP_OVERRIDES += BUILD_DISPLAY_ID="$(BUILD_ID)-$(BUILD_USERNAME)@$(BUILD_HOSTNAME)"

PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.modversion=Gzosp-$(GZOSP_VERSION) \
    ro.gzosp.version=$(GZOSP_VERSION) \
    ro.mod.version=$(GZOSP_BUILD_TYPE)-$(GZOSP_BASE_VERSION)-$(BUILD_DATE) \
    ro.gzosp.fingerprint=$(ROM_FINGERPRINT)

# Google sounds
include vendor/gzosp/google/GoogleAudio.mk
