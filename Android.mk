#
# Copyright 2016 The CyanogenMod Project
# Copyright 2017 The LineageOS Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

LOCAL_PATH := $(call my-dir)

ifneq ($(filter h930 h932 us998,$(TARGET_DEVICE)),)

include $(call all-makefiles-under,$(LOCAL_PATH))

include $(CLEAR_VARS)

# CPPF Images
CPPF_IMAGES := \
    cppf.b00 cppf.b01 cppf.b02 cppf.b03 cppf.b04 \
    cppf.b05 cppf.b06 cppf.b07 cppf.mdt

CPPF_SYMLINKS := $(addprefix $(TARGET_OUT_ETC)/firmware/,$(notdir $(CPPF_IMAGES)))
$(CPPF_SYMLINKS): $(LOCAL_INSTALLED_MODULE)
	@echo "CPPF firmware link: $@"
	@mkdir -p $(dir $@)
	@rm -rf $@
	$(hide) ln -sf /persist-lg/firmware/$(notdir $@) $@

ALL_DEFAULT_INSTALLED_MODULES += $(CPPF_SYMLINKS)
# END CPPF Images

# DXHDCP2 Images
DXHDCP2_IMAGES := \
    dxhdcp2.b00 dxhdcp2.b01 dxhdcp2.b02 dxhdcp2.b03 dxhdcp2.b04 \
    dxhdcp2.b05 dxhdcp2.b06 dxhdcp2.b07 dxhdcp2.mdt

DXHDCP2_SYMLINKS := $(addprefix $(TARGET_OUT_ETC)/firmware/,$(notdir $(DXHDCP2_IMAGES)))
$(DXHDCP2_SYMLINKS): $(LOCAL_INSTALLED_MODULE)
	@echo "DXHDCP2 firmware link: $@"
	@mkdir -p $(dir $@)
	@rm -rf $@
	$(hide) ln -sf /firmware/image/$(notdir $@) $@

ALL_DEFAULT_INSTALLED_MODULES += $(DXHDCP2_SYMLINKS)
# END DXHDCP2 Images

# WIDEVINE Images
WIDEVINE_IMAGES := \
    widevine.b00 widevine.b01 widevine.b02 widevine.b03 widevine.b04 \
    widevine.b05 widevine.b06 widevine.b07 widevine.mdt

WIDEVINE_SYMLINKS := $(addprefix $(TARGET_OUT_VENDOR)/firmware/,$(notdir $(WIDEVINE_IMAGES)))
$(WIDEVINE_SYMLINKS): $(LOCAL_INSTALLED_MODULE)
	@echo "WIDEVINE firmware link: $@"
	@mkdir -p $(dir $@)
	@rm -rf $@
	$(hide) ln -sf /persist-lg/firmware/$(notdir $@) $@

ALL_DEFAULT_INSTALLED_MODULES += $(WIDEVINE_SYMLINKS)
# END WIDEVINE Images

IMS_LIBS := libimscamera_jni.so libimsmedia_jni.so
IMS_SYMLINKS := $(addprefix $(TARGET_OUT_VENDOR_APPS)/ims/lib/arm64/,$(notdir $(IMS_LIBS)))
$(IMS_SYMLINKS): $(LOCAL_INSTALLED_MODULE)
	@echo "IMS lib link: $@"
	@mkdir -p $(dir $@)
	@rm -rf $@
	$(hide) ln -sf /vendor/lib64/$(notdir $@) $@

ALL_DEFAULT_INSTALLED_MODULES += $(IMS_SYMLINKS)

RFS_MSM_ADSP_SYMLINKS := $(TARGET_OUT_VENDOR)/rfs/msm/adsp/
$(RFS_MSM_ADSP_SYMLINKS): $(LOCAL_INSTALLED_MODULE)
	@echo "Creating RFS MSM ADSP folder structure: $@"
	@rm -rf $@/*
	@mkdir -p $(dir $@)/readonly/vendor
	$(hide) ln -sf /data/vendor/tombstones/rfs/lpass $@/ramdumps
	$(hide) ln -sf /persist/rfs/msm/adsp $@/readwrite
	$(hide) ln -sf /persist/rfs/shared $@/shared
	$(hide) ln -sf /persist/hlos_rfs/shared $@/hlos
	$(hide) ln -sf /firmware $@/readonly/firmware
	$(hide) ln -sf /vendor/firmware $@/readonly/vendor/firmware

RFS_MSM_MPSS_SYMLINKS := $(TARGET_OUT_VENDOR)/rfs/msm/mpss/
$(RFS_MSM_MPSS_SYMLINKS): $(LOCAL_INSTALLED_MODULE)
	@echo "Creating RFS MSM MPSS folder structure: $@"
	@rm -rf $@/*
	@mkdir -p $(dir $@)/readonly/vendor
	$(hide) ln -sf /data/vendor/tombstones/rfs/modem $@/ramdumps
	$(hide) ln -sf /persist/rfs/msm/mpss $@/readwrite
	$(hide) ln -sf /persist/rfs/shared $@/shared
	$(hide) ln -sf /persist/hlos_rfs/shared $@/hlos
	$(hide) ln -sf /firmware $@/readonly/firmware
	$(hide) ln -sf /vendor/firmware $@/readonly/vendor/firmware

RFS_MSM_SLPI_SYMLINKS := $(TARGET_OUT_VENDOR)/rfs/msm/slpi/
$(RFS_MSM_SLPI_SYMLINKS): $(LOCAL_INSTALLED_MODULE)
	@echo "Creating RFS MSM SLPI folder structure: $@"
	@rm -rf $@/*
	@mkdir -p $(dir $@)/readonly/vendor
	$(hide) ln -sf /data/vendor/tombstones/rfs/modem $@/ramdumps
	$(hide) ln -sf /persist/rfs/msm/slpi $@/readwrite
	$(hide) ln -sf /persist/rfs/shared $@/shared
	$(hide) ln -sf /persist/hlos_rfs/shared $@/hlos
	$(hide) ln -sf /firmware $@/readonly/firmware
	$(hide) ln -sf /vendor/firmware $@/readonly/vendor/firmware

ALL_DEFAULT_INSTALLED_MODULES += $(RFS_MSM_ADSP_SYMLINKS) $(RFS_MSM_MPSS_SYMLINKS) $(RFS_MSM_SLPI_SYMLINKS)

BTFW_IMAGES := \
    crbtfw20.tlv crbtfw21.tlv crnv20.bin crnv21.bin

BTFW_SYMLINKS := $(addprefix $(TARGET_OUT_VENDOR)/etc/firmware/,$(notdir $(BTFW_IMAGES)))
$(BTFW_SYMLINKS): $(LOCAL_INSTALLED_MODULE)
	@echo "Bluetooth Firmware firmware link: $@"
	@mkdir -p $(dir $@)
	@rm -rf $@
	$(hide) ln -sf /vendor/firmware/$(notdir $@) $@

ALL_DEFAULT_INSTALLED_MODULES += $(BTFW_SYMLINKS)

# Create a link for the WCNSS MAC firmware, which ends up as a writable
# version in /data/misc/wifi
WLAN_MAC_SYMLINK := $(TARGET_OUT_VENDOR)/etc/firmware/wlan/qca_cld/wlan_mac.bin
$(WLAN_MAC_SYMLINK): $(LOCAL_INSTALLED_MODULE)
	@mkdir -p $(dir $@)
	@rm -rf $@
	$(hide) ln -sf /data/vendor/wifi/$(notdir $@) $@

ALL_DEFAULT_INSTALLED_MODULES += $(WLAN_MAC_SYMLINK)

endif
