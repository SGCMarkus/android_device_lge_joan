#
# Copyright 2018 The LineageOS Project
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

ifneq ($(filter h930 h932 us998 joan,$(TARGET_DEVICE)),)

include $(call all-makefiles-under,$(LOCAL_PATH))

include $(CLEAR_VARS)

# builds require us to create the mount points at compile time.
# Just creating it for all cases since it does not hurt.
FIRMWARE_MOUNT_POINT := $(TARGET_OUT_VENDOR)/firmware_mnt
$(FIRMWARE_MOUNT_POINT): $(LOCAL_INSTALLED_MODULE)
	@echo "Creating $(FIRMWARE_MOUNT_POINT)"
	@mkdir -p $(TARGET_OUT_VENDOR)/firmware_mnt

DSP_MOUNT_POINT := $(TARGET_OUT_VENDOR)/dsp
$(DSP_MOUNT_POINT): $(LOCAL_INSTALLED_MODULE)
	@echo "Creating $(DSP_MOUNT_POINT)"
	@mkdir -p $(TARGET_OUT_VENDOR)/dsp

BT_FIRMWARE_MOUNT_POINT := $(TARGET_OUT_VENDOR)/bt_firmware
$(BT_FIRMWARE_MOUNT_POINT): $(LOCAL_INSTALLED_MODULE)
	@echo "Creating $(BT_FIRMWARE_MOUNT_POINT)"
	@mkdir -p $(TARGET_OUT_VENDOR)/bt_firmware

ALL_DEFAULT_INSTALLED_MODULES += $(FIRMWARE_MOUNT_POINT) $(DSP_MOUNT_POINT) $(BT_FIRMWARE_MOUNT_POINT)
# END Vendor mounts

# CPPF Images
CPPF_IMAGES := \
    cppf.b00 cppf.b01 cppf.b02 cppf.b03 cppf.b04 \
    cppf.b05 cppf.b06 cppf.b07 cppf.mdt

CPPF_SYMLINKS := $(addprefix $(TARGET_OUT_VENDOR)/firmware/,$(notdir $(CPPF_IMAGES)))
$(CPPF_SYMLINKS): $(LOCAL_INSTALLED_MODULE)
	@echo "CPPF firmware link: $@"
	@mkdir -p $(dir $@)
	@rm -rf $@
	$(hide) ln -sf /mnt/vendor/persist-lg/firmware/$(notdir $@) $@

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
	$(hide) ln -sf /vendor/firmware_mnt/image/$(notdir $@) $@

ALL_DEFAULT_INSTALLED_MODULES += $(DXHDCP2_SYMLINKS)
# END DXHDCP2 Images

# IPA FWS Images
IPA_FWS_IMAGES := \
    ipa_fws.b00 ipa_fws.b01 ipa_fws.b02 ipa_fws.b03 ipa_fws.b04 \
    ipa_fws.mdt

IPA_FWS_SYMLINKS := $(addprefix $(TARGET_OUT_ETC)/firmware/,$(notdir $(IPA_FWS_IMAGES)))
$(IPA_FWS_SYMLINKS): $(LOCAL_INSTALLED_MODULE)
	@echo "IPA FWS firmware link: $@"
	@mkdir -p $(dir $@)
	@rm -rf $@
	$(hide) ln -sf /firmware/image/$(notdir $@) $@

ALL_DEFAULT_INSTALLED_MODULES += $(IPA_FWS_SYMLINKS)
# END IPA FWS Images

# WIDEVINE Images
WIDEVINE_IMAGES := \
    widevine.b00 widevine.b01 widevine.b02 widevine.b03 widevine.b04 \
    widevine.b05 widevine.b06 widevine.b07 widevine.mdt

WIDEVINE_SYMLINKS := $(addprefix $(TARGET_OUT_VENDOR)/firmware/,$(notdir $(WIDEVINE_IMAGES)))
$(WIDEVINE_SYMLINKS): $(LOCAL_INSTALLED_MODULE)
	@echo "WIDEVINE firmware link: $@"
	@mkdir -p $(dir $@)
	@rm -rf $@
	$(hide) ln -sf /mnt/vendor/persist-lg/firmware/$(notdir $@) $@

ALL_DEFAULT_INSTALLED_MODULES += $(WIDEVINE_SYMLINKS)
# END WIDEVINE Images

