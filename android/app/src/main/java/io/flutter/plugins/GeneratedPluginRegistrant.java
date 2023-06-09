package io.flutter.plugins;

import androidx.annotation.Keep;
import androidx.annotation.NonNull;
import io.flutter.Log;

import io.flutter.embedding.engine.FlutterEngine;

/**
 * Generated file. Do not edit.
 * This file is generated by the Flutter tool based on the
 * plugins that support the Android platform.
 */
@Keep
public final class GeneratedPluginRegistrant {
  private static final String TAG = "GeneratedPluginRegistrant";
  public static void registerWith(@NonNull FlutterEngine flutterEngine) {
    try {
      flutterEngine.getPlugins().add(new one.mixin.desktop.drop.DesktopDropPlugin());
    } catch(Exception e) {
      Log.e(TAG, "Error registering plugin desktop_drop, one.mixin.desktop.drop.DesktopDropPlugin", e);
    }
    try {
      flutterEngine.getPlugins().add(new carnegietechnologies.gallery_saver.GallerySaverPlugin());
    } catch(Exception e) {
      Log.e(TAG, "Error registering plugin gallery_saver, carnegietechnologies.gallery_saver.GallerySaverPlugin", e);
    }
    try {
      flutterEngine.getPlugins().add(new io.flutter.plugins.pathprovider.PathProviderPlugin());
    } catch(Exception e) {
      Log.e(TAG, "Error registering plugin path_provider_android, io.flutter.plugins.pathprovider.PathProviderPlugin", e);
    }
  }
}
