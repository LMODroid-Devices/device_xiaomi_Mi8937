#
# Copyright (C) 2021 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

# Cryptfshw
TARGET_EXCLUDE_CRYPTFSHW := true

# Inherit from mithorium-common
$(call inherit-product, device/xiaomi/mithorium-common/mithorium.mk)
$(call inherit-product, frameworks/native/build/phone-xhdpi-2048-dalvik-heap.mk)

# Boot animation
TARGET_SCREEN_HEIGHT := 1280
TARGET_SCREEN_WIDTH := 720

# Dynamic Partitions
PRODUCT_BUILD_SUPER_PARTITION := false
PRODUCT_USE_DYNAMIC_PARTITIONS := true
PRODUCT_RETROFIT_DYNAMIC_PARTITIONS := true

# Overlays
DEVICE_PACKAGE_OVERLAYS += \
    $(LOCAL_PATH)/overlay

ifeq ($(PRODUCT_HARDWARE),Mi8917)
PRODUCT_PACKAGES += \
    xiaomi_rolex_overlay \
    xiaomi_riva_overlay \
    xiaomi_ugglite_overlay
else ifeq ($(PRODUCT_HARDWARE),Mi8937)
PRODUCT_PACKAGES += \
    xiaomi_landtoni_overlay \
    xiaomi_landtoni_overlay_Settings \
    xiaomi_prada_overlay \
    xiaomi_prada_overlay_Settings \
    xiaomi_ugg_overlay
endif

# Permissions
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.fingerprint.xml:$(TARGET_COPY_OUT_ODM)/etc/permissions/sku_fingerprint/android.hardware.fingerprint.xml

# Audio
PRODUCT_COPY_FILES += \
    $(call find-copy-subdir-files,*,$(LOCAL_PATH)/audio/,$(TARGET_COPY_OUT_VENDOR)/etc/)

# Camera
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/blank.xml:$(TARGET_COPY_OUT_VENDOR)/etc/camera/camera_config.xml

PRODUCT_PACKAGES += \
    camera.ulysse \
    camera.wingtech

ifeq ($(PRODUCT_HARDWARE),Mi8937)
PRODUCT_PACKAGES += \
    camera.land
endif

# Fingerprint
ifeq ($(PRODUCT_HARDWARE),Mi8937)
PRODUCT_PACKAGES += \
    android.hardware.biometrics.fingerprint@2.1-service.xiaomi_landtoni \
    android.hardware.biometrics.fingerprint@2.1-service.xiaomi_ulysse
endif

# Input
PRODUCT_COPY_FILES += \
    $(call find-copy-subdir-files,*,$(LOCAL_PATH)/keylayout/,$(TARGET_COPY_OUT_VENDOR)/usr/keylayout/) \
    $(foreach f, msm8917-sku5-snd-card_Button_Jack.kl msm8920-sku7-snd-card_Button_Jack.kl msm8952-sku1-snd-card_Button_Jack.kl, \
        $(LOCAL_PATH)/keylayout/msm8952-snd-card-mtp_Button_Jack.kl:$(TARGET_COPY_OUT_VENDOR)/usr/keylayout/$(f))

# Recovery
ifeq ($(PRODUCT_HARDWARE),Mi8937)
PRODUCT_COPY_FILES += \
    vendor/xiaomi/Mi8937/proprietary/vendor/bin/hvdcp_opti:$(TARGET_COPY_OUT_RECOVERY)/root/system/bin/hvdcp_opti
endif

# Rootdir
PRODUCT_PACKAGES += \
    fstab.qcom_ramdisk \
    init.baseband.sh \
    init.xiaomi.device.rc \
    init.xiaomi.device.sh

ifeq ($(PRODUCT_HARDWARE),Mi8937)
PRODUCT_PACKAGES += \
    init.goodix.sh
endif

# Sensors
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/blankfile:$(TARGET_COPY_OUT_VENDOR)/etc/sensors/sensor_def_qcomdev.conf \
    $(call find-copy-subdir-files,*,$(LOCAL_PATH)/configs/sensors/,$(TARGET_COPY_OUT_VENDOR)/etc/sensors/)

# Shims
PRODUCT_PACKAGES += \
    libshims_android \
    libshims_ui \
    libwui

ifeq ($(PRODUCT_HARDWARE),Mi8937)
PRODUCT_PACKAGES += \
    fakelogprint \
    libshim_mutexdestroy \
    libshim_pthreadts \
    libshims_binder
endif

# Soong namespaces
PRODUCT_SOONG_NAMESPACES += \
    $(LOCAL_PATH)

# Touch HAL
PRODUCT_PACKAGES += \
    vendor.lineage.touch@1.0-service.xiaomi_mi8937

# Wifi
PRODUCT_PACKAGES += \
    WifiOverlay_prada

# Inherit from vendor blobs
ifeq ($(PRODUCT_HARDWARE),Mi8917)
$(call inherit-product, vendor/xiaomi/Mi8917/Mi8917-vendor.mk)
else ifeq ($(PRODUCT_HARDWARE),Mi8937)
$(call inherit-product, vendor/xiaomi/Mi8937/Mi8937-vendor.mk)
endif
