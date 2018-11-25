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

#define LOG_TAG "VibratorService"

#include <log/log.h>

#include <hardware/hardware.h>
#include <hardware/vibrator.h>
#include <cutils/properties.h>

#include "Vibrator.h"
#include "tspdrv.h"

#include <cinttypes>
#include <cmath>
#include <iostream>
#include <unistd.h>
#include <fcntl.h>
#include <sys/ioctl.h>


namespace android {
namespace hardware {
namespace vibrator {
namespace V1_2 {
namespace implementation {

// How many buffer entries needed per ms
static constexpr double BUFFER_ENTRIES_PER_MS = 8.21;

// Sine amplitude for buffer values
static constexpr uint8_t DEFAULT_AMPLITUDE = 127;

// Output buffer size (immvibed uses 40 and not size of VIBE_OUTPUT_SAMPLE_SIZE)
static constexpr int32_t OUTPUT_BUFFER_SIZE = 40;

// Click effect in ms
static constexpr int32_t WAVEFORM_CLICK_EFFECT_MS = 6;

// Tick effect in ms
static constexpr int32_t WAVEFORM_TICK_EFFECT_MS = 2;

// Double click effect in ms
static constexpr uint32_t WAVEFORM_DOUBLE_CLICK_EFFECT_MS = 135;

// Heavy click effect in ms
static constexpr uint32_t WAVEFORM_HEAVY_CLICK_EFFECT_MS = 8;

using Status = ::android::hardware::vibrator::V1_0::Status;
using EffectStrength = ::android::hardware::vibrator::V1_0::EffectStrength;

Vibrator::Vibrator(int32_t file_desc, int32_t numActuators) {

    // Initialize default values for haptic motor
    mFile_desc = file_desc;
    mNumActuators = numActuators;

    mCurrentAmplitude = DEFAULT_AMPLITUDE;

    mClickDuration = property_get_int32("ro.vibrator.hal.click.duration", WAVEFORM_CLICK_EFFECT_MS);
    mTickDuration = property_get_int32("ro.vibrator.hal.tick.duration", WAVEFORM_TICK_EFFECT_MS);
    mHeavyClickDuration = property_get_int32(
        "ro.vibrator.hal.heavyclick.duration", WAVEFORM_HEAVY_CLICK_EFFECT_MS);

}

Return<Status> Vibrator::on(uint32_t timeoutMs, uint8_t amplitude) {
   
    // Calculate needed buffer entries
    int32_t bufferSize = (int32_t) round(BUFFER_ENTRIES_PER_MS * timeoutMs); 
    VibeUInt8 fullBuffer[bufferSize];
    
    // turn previous vibrations off
    off();  

    for(int32_t i = 0; i < bufferSize; i++)
    {
        // The vibration is a sine curve, the negative parts are 255 + negative value
        fullBuffer[i] = (VibeUInt8) (amplitude * sin(i/BUFFER_ENTRIES_PER_MS));
    }
    
    // Amount of buffer arrays with size of OUTPUT_BUFFER_SIZE
    int32_t numBuffers = (int32_t) ceil((double)bufferSize / (double)OUTPUT_BUFFER_SIZE);
    VibeUInt8 outputBuffers[numBuffers][OUTPUT_BUFFER_SIZE];
    memset(outputBuffers, 0, sizeof(outputBuffers));  // zero the array before we fill it with values
    
    for(int32_t i = 0; i < bufferSize; i++)
    {
        // split fullBuffer into multiple smaller buffers with size OUTPUT_BUFFER_SIZE
        outputBuffers[i/OUTPUT_BUFFER_SIZE][i%OUTPUT_BUFFER_SIZE] = fullBuffer[i];
    }
    
    
    for(int32_t i = 0; i < mNumActuators; i++)
    {
        for(int32_t j = 0; j < numBuffers; j++)
        {
            char output[OUTPUT_BUFFER_SIZE + SPI_HEADER_SIZE];
            memset(output, 0, sizeof(output));
            output[0] = i;  // first byte is actuator index
            output[1] = 8;  // per definition has to be 8
            output[2] = OUTPUT_BUFFER_SIZE; // size of the following output buffer
            for(int32_t k = 3; k < OUTPUT_BUFFER_SIZE+3; k++)
            {
                output[k] = outputBuffers[j][k-3];
            }
            // write the buffer to the device
            write(mFile_desc, output, sizeof(output));
            if((j+1) % 4 == 0)
            {
                // every 4 buffers, but not the first if theres only 1, we send an ENABLE_AMP signal
                int32_t ret = ioctl(mFile_desc, TSPDRV_ENABLE_AMP, i);
                if(ret != 0)
                {
                    ALOGE("Failed to activate Actuator with index %d", i);
                    return Status::UNKNOWN_ERROR;
                }
            }
        }
    }

    return Status::OK;
}


// Methods from ::android::hardware::vibrator::V1_2::IVibrator follow.
Return<Status> Vibrator::on(uint32_t timeoutMs) {
    return on(timeoutMs, DEFAULT_AMPLITUDE);
}

Return<Status> Vibrator::off()  {

    for(int32_t i = 0; i < mNumActuators; i++)
    {
        int32_t ret = ioctl(mFile_desc, TSPDRV_DISABLE_AMP, i);
        if(ret != 0)
        {
            ALOGE("Failed to deactivate Actuator with index %d", i);
            return Status::UNKNOWN_ERROR;
        }
    }
    
    return Status::OK;
}

Return<bool> Vibrator::supportsAmplitudeControl()  {
    //return (mRtpInput ? true : false);
    return false;
}

Return<Status> Vibrator::setAmplitude(uint8_t amplitude) {
    
    if (amplitude == 0) {
        return Status::BAD_VALUE;
    }

    mCurrentAmplitude = amplitude;

    return Status::OK;
}

static uint8_t convertEffectStrength(EffectStrength strength) {
    uint8_t amplitude;

    switch (strength) {
    case EffectStrength::LIGHT:
        amplitude = DEFAULT_AMPLITUDE / 2;
        break;
    case EffectStrength::MEDIUM:
    case EffectStrength::STRONG:
        amplitude = DEFAULT_AMPLITUDE;
        break;
    }

    return amplitude;
}

Return<void> Vibrator::perform(V1_0::Effect effect, EffectStrength strength, perform_cb _hidl_cb) {
    return performEffect(static_cast<Effect>(effect), strength, _hidl_cb);
}

Return<void> Vibrator::perform_1_1(V1_1::Effect_1_1 effect, EffectStrength strength,
        perform_cb _hidl_cb) {
    return performEffect(static_cast<Effect>(effect), strength, _hidl_cb);
}

Return<void> Vibrator::perform_1_2(Effect effect, EffectStrength strength, perform_cb _hidl_cb) {
    return performEffect(static_cast<Effect>(effect), strength, _hidl_cb);
}

Return<void> Vibrator::performEffect(Effect effect, EffectStrength strength, perform_cb _hidl_cb) {
    Status status = Status::OK;
    uint32_t timeMS;

    switch (effect) {
    case Effect::CLICK:
        timeMS = mClickDuration;
        break;
    case Effect::DOUBLE_CLICK:
        timeMS = WAVEFORM_DOUBLE_CLICK_EFFECT_MS;
        break;
    case Effect::TICK:
        timeMS = mTickDuration;
        break;
    case Effect::HEAVY_CLICK:
        timeMS = mHeavyClickDuration;
        break;
    default:
        _hidl_cb(Status::UNSUPPORTED_OPERATION, 0);
        return Void();
    }
    
    on(timeMS, convertEffectStrength(strength));
    _hidl_cb(status, timeMS);
    return Void();
}


} // namespace implementation
}  // namespace V1_2
}  // namespace vibrator
}  // namespace hardware
}  // namespace android