# HDCPSRM Images
HDCPSRM_IMAGES := \
    hdcpsrm.b00 hdcpsrm.b01 hdcpsrm.b02 hdcpsrm.b03 hdcpsrm.b04 \
    hdcpsrm.b05 hdcpsrm.b06 hdcpsrm.b07 hdcpsrm.mdt

HDCPSRM_SYMLINKS := $(addprefix $(TARGET_OUT_VENDOR)/firmware/,$(notdir $(HDCPSRM_IMAGES)))
$(HDCPSRM_SYMLINKS): $(LOCAL_INSTALLED_MODULE)
	@echo "HDCPSRM firmware link: $@"
	@mkdir -p $(dir $@)
	@rm -rf $@
	$(hide) ln -sf /mnt/vendor/persist-lg/firmware/$(notdir $@) $@

ALL_DEFAULT_INSTALLED_MODULES += $(HDCPSRM_SYMLINKS)
# END HDCPSRM Images

IMS_LIBS := libimscamera_jni.so libimsmedia_jni.so
IMS_SYMLINKS := $(addprefix $(TARGET_OUT_VENDOR_APPS)/ims/lib/arm64/,$(notdir $(IMS_LIBS)))
$(IMS_SYMLINKS): $(LOCAL_INSTALLED_MODULE)
	@echo "IMS lib link: $@"
	@mkdir -p $(dir $@)
	@rm -rf $@
	$(hide) ln -sf /vendor/lib64/$(notdir $@) $@

ALL_DEFAULT_INSTALLED_MODULES += $(IMS_SYMLINKS)

# RFS MSM
RFS_APQ_GNSS_SYMLINKS := $(TARGET_OUT_VENDOR)/rfs/apq/gnss/
$(RFS_APQ_GNSS_SYMLINKS): $(LOCAL_INSTALLED_MODULE)
	@echo "Creating RFS APQ GNSS folder structure: $@"
	@rm -rf $@
	@mkdir -p $(dir $@)/readonly/vendor
	$(hide) ln -sf /data/vendor/tombstones/rfs/modem $@/ramdumps
	$(hide) ln -sf /mnt/vendor/persist/rfs/apq/gnss $@/readwrite
	$(hide) ln -sf /mnt/vendor/persist/rfs/shared $@/shared
	$(hide) ln -sf /mnt/vendor/persist/hlos_rfs/shared $@/hlos
	$(hide) ln -sf /vendor/firmware_mnt $@/readonly/firmware
	$(hide) ln -sf /vendor/firmware $@/readonly/vendor/firmware

RFS_MDM_ADSP_SYMLINKS := $(TARGET_OUT_VENDOR)/rfs/mdm/adsp/
$(RFS_MDM_ADSP_SYMLINKS): $(LOCAL_INSTALLED_MODULE)
	@echo "Creating RFS MDM ADSP folder structure: $@"
	@rm -rf $@
	@mkdir -p $(dir $@)/readonly/vendor
	$(hide) ln -sf /data/vendor/tombstones/rfs/lpass $@/ramdumps
	$(hide) ln -sf /mnt/vendor/persist/rfs/mdm/adsp $@/readwrite
	$(hide) ln -sf /mnt/vendor/persist/rfs/shared $@/shared
	$(hide) ln -sf /mnt/vendor/persist/hlos_rfs/shared $@/hlos
	$(hide) ln -sf /vendor/firmware_mnt $@/readonly/firmware
	$(hide) ln -sf /vendor/firmware $@/readonly/vendor/firmware

RFS_MDM_CDSP_SYMLINKS := $(TARGET_OUT_VENDOR)/rfs/mdm/cdsp/
$(RFS_MDM_CDSP_SYMLINKS): $(LOCAL_INSTALLED_MODULE)
	@echo "Creating RFS MDM CDSP folder structure: $@"
	@rm -rf $@
	@mkdir -p $(dir $@)/readonly
	$(hide) ln -sf /data/vendor/tombstones/rfs/lpass $@/ramdumps
	$(hide) ln -sf /mnt/vendor/persist/rfs/mdm/adsp $@/readwrite
	$(hide) ln -sf /mnt/vendor/persist/rfs/shared $@/shared
	$(hide) ln -sf /mnt/vendor/persist/hlos_rfs/shared $@/hlos
	$(hide) ln -sf /vendor/firmware_mnt $@/readonly/firmware

