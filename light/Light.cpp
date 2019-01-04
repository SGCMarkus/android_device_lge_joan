/*
 * Copyright (C) 2017 The LineageOS Project
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

#define LOG_TAG "LightService"

#include "Light.h"
#include <log/log.h>
#include <android-base/stringprintf.h>

#include <fstream>

namespace android {
namespace hardware {
namespace light {
namespace V2_0 {
namespace implementation {

#define LEDS            "/sys/class/leds/"

#define LCD_LED         LEDS "lcd-backlight/"
#define RED_LED         LEDS "red/"
#define GREEN_LED       LEDS "green/"
#define BLUE_LED        LEDS "blue/"
#define RGB_LED         LEDS "rgb/"

#define BRIGHTNESS      "brightness"
#define MAX_BRIGHTNESS  "max_brightness"
#define DUTY_PCTS       "duty_pcts"
#define START_IDX       "start_idx"
#define PAUSE_LO        "pause_lo"
#define PAUSE_HI        "pause_hi"
#define RAMP_STEP_MS    "ramp_step_ms"
#define RGB_BLINK       "rgb_blink"

/*
 * Write value to path and close file.
 */
template <typename T>
static void set(const std::string& path, const T& value) {
    std::ofstream file(path);
    file << value;
}

template <typename T>
static T get(const std::string& path, const T& def) {
    std::ifstream file(path);
    T result;

    file >> result;
    return file.fail() ? def : result;
}

static int rgbToBrightness(const LightState& state) {
    int color = state.color & 0x00ffffff;
    return ((77 * ((color >> 16) & 0x00ff))
            + (150 * ((color >> 8) & 0x00ff))
            + (29 * (color & 0x00ff))) >> 8;
}

static void handleBacklight(const LightState& state) {
    //uint32_t brightness = state.color & 0xFF;
    int maxBrightness = get(LCD_LED MAX_BRIGHTNESS, -1);
    if (maxBrightness < 0) {
        maxBrightness = 255;
    }
    int sentBrightness = rgbToBrightness(state);
    int brightness = sentBrightness * maxBrightness / 255;

    //LOG(DEBUG) << "Writing backlight brightness " << brightness
    //           << " (orig " << sentBrightness << ")";

    //ALOGE("Backlight brightness: %s, Original: %s", std::to_string(brightness).c_str(), std::to_string(sentBrightness).c_str());
    //ALOGE("Backlight brightness: %s", std::to_string(sentBrightness).c_str());
    set(LCD_LED BRIGHTNESS, brightness);
    //set(LCD_LED BRIGHTNESS, sentBrightness);
}

static std::map<Type, std::function<void(const LightState&)>> lights = {
    {Type::BACKLIGHT, handleBacklight},
};

Light::Light() {}

Return<Status> Light::setLight(Type type, const LightState& state) {
    auto it = lights.find(type);

    if (it == lights.end()) {
        return Status::LIGHT_NOT_SUPPORTED;
    }

    /*
     * Lock global mutex until light state is updated.
     */
    std::lock_guard<std::mutex> lock(globalLock);

    it->second(state);

    return Status::SUCCESS;
}

Return<void> Light::getSupportedTypes(getSupportedTypes_cb _hidl_cb) {
    std::vector<Type> types;

    for (auto const& light : lights) types.push_back(light.first);

    _hidl_cb(types);

    return Void();
}

}  // namespace implementation
}  // namespace V2_0
}  // namespace light
}  // namespace hardware
}  // namespace android
