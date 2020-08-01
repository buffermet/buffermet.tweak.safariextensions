INSTALL_TARGET_PROCESSES = SpringBoard

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = SafariExtensions

SafariExtensions_FILES = Tweak.xm SafariExtensions/*.m
SafariExtensions_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/tweak.mk

SUBPROJECTS += safariextensionspreferences
include $(THEOS_MAKE_PATH)/aggregate.mk