RFS_MDM_MPSS_SYMLINKS := $(TARGET_OUT_VENDOR)/rfs/mdm/mpss/
$(RFS_MDM_MPSS_SYMLINKS): $(LOCAL_INSTALLED_MODULE)
	@echo "Creating RFS MDM MPSS folder structure: $@"
	@rm -rf $@
	@mkdir -p $(dir $@)/readonly/vendor
	$(hide) ln -sf /data/vendor/tombstones/rfs/modem $@/ramdumps
	$(hide) ln -sf /mnt/vendor/persist/rfs/mdm/mpss $@/readwrite
	$(hide) ln -sf /mnt/vendor/persist/rfs/shared $@/shared
	$(hide) ln -sf /mnt/vendor/persist/hlos_rfs/shared $@/hlos
	$(hide) ln -sf /vendor/firmware_mnt $@/readonly/firmware
	$(hide) ln -sf /vendor/firmware $@/readonly/vendor/firmware

RFS_MDM_SLPI_SYMLINKS := $(TARGET_OUT_VENDOR)/rfs/mdm/slpi/
$(RFS_MDM_SLPI_SYMLINKS): $(LOCAL_INSTALLED_MODULE)
	@echo "Creating RFS MDM SLPI folder structure: $@"
	@rm -rf $@
	@mkdir -p $(dir $@)/readonly
	$(hide) ln -sf /data/vendor/tombstones/rfs/slpi $@/ramdumps
	$(hide) ln -sf /mnt/vendor/persist/rfs/mdm/slpi $@/readwrite
	$(hide) ln -sf /mnt/vendor/persist/rfs/shared $@/shared
	$(hide) ln -sf /mnt/vendor/persist/hlos_rfs/shared $@/hlos
	$(hide) ln -sf /vendor/firmware_mnt $@/readonly/firmware

RFS_MDM_TN_SYMLINKS := $(TARGET_OUT_VENDOR)/rfs/mdm/tn/
$(RFS_MDM_TN_SYMLINKS): $(LOCAL_INSTALLED_MODULE)
	@echo "Creating RFS MDM TN folder structure: $@"
	@rm -rf $@
	@mkdir -p $(dir $@)/readonly
	$(hide) ln -sf /data/vendor/tombstones/rfs/tn $@/ramdumps
	$(hide) ln -sf /mnt/vendor/persist/rfs/mdm/tn $@/readwrite
	$(hide) ln -sf /mnt/vendor/persist/rfs/shared $@/shared
	$(hide) ln -sf /mnt/vendor/persist/hlos_rfs/shared $@/hlos
	$(hide) ln -sf /vendor/firmware_mnt $@/readonly/firmware

