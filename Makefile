FINALPACKAGE = 1
TARGET := iphone:clang:latest:11.0
ARCHS = arm64 arm64e
INSTALL_TARGET_PROCESSES = SpringBoard

include $(THEOS)/makefiles/common.mk

BUNDLE_NAME = CCVibrate
CCVibrate_BUNDLE_EXTENSION = bundle
CCVibrate_FILES = CCVibrate.m
CCVibrate_CFLAGS = -fobjc-arc
CCVibrate_PRIVATE_FRAMEWORKS = ControlCenterUIKit
CCVibrate_INSTALL_PATH = /Library/ControlCenter/Bundles/

include $(THEOS_MAKE_PATH)/bundle.mk
