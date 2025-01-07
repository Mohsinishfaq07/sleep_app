import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:sleeping_app/screens/reminders/set_reminders.dart';

import 'package:timezone/data/latest.dart ' as timeZone;
import 'package:timezone/timezone.dart' as timeZone;
import 'dart:developer' as dev;

import 'package:permission_handler/permission_handler.dart';
import 'package:timezone/timezone.dart';

Future<void> onDidReceiveNotificationResponse(
    NotificationResponse response) async {
  final String? payload = response.payload;
  dev.log('Notification tapped with payload: $payload');
  // Handle the tap event based on the payload
  // You can add logic here to navigate to a specific screen or perform an action
}

// Handle the notification when tapped (background)
Future<void> onDidReceiveBackgroundNotificationResponse(
    NotificationResponse response) async {
  final String? payload = response.payload;
  dev.log('Background notification tapped with payload: $payload');
  // Handle the tap event when the app is in the background
}

class NotificationService {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  // Initialize notifications and configure the settings
  initNotification() async {
    final AndroidInitializationSettings androidInitializationSettings =
        AndroidInitializationSettings('mipmap/ic_launcher');
    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: androidInitializationSettings,
    );

    // Initialize the plugin and provide the notification response callbacks
    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse:
          onDidReceiveNotificationResponse, // Handle notification tap (foreground or background)
      onDidReceiveBackgroundNotificationResponse:
          onDidReceiveBackgroundNotificationResponse, // Handle notification in background
    );
    timeZone.initializeTimeZones();
  }

  // Request iOS notification permissions
  void requestIOSPermission() {
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
  }

  // Display a notification immediately
  displayNotification({required String title, required String content}) async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'channelId', 'channelName',
        importance: Importance.max, priority: Priority.high);

    var platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
    );
    flutterLocalNotificationsPlugin.show(
        0, title, content, platformChannelSpecifics,
        payload: 'Default_Sound');
  }

  // Schedule a notification at a specific time
  scheduledNotification({
    required TZDateTime scheduledTime,
    required int id,
    required String title,
    required String content,
  }) async {
    try {
      final now = DateTime.now();

      dev.log('Current time: $now');

      // Check if the scheduled time is in the future
      // if (scheduledTime.isBefore(timeZone.TZDateTime.now(timeZone.local))) {
      //   dev.log('Scheduled time is in the past. Please use a future time.');
      //   return;
      // }

      await flutterLocalNotificationsPlugin.zonedSchedule(
        id,
        title,
        content,
        scheduledTime,
        const NotificationDetails(
          android: AndroidNotificationDetails('channelId', 'channelName',
              importance: Importance.max, priority: Priority.high),
        ),
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.dateAndTime,
        payload: '$id',
        androidAllowWhileIdle:
            true, // Allow notification to show even when device is idle
      );

      dev.log('Notification scheduled for: $scheduledTime');
    } catch (e) {
      dev.log(
          'Error scheduling notification in main function: ${e.toString()}');
    }
  }
  // matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime,

  Future<void> cancelReminder(int reminderId) async {
    try {
      await flutterLocalNotificationsPlugin.cancel(reminderId);
      Get.log('Reminder with ID $reminderId canceled successfully.');
    } catch (e) {
      Get.log('Error canceling reminder with ID $reminderId: ${e.toString()}');
    }
  }

  Future<void> reEnableReminder(ReminderModel goal) async {
    try {
      await scheduledNotification(
        scheduledTime: TZDateTime.from(goal.reminderDateTime, timeZone.local),
        id: goal.reminderId,
        title: 'Sleep Reminder',
        content: 'It\'s time for your sleep reminder!',
      );
      Get.log('Reminder with ID ${goal.reminderId} re-enabled successfully.');
    } catch (e) {
      Get.log(
          'Error re-enabling reminder with ID ${goal.reminderId}: ${e.toString()}');
    }
  }
}
