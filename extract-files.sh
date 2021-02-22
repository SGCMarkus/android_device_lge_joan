#!/bin/bash
#
# Copyright (C) 2016 The CyanogenMod Project
# Copyright (C) 2017-2020 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

set -e

DEVICE=joan
VENDOR=lge

# Load extract_utils and do some sanity checks
MY_DIR="${BASH_SOURCE%/*}"
if [[ ! -d "$MY_DIR" ]]; then MY_DIR="$PWD"; fi

ANDROID_ROOT="${MY_DIR}/../../.."

HELPER="${ANDROID_ROOT}/tools/extract-utils/extract_utils.sh"
if [ ! -f "$HELPER" ]; then
    echo "Unable to find helper script at $HELPER"
    exit 1
fi
source "$HELPER"

# Default to sanitizing the vendor folder before extraction
CLEAN_VENDOR=true

ONLY_COMMON=
ONLY_TARGET=
KANG=
SECTION=

while [ "${#}" -gt 0 ]; do
    case "${1}" in
        --only-common )
                ONLY_COMMON=true
                ;;
        --only-target )
                ONLY_TARGET=true
                ;;
        -n | --no-cleanup )
                CLEAN_VENDOR=false
                ;;
        -k | --kang )
                KANG="--kang"
                ;;
        -s | --section )
                SECTION="${2}"; shift
                CLEAN_VENDOR=false
                ;;
        * )
                SRC="${1}"
                ;;
    esac
    shift
done

if [ -z "$SRC" ]; then
    SRC=/home/markus/V30/H930_31a/
fi

function blob_fixup() {
    case "${1}" in
    vendor/lib/hw/audio.primary.msm8998.so)
        ${PATCHELF} --add-needed libprocessgroup.so "${2}"
        ;;
    vendor/lib64/hw/audio.primary.msm8998.so)
        ${PATCHELF} --add-needed libprocessgroup.so "${2}"
        ;;
    vendor/lib/hw/camera.msm8998.so)
        sed -i "s/libsensor.so/libtensor.so/g" "${2}"
        sed -i "s/libgui.so/libfui.so/g" "${2}"
        sed -i "s/libui.so/libvi.so/g" "${2}"
        ${PATCHELF} --remove-needed libandroid.so "${2}"
        ;;
    vendor/lib/libmpbase.so)
        ${PATCHELF} --remove-needed libandroid.so "${2}"
        ;;
    vendor/lib/libarcsoft_beauty_picselfie.so)
        ${PATCHELF} --remove-needed libandroid.so "${2}"
        ${PATCHELF} --remove-needed libjnigraphics.so "${2}"
        ;;
    vendor/lib/libfilm_emulation.so)
        ${PATCHELF} --remove-needed libjnigraphics.so "${2}"
        ;;
    vendor/lib/libmmcamera_bokeh.so)
        sed -i "s/libui.so/libvi.so/g" "${2}"
        ;;
    vendor/lib/libkeymaster3device.so)
        sed -i "s/libpuresoftkeymasterdevice.so/libpuresoftleymasterdevice.so/g" "${2}"
        sed -i "s/libkeymaster_portable.so/libleymaster_portable.so/g" "${2}"
        ;;
    vendor/lib64/libkeymaster3device.so)
        sed -i "s/libpuresoftkeymasterdevice.so/libpuresoftleymasterdevice.so/g" "${2}"
        sed -i "s/libkeymaster_portable.so/libleymaster_portable.so/g" "${2}"
        ;;
    esac
}

# Initialize the helper
setup_vendor "${DEVICE}" "${VENDOR}" "${ANDROID_ROOT}" false "${CLEAN_VENDOR}"

extract "${MY_DIR}/proprietary-files.txt" "${SRC}" ${KANG} --section "${SECTION}"

# Do not clean the vendor folder before fetching other blobs
CLEAN_VENDOR=false

# Reinitialize the helper for H930 blobs
echo "Gathering H930 blobs for unified build."
echo "Please provide the path to H930 blobs."
echo "or hit enter to attempt fetching from a connected device, adb mode."
echo "You may run this again if fail or skip."
echo "Without H930 blobs this build will not be unified."
echo -n "Path:"
read SRC


if [ -z "${SRC}" ]; then
    SRC=/home/markus/V30/H930_31a/
fi


setup_vendor "${DEVICE}" "${VENDOR}" "${ANDROID_ROOT}" false "${CLEAN_VENDOR}"


extract "${MY_DIR}/proprietary-files_h930.txt" "${SRC}" ${KANG} --section "${SECTION}"

# Reinitialize the helper for H932 blobs
echo "Gathering H932 blobs for unified build."
echo "Please provide the path to H932 blobs."
echo "or hit enter to attempt fetching from a connected device, adb mode."
echo "You may run this again if fail or skip."
echo "Without H932 blobs this build will not run on T-Mobile H932 devices."
echo -n "Path:"
read SRC


if [ -z "${SRC}" ]; then
    SRC=/home/markus/V30/H930_31a/
fi


setup_vendor "${DEVICE}" "${VENDOR}" "${ANDROID_ROOT}" false "${CLEAN_VENDOR}"


extract "${MY_DIR}/proprietary-files_h932.txt" "${SRC}" ${KANG} --section "${SECTION}"

"${MY_DIR}/setup-makefiles.sh"
