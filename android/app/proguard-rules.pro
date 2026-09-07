# ============================================================
# Required for flutter_local_notifications (v17.2.4) to work in
# RELEASE / minified builds.
#
# Root cause: the plugin uses Gson internally to persist scheduled
# notifications (so they survive reboots, and so recurring weekly
# class reminders can be matched/restored). Gson relies on generic
# type information at runtime (TypeToken<T>). R8's default
# minification strips that generic info, which is exactly what
# produces:
#
#   PlatformException(error, Missing type parameter., ...
#     at ...FlutterLocalNotificationsPlugin.loadScheduledNotifications
#
# Without these rules, scheduling silently fails in release builds
# even though everything works fine in debug — which is why the
# test notification (no Gson involved) works, but scheduled task/
# class reminders never do.
# ============================================================

# Keep generic signatures so Gson's TypeToken machinery works
-keepattributes Signature
-keepattributes *Annotation*

-dontwarn sun.misc.**
-keep class com.google.gson.stream.** { *; }

# Prevent stripping of interface info Gson relies on for (de)serialization
-keep class * implements com.google.gson.TypeAdapterFactory
-keep class * implements com.google.gson.JsonSerializer
-keep class * implements com.google.gson.JsonDeserializer

# Keep @SerializedName-annotated fields from being renamed/nulled by R8
-keepclassmembers,allowobfuscation class * {
  @com.google.gson.annotations.SerializedName <fields>;
}

# Retain TypeToken's generic signature (needed for R8 3.0+, i.e. any
# reasonably current Android Gradle Plugin)
-keep,allowobfuscation,allowshrinking class com.google.gson.reflect.TypeToken
-keep,allowobfuscation,allowshrinking class * extends com.google.gson.reflect.TypeToken

# Belt-and-suspenders: keep the plugin's own classes, including the
# model classes it serializes with Gson and the receivers Android
# calls directly by name (boot restore, scheduled alarm firing).
-keep class com.dexterous.flutterlocalnotifications.** { *; }
