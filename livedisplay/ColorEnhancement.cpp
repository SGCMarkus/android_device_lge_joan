/*
 * Copyright (C) 2019 The LineageOS Project
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

#include "ColorEnhancement.h"

#include <android-base/logging.h>
#include <android-base/file.h>
#include <android-base/strings.h>

#include <fstream>

using android::base::ReadFileToString;
using android::base::Trim;
using android::base::WriteStringToFile;

namespace vendor {
namespace lineage {
namespace livedisplay {
namespace V2_0 {
namespace implementation {

static constexpr const char* kModePath = "/sys/devices/virtual/panel/img_tune/hdr_mode";
static constexpr const char* kDefaultPath = "/data/misc/display/default_hdr_mode";

ColorEnhancement::ColorEnhancement() {
    std::ifstream defaultFile(kDefaultPath);

    defaultFile >> mDefaultColorEnhancement;
    LOG(DEBUG) << "Default file read result " << mDefaultColorEnhancement << " fail " << defaultFile.fail();
    if (defaultFile.fail()) {
        return;
    }

    setEnabled(mDefaultColorEnhancement);
}

// Methods from ::vendor::lineage::livedisplay::V2_0::IColorEnhancement follow.
Return<bool> ColorEnhancement::isEnabled() {
    std::string tmp;
    int32_t contents = 0;

    if (ReadFileToString(kModePath, &tmp)) {
        contents = std::stoi(Trim(tmp));
    }

    return contents > 0;
}

Return<bool> ColorEnhancement::setEnabled(bool enabled) {
    WriteStringToFile(enabled ? "1" : "0", kModePath, true);

    return WriteStringToFile(enabled ? "1" : "0", kModePath, true);
}

}  // namespace implementation
}  // namespace V2_0
}  // namespace livedisplay
}  // namespace lineage
}  // namespace vendor