RFS_MSM_ADSP_SYMLINKS := $(TARGET_OUT_VENDOR)/rfs/msm/adsp/
$(RFS_MSM_ADSP_SYMLINKS): $(LOCAL_INSTALLED_MODULE)
	@echo "Creating RFS MSM ADSP folder structure: $@"
	@rm -rf $@/*
	@mkdir -p $(dir $@)/readonly/vendor
	$(hide) ln -sf /data/vendor/tombstones/rfs/lpass $@/ramdumps
	$(hide) ln -sf /mnt/vendor/persist/rfs/msm/adsp $@/readwrite
	$(hide) ln -sf /mnt/vendor/persist/rfs/shared $@/shared
	$(hide) ln -sf /mnt/vendor/persist/hlos_rfs/shared $@/hlos
	$(hide) ln -sf /vendor/firmware_mnt $@/readonly/firmware
	$(hide) ln -sf /vendor/firmware $@/readonly/vendor/firmware

RFS_MSM_CDSP_SYMLINKS := $(TARGET_OUT_VENDOR)/rfs/msm/cdsp/
$(RFS_MSM_CDSP_SYMLINKS): $(LOCAL_INSTALLED_MODULE)
	@echo "Creating RFS MSM CDSP folder structure: $@"
	@rm -rf $@/*
	@mkdir -p $(dir $@)/readonly/vendor
	$(hide) ln -sf /data/vendor/tombstones/rfs/lpass $@/ramdumps
	$(hide) ln -sf /mnt/vendor/persist/rfs/msm/adsp $@/readwrite
	$(hide) ln -sf /mnt/vendor/persist/rfs/shared $@/shared
	$(hide) ln -sf /mnt/vendor/persist/hlos_rfs/shared $@/hlos
	$(hide) ln -sf /vendor/firmware_mnt $@/readonly/firmware
	$(hide) ln -sf /vendor/firmware $@/readonly/vendor/firmware

RFS_MSM_MPSS_SYMLINKS := $(TARGET_OUT_VENDOR)/rfs/msm/mpss/
$(RFS_MSM_MPSS_SYMLINKS): $(LOCAL_INSTALLED_MODULE)
	@echo "Creating RFS MSM MPSS folder structure: $@"
	@rm -rf $@/*
	@mkdir -p $(dir $@)/readonly/vendor
	$(hide) ln -sf /data/vendor/tombstones/rfs/modem $@/ramdumps
	$(hide) ln -sf /data/vendor/radio/modem_config $@/readonly/modem_config
	$(hide) ln -sf /mnt/vendor/persist/rfs/msm/mpss $@/readwrite
	$(hide) ln -sf /mnt/vendor/persist/rfs/shared $@/shared
	$(hide) ln -sf /mnt/vendor/persist/hlos_rfs/shared $@/hlos
	$(hide) ln -sf /vendor/firmware_mnt $@/readonly/firmware
	$(hide) ln -sf /vendor/firmware $@/readonly/vendor/firmware

RFS_MSM_SLPI_SYMLINKS := $(TARGET_OUT_VENDOR)/rfs/msm/slpi/
$(RFS_MSM_SLPI_SYMLINKS): $(LOCAL_INSTALLED_MODULE)
	@echo "Creating RFS MSM SLPI folder structure: $@"
	@rm -rf $@/*
	@mkdir -p $(dir $@)/readonly/vendor
	$(hide) ln -sf /data/vendor/tombstones/rfs/modem $@/ramdumps
	$(hide) ln -sf /mnt/vendor/persist/rfs/msm/slpi $@/readwrite
	$(hide) ln -sf /mnt/vendor/persist/rfs/shared $@/shared
	$(hide) ln -sf /mnt/vendor/persist/hlos_rfs/shared $@/hlos
	$(hide) ln -sf /vendor/firmware_mnt $@/readonly/firmware
	$(hide) ln -sf /vendor/firmware $@/readonly/vendor/firmware

ALL_DEFAULT_INSTALLED_MODULES += $(RFS_APQ_GNSS_SYMLINKS) $(RFS_MDM_ADSP_SYMLINKS) $(RFS_MDM_CDSP_SYMLINKS) $(RFS_MDM_MPSS_SYMLINKS) \
    $(RFS_MDM_SLPI_SYMLINKS) $(RFS_MDM_TN_SYMLINKS) $(RFS_MSM_ADSP_SYMLINKS) $(RFS_MSM_CDSP_SYMLINKS) $(RFS_MSM_MPSS_SYMLINKS) $(RFS_MSM_SLPI_SYMLINKS)

# END RFS MSM


# Create a link for the WCNSS MAC firmware, which ends up as a writable
# version in /data/misc/wifi
# Wifi
BDWLAN_IMAGES := \
    bdwlan.bin bdwlan_ch0.bin bdwlan_ch1.bin

BDWLAN_SYMLINKS := $(addprefix $(TARGET_OUT_VENDOR)/firmware/wlan/qca_cld/,$(notdir $(BDWLAN_IMAGES)))
$(BDWLAN_SYMLINKS): $(LOCAL_INSTALLED_MODULE)
	@echo "BDWLAN firmware link: $@"
	@mkdir -p $(dir $@)
	@rm -rf $@
	$(hide) ln -sf /mnt/vendor/persist-lg/wifi/qcom/$(notdir $(basename $@)_cache.bin) $@

WCNSS_INI_SYMLINK := $(TARGET_OUT_VENDOR)/firmware/wlan/qca_cld/WCNSS_qcom_cfg.ini
$(WCNSS_INI_SYMLINK): $(LOCAL_INSTALLED_MODULE)
	@echo "WCNSS config ini link: $@"
	@mkdir -p $(dir $@)
	@rm -rf $@
	$(hide) ln -sf /vendor/etc/wifi/$(notdir $@) $@

WCNSS_MAC_SYMLINK := $(TARGET_OUT_VENDOR)/firmware/wlan/qca_cld/wlan_mac.bin
$(WCNSS_MAC_SYMLINK): $(LOCAL_INSTALLED_MODULE)
	@echo "WCNSS MAC bin link: $@"
	@mkdir -p $(dir $@)
	@rm -rf $@
	$(hide) ln -sf /mnt/vendor/persist-lg/wifi/$(notdir $@) $@

ALL_DEFAULT_INSTALLED_MODULES += $(WCNSS_INI_SYMLINK) $(WCNSS_MAC_SYMLINK) $(BDWLAN_SYMLINKS)
# END Wifi
endif
