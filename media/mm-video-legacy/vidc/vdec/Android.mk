ifneq ($(BUILD_TINY_ANDROID),true)

ROOT_DIR := $(call my-dir)

include $(CLEAR_VARS)
LOCAL_PATH:= $(ROOT_DIR)

# ---------------------------------------------------------------------------------
# 				Common definitons
# ---------------------------------------------------------------------------------

libOmxVdec-def += -D__align=__alignx
libOmxVdec-def += -Dinline=__inline
libOmxVdec-def += -DIMAGE_APPS_PROC
libOmxVdec-def += -D_ANDROID_
libOmxVdec-def += -DCDECL
libOmxVdec-def += -DT_ARM
libOmxVdec-def += -DNO_ARM_CLZ
libOmxVdec-def += -UENABLE_DEBUG_LOW
libOmxVdec-def += -DENABLE_DEBUG_HIGH
libOmxVdec-def += -DENABLE_DEBUG_ERROR
libOmxVdec-def += -UINPUT_BUFFER_LOG
libOmxVdec-def += -UOUTPUT_BUFFER_LOG
ifeq ($(TARGET_BOARD_PLATFORM),msm8660)
libOmxVdec-def += -DMAX_RES_1080P
libOmxVdec-def += -DPROCESS_EXTRADATA_IN_OUTPUT_PORT
libOmxVdec-def += -DTEST_TS_FROM_SEI
endif
ifeq ($(TARGET_BOARD_PLATFORM),msm8960)
libOmxVdec-def += -DMAX_RES_1080P
libOmxVdec-def += -DMAX_RES_1080P_EBI
libOmxVdec-def += -DPROCESS_EXTRADATA_IN_OUTPUT_PORT
endif
ifeq ($(TARGET_BOARD_PLATFORM),msm8974)
libOmxVdec-def += -DMAX_RES_1080P
libOmxVdec-def += -DMAX_RES_1080P_EBI
libOmxVdec-def += -DPROCESS_EXTRADATA_IN_OUTPUT_PORT
libOmxVdec-def += -D_COPPER_
endif

libOmxVdec-def += -D_ANDROID_ICS_

#ifeq ($(TARGET_USES_ION),true)
libOmxVdec-def += -DUSE_ION
#endif

# ---------------------------------------------------------------------------------
# 			Make the Shared library (libOmxVdec)
# ---------------------------------------------------------------------------------

include $(CLEAR_VARS)
LOCAL_PATH:= $(ROOT_DIR)

libmm-vdec-inc          := bionic/libc/include
libmm-vdec-inc          += bionic/libstdc++/include
libmm-vdec-inc          += $(LOCAL_PATH)/inc
libmm-vdec-inc          += $(OMX_VIDEO_PATH)/vidc/common/inc
libmm-vdec-inc          += hardware/qcom/media/mm-core/inc
#DRM include - Interface which loads the DRM library
libmm-vdec-inc	        += $(OMX_VIDEO_PATH)/DivxDrmDecrypt/inc

libmm-vdec-inc          += device/sony/hikari/display/libgralloc

libmm-vdec-inc          += frameworks/native/include/media/openmax
libmm-vdec-inc          += frameworks/native/include/media/hardware
libmm-vdec-inc          += device/sony/hikari/media/libc2dcolorconvert

libmm-vdec-inc          += device/sony/hikari/display/libcopybit
libmm-vdec-inc          += frameworks/av/include/media/stagefright

libmm-vdec-inc          += device/sony/hikari/display/libqservice
libmm-vdec-inc          += device/sony/hikari/display/libqdutils


LOCAL_MODULE                    := libOmxVdec
LOCAL_MODULE_TAGS               := optional
LOCAL_CFLAGS                    := $(libOmxVdec-def)
LOCAL_C_INCLUDES                += $(libmm-vdec-inc)

LOCAL_PRELINK_MODULE    := false
LOCAL_SHARED_LIBRARIES  := liblog libutils libbinder libcutils libdl

LOCAL_SHARED_LIBRARIES  += libdivxdrmdecrypt
LOCAL_SHARED_LIBRARIES += libqservice
LOCAL_SHARED_LIBRARIES += libqdMetaData

LOCAL_SRC_FILES         := src/frameparser.cpp
LOCAL_SRC_FILES         += src/h264_utils.cpp
LOCAL_SRC_FILES         += src/ts_parser.cpp
LOCAL_SRC_FILES         += src/mp4_utils.cpp
LOCAL_SRC_FILES         += src/omx_vdec.cpp
LOCAL_SRC_FILES         += ../common/src/extra_data_handler.cpp
LOCAL_SRC_FILES         += ../common/src/vidc_color_converter.cpp

include $(BUILD_SHARED_LIBRARY)

endif #BUILD_TINY_ANDROID

# ---------------------------------------------------------------------------------
#                END
# ---------------------------------------------------------------------------------
