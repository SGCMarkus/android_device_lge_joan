#
# vendor props for joan
#


# Audio
PRODUCT_PROPERTY_OVERRIDES += \
    af.fast_track_multiplier=1 \
    audio.deep_buffer.media=true \
    audio.offload.video=true \
    persist.vendor.audio.fluence.speaker=true \
    persist.vendor.audio.fluence.voicecall=true \
    persist.vendor.audio.fluence.voicerec=false \
    persist.vendor.audio.ras.enabled=false \
    ro.vendor.audio.sdk.fluencetype=fluencepro \
    ro.vendor.audio.sdk.ssr=false \
    vendor.audio_hal.period_size=192 \
    vendor.audio.dolby.ds2.enabled=false \
    vendor.audio.dolby.ds2.hardbypass=false \
    vendor.audio.flac.sw.decoder.24bit=true \
    vendor.audio.hw.aac.encoder=true \
    vendor.audio.noisy.broadcast.delay=600 \
    vendor.audio.offload.buffer.size.kb=32 \
    vendor.audio.offload.gapless.enabled=true \
    vendor.audio.offload.multiaac.enable=true \
    vendor.audio.offload.multiple.enabled=false \
    audio.offload.24bit.enable=1 \
    vendor.audio.offload.passthrough=false \
    vendor.audio.offload.pstimeout.secs=3 \
    vendor.audio.offload.track.enable=true \
    vendor.audio.parser.ip.buffer.size=262144 \
    vendor.audio.safx.pbe.enabled=true \
    vendor.audio.tunnel.encode=false \
    vendor.audio.use.sw.alac.decoder=true \
    vendor.audio.use.sw.ape.decoder=true \
    vendor.fm.a2dp.conc.disabled=true \
    vendor.voice.path.for.pcm.voip=true \
    ro.config.vc_call_vol_steps=7 \
    ro.config.media_vol_steps=25 \
    persist.audio.nsenabled=ON \
    lge.fm_gain_control_headset=0.9 \
    lge.fm_gain_control_speaker=0.7 \
    persist.3rd.speaker.prot.enable=on \
    audio.offload.gapless.enabled=false \
    persist.audio.voice.clarity=off \
    persist.audio.handset_rx_type=DEFAULT \
    persist.spkr.cal.duration=0 \
    persist.audio.dual_audio=ON \
    vendor.audio_hal.period_size=480

# Audio - DAC
PRODUCT_PROPERTY_OVERRIDES += \
    persist.audio.hifi_adv_support=1 \
    audio.hifi_rec.normal_gain=0 \
    audio.hifi_rec.normal_lcf=75 \
    audio.hifi_rec.normal_lmt=0 \
    audio.hifi_rec.concert_gain=-140 \
    audio.hifi_rec.concert_lcf=0 \
    audio.hifi_rec.concert_lmt=0 \
    audio.hifi_rec.offset_gain=39 \

# Battery
PRODUCT_PROPERTY_OVERRIDES += \
    ro.cutoff_voltage_mv=3400

# Bluetooth
PRODUCT_PROPERTY_OVERRIDES += \
    bluetooth.chip.vendor=qcom \
    persist.service.avrcp.browsing=1 \
    persist.service.bdroid.a2dp_con=0 \
    persist.service.bdroid.scms_t=0 \
    persist.bt.max.hs.connections=2 \
    bt.max.hfpclient.connections=1 \
    persist.bt.a2dp.aac_disable=true \
    persist.vendor.bt.a2dp_offload_cap=sbc-aptx-aptxhd-aac \
    vendor.qcom.bluetooth.soc=cherokee \
    qcom.bluetooth.soc=cherokee \
    ro.bluetooth.a4wp=false

# Camera
PRODUCT_PROPERTY_OVERRIDES += \
    persist.camera.camera2=true \
    persist.camera.expose.aux=1 \
    persist.camera.is_type=3 \
    persist.camera.max.previewfps=60 \
    vidc.enc.dcvs.extra-buff-count=2 \
    persist.camera.hdr.video=2

# Core control
PRODUCT_PROPERTY_OVERRIDES += \
    ro.vendor.qti.core_ctl_min_cpu=2 \
    ro.vendor.qti.core_ctl_max_cpu=4

# Display
PRODUCT_PROPERTY_OVERRIDES += \
    debug.sf.hw=1 \
    dev.pm.dyn_samplingrate=1 \
    sdm.debug.disable_partial_split=1 \
    ro.opengles.version=196610 \
    ro.qualcomm.cabl=2 \
    ro.sf.lcd_density=480 \
    sdm.perf_hint_window=50 \
    persist.debug.wfd.enable=1 \
    persist.sys.wfd.virtual=0 \
    persist.hwc.enable_vds=1

# Factory reset partition
PRODUCT_PROPERTY_OVERRIDES += \
    ro.frp.pst=/dev/block/platform/soc/1da4000.ufshc/by-name/frp

