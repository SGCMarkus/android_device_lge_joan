#!/sbin/sh
#
# Copyright (C) 2020 LineageOS Project
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

PRODUCT_MODEL=`getprop ro.boot.vendor.lge.model.name`

echo "Checking if we are on a H932 (not H932PR). H932 requires specific blobs."

if [ $PRODUCT_MODEL = "LG-H932" ]; then
    echo "H932 detected, copying blobs..."
    mv /system/system/vendor/firmware/H932/* /system/system/vendor/firmware/
    rm -r /system/system/vendor/firmware/H932
else
    echo "Not a H932, remove unwanted blobs"
    rm -r /system/system/vendor/firmware/H932
fi
