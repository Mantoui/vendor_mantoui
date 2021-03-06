# Versioning of the ROM

ifdef BUILDTYPE_NIGHTLY
    ROM_BUILDTYPE := NIGHTLY
endif
ifdef BUILDTYPE_WEEKLY
    ROM_BUILDTYPE := WEEKLY
endif
ifdef BUILDTYPE_AUTOTEST
    ROM_BUILDTYPE := AUTOTEST
endif
ifdef BUILDTYPE_EXPERIMENTAL
    ROM_BUILDTYPE := EXPERIMENTAL
endif
ifdef BUILDTYPE_RELEASE
    ROM_BUILDTYPE := RELEASE
endif

ifndef ROM_BUILDTYPE
    ROM_BUILDTYPE := HOMEMADE
endif
ifdef BUILDTYPE_TEST
    ROM_BUILDTYPE := TEST
endif

TARGET_PRODUCT_SHORT := $(TARGET_PRODUCT)
TARGET_PRODUCT_SHORT := $(subst mantoui_,,$(TARGET_PRODUCT_SHORT))

# Build the final version string
ifdef BUILDTYPE_RELEASE
    ROM_VERSION := $(PLATFORM_VERSION)-$(TARGET_PRODUCT_SHORT)
else
ifeq ($(ROM_BUILDTIME_LOCAL),y)
    ROM_VERSION := $(PLATFORM_VERSION)-$(TARGET_PRODUCT_SHORT)-$(shell date +%Y%m%d-%H%M%z)-$(ROM_BUILDTYPE)
else
    ROM_VERSION := $(PLATFORM_VERSION)-$(TARGET_PRODUCT_SHORT)-$(shell date -u +%Y%m%d)-$(ROM_BUILDTYPE)
endif
endif
ifdef BUILDTYPE_WEEKLY
    ROM_VERSION := $(PLATFORM_VERSION)-$(TARGET_PRODUCT_SHORT)-$(shell date +%y%m%d-%w)-$(ROM_BUILDTYPE)
endif
ifdef BUILDTYPE_TEST
    ROM_VERSION := $(PLATFORM_VERSION)-$(TARGET_PRODUCT_SHORT)-$(shell date +%y%m%d-%H%M)-$(ROM_BUILDTYPE)
endif
ifdef BUILDTYPE_NIGHTLY
    ROM_VERSION := $(PLATFORM_VERSION)-$(TARGET_PRODUCT_SHORT)-$(shell date +%y%m%d)-$(ROM_BUILDTYPE)
endif

# Apply it to build.prop
PRODUCT_PROPERTY_OVERRIDES += \
    ro.modversion=Mantoui-$(ROM_VERSION) \
    ro.mantoui.version=$(ROM_VERSION)
