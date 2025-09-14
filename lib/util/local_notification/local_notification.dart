import 'dart:math';

import 'package:alarm/model/alarm_model/alarm_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_all.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:flutter_timezone/flutter_timezone.dart';

class LocalNotification {
  // <========== Initialize Local  Notification  ==========>
  final FlutterLocalNotificationsPlugin notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    initializeTimeZones();
    final currentTimezone = await FlutterTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(currentTimezone));

    const androidSettings = AndroidInitializationSettings(
      '@mipmap/ic_launcher',
    );
    const DarwinInitializationSettings iosSettings =
        DarwinInitializationSettings();

    const InitializationSettings initializationSettings =
        InitializationSettings(android: androidSettings, iOS: iosSettings);

    await notificationsPlugin.initialize(initializationSettings);

    //Android 13+ Notification Permision Request
    await notificationsPlugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.requestNotificationsPermission();

    // iOS Notification Permision Request
    await notificationsPlugin
        .resolvePlatformSpecificImplementation<
          IOSFlutterLocalNotificationsPlugin
        >()
        ?.requestPermissions(alert: true, badge: true, sound: true);
  }

  // <========== Show Instant Notification  ==========>
  Future<void> showInstantNotification({
    required int id,
    required String title,
    required String body,
  }) async {
    await notificationsPlugin.show(
      id,
      title,
      body,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'instant_notification_channel_id',
          'Instant Notifications',
          channelDescription: 'Instant notification channel',
          importance: Importance.max,
          priority: Priority.high,
        ), // AndroidNotificationDetails
        iOS: DarwinNotificationDetails(),
      ), // NotificationDetails
    );
  }

  //<========== Schedule Notification ==========>
  Future<void> scheduleReminder({required List<AlarmModel> alarm}) async {
    for (var alarms in alarm) {
      if (!alarms.isActive) continue;

      int id = Random().nextInt(1 << 31);

      //get local time
      final now = tz.TZDateTime.now(tz.local);

      //get alarm time
      final scheduledDate = tz.TZDateTime.from(alarms.dateTime, tz.local);

      await notificationsPlugin.zonedSchedule(
        id,
        "${alarms.dateTime}",
        "Alarm Ringing...",
        scheduledDate,
        const NotificationDetails(
          android: AndroidNotificationDetails(
            'daily_reminder_channel_id', // A unique ID to group notifications together.
            'Daily Reminders', // A human-readable name shown to users in their notification settings.
            channelDescription: 'Reminder to complete daily habits',
            importance: Importance.max,
            priority: Priority.high,
          ), // AndroidNotificationDetails
          iOS: DarwinNotificationDetails(),
        ), // NotificationDetails
        androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
        matchDateTimeComponents:
            DateTimeComponents.dateAndTime, // or dateAndTime
      );
      if (kDebugMode) {
        print("Alarm Active - loacal time $now");
      }
    }
  }
}
