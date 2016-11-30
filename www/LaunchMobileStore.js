var exec = require('cordova/exec');

exports.openMobileAppStore = function(packageName, appIdApple, urlInternalAppStore, success, error) {
    exec(success, error, "LaunchMobileStore", "openMobileAppStore", [packageName, appIdApple, urlInternalAppStore]);
};