# HDR
PRODUCT_PROPERTY_OVERRIDES += \
    ro.qcom.hdr.config=/system/vendor/etc/hdr_tm_config.xml

# Media
PRODUCT_PROPERTY_OVERRIDES += \
    media.stagefright.enable-player=true \
    media.stagefright.enable-http=true \
    media.stagefright.enable-aac=true \
    media.stagefright.enable-qcp=true \
    media.stagefright.enable-scan=true \
    mmp.enable.3g2=true \
    media.aac_51_output_enabled=true \
    mm.enable.smoothstreaming=true \
    mm.enable.qcom_parser=13631487 \
    persist.mm.enable.prefetch=true

# NFC
PRODUCT_PROPERTY_OVERRIDES += \
    persist.nfc.smartcard.config=SIM1,eSE1 \
    ro.nfc.port=I2C

# Perf
PRODUCT_PROPERTY_OVERRIDES += \
    ro.vendor.extension_library=libqti-perfd-client.so \
    ro.sys.fw.bg_apps_limit=48 \
    sched.colocate.enable=1 \
    sys.games.gt.prof=1
    
# QTI
PRODUCT_PROPERTY_OVERRIDES += \
    ro.vendor.gt_library=libqti-gt.so \
    ro.vendor.at_library=libqti-at.so 

# Radio
PRODUCT_PROPERTY_OVERRIDES += \
    persist.cne.feature=1 \
    persist.dpm.feature=0 \
    persist.data.df.dev_name=rmnet_usb0 \
    persist.data.df.iwlan_mux=9 \
    persist.data.iwlan.enable=true \
    persist.data.mode=concurrent \
    persist.data.netmgrd.qos.enable=true \
    persist.radio.VT_CAM_INTERFACE=2 \
    persist.radio.VT_ENABLE=1 \
    persist.radio.VT_HYBRID_ENABLE=1 \
    persist.radio.apm_sim_not_pwdn=1 \
    persist.vendor.radio.custom_ecc=1 \
    persist.radio.data_con_rprt=true \
    persist.vendor.radio.rat_on=combine \
    persist.vendor.radio.sib16_support=1 \
    persist.rmnet.data.enable=true \
    rild.libpath=/system/vendor/lib64/libril-qc-qmi-1.so \
    ril.subscription.types=NV,RUIM \
    ro.telephony.default_network=10 \
    ro.use_data_netmgrd=true \
    telephony.lteOnCdmaDevice=1

# RmNet Data
PRODUCT_PROPERTY_OVERRIDES += \
    persist.rmnet.data.enable=true \
    persist.data.wda.enable=true \
    persist.data.df.dl_mode=5 \
    persist.data.df.ul_mode=5 \
    persist.data.df.agg.dl_pkt=10 \
    persist.data.df.agg.dl_size=4096 \
    persist.data.df.mux_count=8 \
    persist.data.df.iwlan_mux=9 \
    persist.data.df.dev_name=rmnet_usb0

# Security Patch Level
PRODUCT_PROPERTY_OVERRIDES += \
    ro.vendor.build.security_patch=2019-01-01

# Sensors
PRODUCT_PROPERTY_OVERRIDES += \
    ro.qti.sensors.dev_ori=true \
    ro.qti.sensors.dpc=true \
    ro.qti.sensors.pmd=true \
    ro.qti.sensors.mot_detect=true \
    ro.qti.sensors.multishake=true \
    ro.qti.sensors.sta_detect=true \
    persist.sensors.pocket_delay=1000 \
    persist.sensors.knock_delay=1000 \
    persist.sensors.wul_multilevel=5 \
    persist.sensors.wul_thresh0=2 \
    persist.sensors.wul_thresh1=10 \
    persist.sensors.wul_thresh2=15 \
    persist.sensors.wul_thresh3=3100 \
    persist.sensors.wul_thresh4=10000 \
    persist.sensors.wul_delay=3000 \
    persist.sensors.onhand.en=0 \
    ro.vendor.sensors.maghalcal=false \
    ro.vendor.sensors.wu=false

# Time daemon
PRODUCT_PROPERTY_OVERRIDES += \
    persist.delta_time.enable=true

# Timeservice
PRODUCT_PROPERTY_OVERRIDES += \
    persist.timed.enable=true

# USB
PRODUCT_PROPERTY_OVERRIDES += \
    sys.usb.ffs.aio_compat=1 \
    persist.sys.usb.config.extra=none

# Voice assistant
PRODUCT_PROPERTY_OVERRIDES += \
    ro.opa.eligible_device=true

# Wifi
PRODUCT_PROPERTY_OVERRIDES += \
    wifi.interface=wlan0

# Waterproof
PRODUCT_PROPERTY_OVERRIDES += \
    ro.support.waterproof=true
