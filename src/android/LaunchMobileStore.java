package com.cordova.launchstore;

import android.content.Intent;
import android.net.Uri;
import android.util.Log;
import java.net.MalformedURLException;
import java.net.URL;
import org.apache.cordova.CordovaPlugin;
import org.apache.cordova.CallbackContext;

import org.json.JSONArray;
import org.json.JSONException;

/**
 * This class echoes a string called from JavaScript.
 */
public class LaunchMobileStore extends CordovaPlugin {

  @Override public boolean execute(String action, JSONArray args, CallbackContext callbackContext)
      throws JSONException {
    if (action.equals("openMobileAppStore")) {
      final String appPackageName = args.getString(0);
      final String applicationName = args.getString(2);
      if (applicationName != null && appPackageName.length() > 0) {
        try {
          cordova.getActivity()
              .startActivity(new Intent(Intent.ACTION_VIEW,
                  Uri.parse("market://details?id=" + appPackageName)));
        } catch (android.content.ActivityNotFoundException anfe) {
          cordova.getActivity()
              .startActivity(new Intent(Intent.ACTION_VIEW,
                  Uri.parse("https://play.google.com/store/apps/details?id=" + appPackageName)));
        }
      } else if (applicationName != null && applicationName.length() > 0) {
        cordova.getActivity().runOnUiThread(new Runnable() {
          @Override public void run() {
            String webViewUrl = webView.getUrl();

            if (webViewUrl != null) {
              try {
                URL url = new URL(webViewUrl);
                String baseUrl = url.getProtocol() + "://" + url.getHost();

                String buildAppStoreUrl = baseUrl + "/NativeAppBuilder/App?Name=" + applicationName;
                Intent i = new Intent(Intent.ACTION_VIEW);
                i.setData(Uri.parse(buildAppStoreUrl));
                cordova.getActivity().startActivity(i);
              } catch (MalformedURLException e) {
                Log.e("LaunchIntent", e.toString());
              }
            }
          }
        });
      } else {
        callbackContext.error("No valid parameters");
      }
      callbackContext.success();

      return true;
    }
    return false;
  }
}