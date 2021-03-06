PRODUCT_BRAND ?= mantoui

# bootanimation
PRODUCT_COPY_FILES += \
    vendor/mantoui/prebuilt/bootanimation/bootanimation.zip:system/media/bootanimation.zip

ifeq ($(PRODUCT_GMS_CLIENTID_BASE),)
PRODUCT_PROPERTY_OVERRIDES += \
    ro.com.google.clientidbase=android-google
else
PRODUCT_PROPERTY_OVERRIDES += \
    ro.com.google.clientidbase=$(PRODUCT_GMS_CLIENTID_BASE)
endif

# general properties
PRODUCT_PROPERTY_OVERRIDES += \
    ro.url.legal=http://www.google.com/intl/%s/mobile/android/basic/phone-legal.html \
    ro.com.android.wifi-watchlist=GoogleGuest \
    ro.setupwizard.enterprise_mode=1 \
    persist.sys.root_access=1

# enable ADB authentication if not on eng build
ifneq ($(TARGET_BUILD_VARIANT),eng)
ADDITIONAL_DEFAULT_PROPERTIES += ro.adb.secure=1
endif

# ROM Statistics and ROM Identification
PRODUCT_PROPERTY_OVERRIDES += \
    ro.romstats.url=http://stats.mantoui.com/ \
    ro.romstats.name=Mantoui \
    ro.romstats.version=1.0.0 \
    ro.romstats.askfirst=0 \
    ro.romstats.tframe=1

# Backup Tool
PRODUCT_COPY_FILES += \
    vendor/mantoui/prebuilt/bin/backuptool.sh:system/bin/backuptool.sh \
    vendor/mantoui/prebuilt/bin/backuptool.functions:system/bin/backuptool.functions \
    vendor/mantoui/prebuilt/bin/50-hosts.sh:system/addon.d/50-hosts.sh \
    vendor/mantoui/prebuilt/bin/blacklist:system/addon.d/blacklist

# init.d support
PRODUCT_COPY_FILES += \
    vendor/mantoui/prebuilt/etc/init.d/00banner:system/etc/init.d/00banner \
    vendor/mantoui/prebuilt/bin/sysinit:system/bin/sysinit

# userinit support
PRODUCT_COPY_FILES += \
    vendor/mantoui/prebuilt/etc/init.d/90userinit:system/etc/init.d/90userinit

# Init script file with mantoui extras
PRODUCT_COPY_FILES += \
    vendor/mantoui/prebuilt/etc/init.local.rc:root/init.mantoui.rc

# Enable SIP and VoIP on all targets
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.software.sip.voip.xml:system/etc/permissions/android.software.sip.voip.xml

# Chromium Prebuilt
ifeq ($(PRODUCT_PREBUILT_WEBVIEWCHROMIUM),yes)
-include prebuilts/chromium/$(TARGET_DEVICE)/chromium_prebuilt.mk
endif

# Dashclock
PRODUCT_COPY_FILES += \
    vendor/mantoui/prebuilt/app/DashClock.apk:system/app/DashClock.apk

# Additional packages
-include vendor/mantoui/config/packages.mk

# Versioning
-include vendor/mantoui/config/version.mk

# Add our overlays
PRODUCT_PACKAGE_OVERLAYS += vendor/mantoui/overlay/common
