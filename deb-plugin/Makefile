TARGET = iphone:clang:latest:14.0
ARCHS = arm64 arm64e
THEOS_PACKAGE_SCHEME = roothide

DEBUG = 0
FINALPACKAGE = 1
INSTALL_TARGET_PROCESSES = SpringBoard

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = llt
Llt_FILES = Tweak.xm

include $(THEOS_MAKE_PATH)/tweak.mk
