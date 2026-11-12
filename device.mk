#
# Copyright (C) 2020-2026 OrangeFox Recovery Project
#
# SPDX-License-Identifier: Apache-2.0
#

LOCAL_PATH := device/xiaomi/sagit

# Shipping API (MI 6 launched with Android 7.1.1 / API 25)
PRODUCT_SHIPPING_API_LEVEL := 25

# TWRP / OrangeFox build flags
TW_FRAMERATE := 60
TARGET_RECOVERY_PIXEL_FORMAT := RGBX_8888

# Crypto / FBE
TW_USE_FSCRYPT_POLICY := 1
TW_INCLUDE_CRYPTO := true
TW_INCLUDE_CRYPTO_FBE := true

# Decryption libraries
TARGET_RECOVERY_DEVICE_MODULES += \
    libion \
    vendor.display.config@1.0 \
    vendor.display.config@2.0
RECOVERY_LIBRARY_SOURCE_FILES += \
    $(TARGET_OUT_SHARED_LIBRARIES)/libion.so

# Fastbootd
PRODUCT_PACKAGES += \
    fastbootd \
    android.hardware.fastboot@1.0-impl-mock \
    android.hardware.fastboot@1.0-impl-mock.recovery

# Exclude Apex
TW_EXCLUDE_APEX := true

# OEM otacert
PRODUCT_EXTRA_RECOVERY_KEYS += \
    vendor/recovery/security/miui

# Platform version / security patch (OrangeFox R12.x requirement)
PLATFORM_VERSION := 99.87.36
PLATFORM_VERSION_LAST_STABLE := $(PLATFORM_VERSION)
PLATFORM_SECURITY_PATCH := 2099-12-31
VENDOR_SECURITY_PATCH := $(PLATFORM_SECURITY_PATCH)

# Misc
TARGET_USES_MKE2FS := true
TARGET_RECOVERY_QCOM_RTC_FIX := true
TW_SUPPORT_INPUT_AIDL_HAPTICS := true
