ifeq ($(RELEASE),1)
	FINALPACKAGE = 1
	STRIP = 1
endif

ifeq ($(ROOTLESS),1)
	THEOS_PACKAGE_SCHEME=rootless
endif
ifeq ($(ROOTHIDE),1)
	THEOS_PACKAGE_SCHEME=roothide
endif


THEOS_DEVICE_IP = 192.168.11.20

ARCHS := arm64 # arm64e

TARGET := iphone:clang:latest:14.0 # 13.0

GO_EASY_ON_ME = 1

# SDK_PATH = $(THEOS)/sdks/iPhoneOS14.5.sdk/
SDK_PATH = $(THEOS)/sdks/iPhoneOS16.5.sdk/
SYSROOT = $(SDK_PATH)

INSTALL_TARGET_PROCESSES = SpringBoard

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = K2gecamen
K2gecamen_FILES = $(shell find source -name '*.xm' -o -name '*.xmi' -o -name '*.m' -o -name '*.c')
K2gecamen_CFLAGS = -Wno-deprecated-declarations -Wno-unused-function
K2gecamen_FRAMEWORKS = UIKit Foundation CoreGraphics AVFoundation AssetsLibrary QuartzCore AudioToolbox
K2gecamen_PRIVATE_FRAMEWORKS = PhotoLibrary CameraKit

include $(THEOS_MAKE_PATH)/tweak.mk
# include $(THEOS_MAKE_PATH)/bundle.mk
include $(THEOS_MAKE_PATH)/aggregate.mk

after-install::
	install.exec "killall -9 SpringBoard"
