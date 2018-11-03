/*
 * Copyright (C) 2018 The Android Open Source Project
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
#define LOG_TAG "android.hardware.vibrator@1.2-service.joan"

#include <android/hardware/vibrator/1.2/IVibrator.h>
#include <hidl/HidlSupport.h>
#include <hidl/HidlTransportSupport.h>
#include <utils/Errors.h>
#include <utils/StrongPointer.h>

#include "Vibrator.h"
#include "tspdrv.h"

using android::hardware::configureRpcThreadpool;
using android::hardware::joinRpcThreadpool;
using android::hardware::vibrator::V1_2::IVibrator;
using android::hardware::vibrator::V1_2::implementation::Vibrator;
using namespace android;

status_t registerVibratorService() {

    // Open device file as read/write for ioctl and write 
    int file_desc = open(TSPDRV, O_RDWR);
    if(file_desc < 0)
    {
        ALOGE("Failed to open device file: %s", TSPDRV);
        return -1;
    }

    // create default device parameters
    device_parameter dev_param1 { 0, VIBE_KP_CFG_FREQUENCY_PARAM1, 0};
    device_parameter dev_param2 { 0, VIBE_KP_CFG_FREQUENCY_PARAM2, 0};
    device_parameter dev_param3 { 0, VIBE_KP_CFG_FREQUENCY_PARAM3, 0};
    device_parameter dev_param4 { 0, VIBE_KP_CFG_FREQUENCY_PARAM4, 400};
    device_parameter dev_param5 { 0, VIBE_KP_CFG_FREQUENCY_PARAM5, 13435};
    device_parameter dev_param6 { 0, VIBE_KP_CFG_FREQUENCY_PARAM6, 0};
    device_parameter dev_param_update_rate {0, VIBE_KP_CFG_UPDATE_RATE_MS, 5};

    // Set magic number for vibration driver, wont allow us to write data without!
    int ret = ioctl(file_desc, TSPDRV_SET_MAGIC_NUMBER, TSPDRV_MAGIC_NUMBER);
    if(ret != 0)
    {
        ALOGE("Failed to set magic number");
        return -ret;
    }
    
    // Set default device parameter 1
    ret = ioctl(file_desc, TSPDRV_SET_DEVICE_PARAMETER, &dev_param1);
    if(ret != 0)
    {
        ALOGE("Failed to set device parameter 1");
        return -ret;
    }

    // Set default device parameter 2
    ret = ioctl(file_desc, TSPDRV_SET_DEVICE_PARAMETER, &dev_param2);
    if(ret != 0)
    {
        ALOGE("Failed to set device parameter 2");
        return -ret;
    }

    // Set default device parameter 3
    ret = ioctl(file_desc, TSPDRV_SET_DEVICE_PARAMETER, &dev_param3);
    if(ret != 0)
    {
        ALOGE("Failed to set device parameter 3");
        return -ret;
    }

    // Set default device parameter 4
    ret = ioctl(file_desc, TSPDRV_SET_DEVICE_PARAMETER, &dev_param4);
    if(ret != 0)
    {
        ALOGE("Failed to set device parameter 4");
        return -ret;
    }

    // Set default device parameter 5
    ret = ioctl(file_desc, TSPDRV_SET_DEVICE_PARAMETER, &dev_param5);
    if(ret != 0)
    {
        ALOGE("Failed to set device parameter 5");
        return -ret;
    }

    // Set default device parameter 6
    ret = ioctl(file_desc, TSPDRV_SET_DEVICE_PARAMETER, &dev_param6);
    if(ret != 0)
    {
        ALOGE("Failed to set device parameter 6");
        return -ret;
    }

    // Set default device parameter update rate
    ret = ioctl(file_desc, TSPDRV_SET_DEVICE_PARAMETER, &dev_param_update_rate);
    if(ret != 0)
    {
        ALOGE("Failed to set device parameter update rate");
        return -ret;
    }

    // Get number of actuators the device has
    ret = ioctl(file_desc, TSPDRV_GET_NUM_ACTUATORS, 0);
    if(ret == 0)
    {
        ALOGE("No actuators found!");
        return -2;
    }

    sp<IVibrator> vibrator = new Vibrator(file_desc, ret);

    return vibrator->registerAsService();
}

int main() {
    configureRpcThreadpool(1, true);
    status_t status = registerVibratorService();

    if (status != OK) {
        return status;
    }

    joinRpcThreadpool();
}
