#
# vendor props for joan
#


# Audio
PRODUCT_PROPERTY_OVERRIDES += \
    af.fast_track_multiplier=1 \
    audio.deep_buffer.media=true \
    audio.offload.video=true \
    audio.offload.min.duration.secs=30 \
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
    persist.vendor.lge.audio.nsenabled=ON \
    vendor.lge.fm_gain_control_headset=0.9 \
    vendor.lge.fm_gain_control_speaker=0.7 \
    persist.vendor.audio.speaker.prot.enable=false \
    persist.vendor.lge.3rd.speaker.prot.enable=on \
    persist.vendor.lge.audio.voice.clarity=off \
    persist.vendor.lge.audio.handset_rx_type=DEFAULT \
    persist.spkr.cal.duration=0 \
    persist.product.lge.audio.dual_audio=ON \
    vendor.audio_hal.period_size=480 \
    ro.af.client_heap_size_kbyte=7168 \
    persist.vendor.audio.hw.binder.size_kbyte=1024

# Audio - DAC
PRODUCT_PROPERTY_OVERRIDES += \
    persist.vendor.lge.audio.hifi_adv_support=1 \
    vendor.lge.audio.hifi_rec.normal_gain=0 \
    vendor.lge.audio.hifi_rec.normal_lcf=75 \
    vendor.lge.audio.hifi_rec.normal_lmt=0 \
    vendor.lge.audio.hifi_rec.concert_gain=-140 \
    vendor.lge.audio.hifi_rec.concert_lcf=0 \
    vendor.lge.audio.hifi_rec.concert_lmt=0 \
    vendor.lge.audio.hifi_rec.offset_gain=39 \

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
    persist.vendor.btstack.a2dp_offload_cap=sbc-aptx-aptxhd-aac \
    vendor.bluetooth.soc=cherokee \
    vendor.qcom.bluetooth.soc=cherokee \
    ro.bluetooth.a4wp=false \
    persist.vendor.btstack.enable.splita2dp=false \
    persist.vendor.bt.a2dp_offload_cap=sbc-aptx-aptxhd-aac

# Camera
PRODUCT_PROPERTY_OVERRIDES += \
    persist.camera.camera2=true \
    persist.vendor.camera.expose.aux=1 \
    persist.camera.is_type=3 \
    persist.camera.max.previewfps=60 \
    vidc.enc.dcvs.extra-buff-count=2 \
    persist.vendor.camera.hdr.video=2

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
    ro.vendor.display.cabl=2 \
    ro.sf.lcd_density=480 \
    sdm.perf_hint_window=50 \
    vendor.display.perf_hint_window=50 \
    persist.debug.wfd.enable=0 \
    persist.sys.wfd.virtual=0 \
    persist.hwc.enable_vds=1 \
    vendor.display.enable_default_color_mode=1 \
    vendor.display.disable_prim_rot=1 \
    vendor.gralloc.enable_fb_ubwc=1

# Factory reset partition
PRODUCT_PROPERTY_OVERRIDES += \
    ro.frp.pst=/dev/block/platform/soc/1da4000.ufshc/by-name/frp

# HDR
PRODUCT_PROPERTY_OVERRIDES += \
    ro.vendor.display.hdr.config=/vendor/etc/hdr_tm_config.xml

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
    vendor.mm.enable.qcom_parser=13631487 \
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
    
# QCOM
PRODUCT_PROPERTY_OVERRIDES += \
    persist.vendor.qcomsysd.enabled=1

# QTI
PRODUCT_PROPERTY_OVERRIDES += \
    ro.vendor.gt_library=libqti-gt.so \
    ro.vendor.at_library=libqti-at.so 

# Radio
PRODUCT_PROPERTY_OVERRIDES += \
    persist.vendor.cne.feature=0 \
    persist.vendor.dpm.feature=0 \
    persist.vendor.data.mode=concurrent \
    persist.data.netmgrd.qos.enable=true \
    persist.timed.enable=true \
    persist.radio.VT_CAM_INTERFACE=1 \
    persist.radio.VT_ENABLE=1 \
    persist.radio.VT_HYBRID_ENABLE=1 \
    persist.vendor.radio.apm_sim_not_pwdn=1 \
    persist.vendor.radio.custom_ecc=1 \
    persist.vendor.radio.rat_on=combine \
    persist.vendor.radio.sib16_support=1 \
    persist.vendor.radio.hw_mbn_update=1 \
    persist.vendor.radio.sw_mbn_update=1 \
    persist.vendor.radio.data_con_rprt=true \
    persist.vendor.radio.data_ltd_sys_ind=1 \
    persist.vendor.radio.force_on_dc=true \
    persist.vendor.radio.ignore_dom_time=10 \
    persist.vendor.radio.start_ota_daemon=1 \
    rild.libpath=/system/vendor/lib64/libril-qc-qmi-1.so \
    vendor.rild.libpath=/system/vendor/lib64/libril-qc-qmi-1.so \
    ril.subscription.types=NV,RUIM \
    ro.telephony.default_network=10 \
    ro.vendor.use_data_netmgrd=true \
    telephony.lteOnCdmaDevice=1 \
    DEVICE_PROVISIONED=1

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
    ro.vendor.build.security_patch=2019-07-01

# Sensors
PRODUCT_PROPERTY_OVERRIDES += \
    persist.vendor.debug.sensors.hal=i \
    persist.vendor.sensors.dev_ori=false \
    persist.vendor.lge.sensors.lgpickup=true \
    persist.vendor.lge.sensors.knock_delay=1000 \
    persist.vendor.lge.sensors.pocket_delay=1000 \
    persist.vendor.lge.sensors.wul_delay=3000 \
    persist.vendor.lge.sensors.wul_multilevel=5 \
    persist.vendor.lge.sensors.wul_thresh0=2 \
    persist.vendor.lge.sensors.wul_thresh1=10 \
    persist.vendor.lge.sensors.wul_thresh2=15 \
    persist.vendor.lge.sensors.wul_thresh3=3100 \
    persist.vendor.lge.sensors.wul_thresh4=10000 \
    ro.vendor.sensors.maghalcal=false \
    ro.vendor.sensors.wu=false \
    ro.vendor.sensors.sta_detect=true \
    ro.vendor.sensors.mot_detect=true

# SurfaceFlinger
PRODUCT_DEFAULT_PROPERTY_OVERRIDES += \
    ro.surface_flinger.protected_contents=true \
    ro.surface_flinger.has_wide_color_display=true \
    ro.surface_flinger.has_HDR_display=true \
    ro.surface_flinger.use_color_management=true \
    ro.surface_flinger.wcg_composition_dataspace=143261696 \
    debug.sf.early_phase_offset_ns=1500000 \
    debug.sf.early_app_phase_offset_ns=1500000 \
    debug.sf.early_gl_phase_offset_ns=3000000 \
    debug.sf.early_gl_app_phase_offset_ns=15000000 

# Time daemon
PRODUCT_PROPERTY_OVERRIDES += \
    persist.delta_time.enable=true

# Timeservice
PRODUCT_PROPERTY_OVERRIDES += \
    persist.timed.enable=true

# USB
#PRODUCT_PROPERTY_OVERRIDES += \
#    sys.usb.ffs.aio_compat=1 \
#    persist.sys.usb.config.extra=none

# Voice assistant
PRODUCT_PROPERTY_OVERRIDES += \
    ro.opa.eligible_device=true

# Wifi
PRODUCT_PROPERTY_OVERRIDES += \
    wifi.interface=wlan0

# Waterproof
PRODUCT_PROPERTY_OVERRIDES += \
    ro.product.lge.support.waterproof=true
