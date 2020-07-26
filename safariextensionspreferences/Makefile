include $(THEOS)/makefiles/common.mk

BUNDLE_NAME = SafariExtensionsPreferences

SafariExtensionsPreferences_FILES = SEPRootListController.m
SafariExtensionsPreferences_INSTALL_PATH = /Library/PreferenceBundles
SafariExtensionsPreferences_FRAMEWORKS = UIKit
SafariExtensionsPreferences_PRIVATE_FRAMEWORKS = Preferences
SafariExtensionsPreferences_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/bundle.mk

internal-stage::
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences$(ECHO_END)
	$(ECHO_NOTHING)cp entry.plist $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/SafariExtensionsPreferences.plist$(ECHO_END)
