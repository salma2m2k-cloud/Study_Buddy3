# Keep Flutter Local Notifications
-keep class com.dexterous.flutterlocalnotifications.** { *; }

# Keep Flutter timezone plugin
-keep class com.aduros.** { *; }
-keep class com.flutter_timezone.** { *; }

# Keep notification receivers
-keep class com.dexterous.flutterlocalnotifications.ScheduledNotificationReceiver { *; }
-keep class com.dexterous.flutterlocalnotifications.ScheduledNotificationBootReceiver { *; }

# Keep notification-related classes and members
-keepclassmembers class com.dexterous.flutterlocalnotifications.** { *; }
