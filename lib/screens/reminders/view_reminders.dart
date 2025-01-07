import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sleeping_app/common_widgets/app_assets.dart';
import 'package:sleeping_app/constants.dart';
import 'dart:convert';

import 'package:sleeping_app/services/notification/notification.dart';
import 'package:timezone/timezone.dart' as timeZone;

class ReminderModel {
  int reminderId;
  bool reminderValue;
  DateTime reminderDateTime;
  String modeEmoji;

  ReminderModel({
    required this.reminderId,
    required this.reminderValue,
    required this.reminderDateTime,
    required this.modeEmoji,
  });

  int get reminderHour => reminderDateTime.hour;

  int get reminderMinute => reminderDateTime.minute;

  String get reminderDay => _getDayName(reminderDateTime.weekday);

  Map<String, dynamic> toMap() {
    return {
      'reminderId': reminderId,
      'reminderValue': reminderValue,
      'reminderDateTime': reminderDateTime.toIso8601String(),
      'modeEmoji': modeEmoji,
    };
  }

  factory ReminderModel.fromMap(Map<String, dynamic> map) {
    return ReminderModel(
        reminderId: map['reminderId'],
        reminderValue: map['reminderValue'],
        reminderDateTime: DateTime.parse(
          map['reminderDateTime'],
        ),
        modeEmoji: map['modeEmoji']);
  }

  static String _getDayName(int weekday) {
    const days = [
      'Sunday',
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday'
    ];
    return days[weekday];
  }
}

class SleepingGoalsReminder extends GetxController {
  RxList<ReminderModel> sleepingGoalsReminderList = <ReminderModel>[].obs;

  late SharedPreferences prefs;

  Future<void> initPreferences() async {
    prefs = await SharedPreferences.getInstance();
    loadSleepingGoals();
  }

  Future<void> loadSleepingGoals() async {
    final String? storedData = prefs.getString('reminders');
    if (storedData != null) {
      try {
        List<dynamic> decodedList = json.decode(storedData);

        sleepingGoalsReminderList.value = decodedList
            .map((item) => ReminderModel.fromMap(json.decode(item as String)))
            .toList();
      } catch (e) {
        Get.log("Error loading reminders: $e");
      }
    }
  }

  Future<void> removeSleepingGoal(int reminderId) async {
    sleepingGoalsReminderList
        .removeWhere((goal) => goal.reminderId == reminderId);
    await saveSleepingGoals();
  }

  Future<void> saveSleepingGoals() async {
    List<String> encodedList = sleepingGoalsReminderList
        .map((item) => json.encode(item.toMap()))
        .toList();
    await prefs.setString('reminders', json.encode(encodedList));
  }
}

// Reminder Display Screen
class ViewSleepingGoalsScreen extends StatefulWidget {
  const ViewSleepingGoalsScreen({super.key});

  @override
  State<ViewSleepingGoalsScreen> createState() =>
      _ViewSleepingGoalsScreenState();
}

class _ViewSleepingGoalsScreenState extends State<ViewSleepingGoalsScreen> {
  final SleepingGoalsReminder sleepingGoalsReminder =
      Get.put(SleepingGoalsReminder());

  @override
  void initState() {
    super.initState();
    sleepingGoalsReminder.initPreferences();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(Icons.arrow_back, color: Colors.white),
        ),
        title:
            const Text("Your Reminders", style: TextStyle(color: Colors.white)),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Obx(() {
            return Image(
              image: AssetImage(themeController.currentTheme.value == 'dark'
                  ? AppAssets.bg
                  : themeController.currentTheme.value == 'red'
                      ? AppAssets.redBg
                      : AppAssets.blueBg),
              fit: BoxFit.cover,
            );
          }),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Obx(() {
              if (sleepingGoalsReminder.sleepingGoalsReminderList.isEmpty) {
                return const Center(
                  child: Text("No reminders set yet.",
                      style: TextStyle(fontSize: 16, color: Colors.white)),
                );
              } else {
                return ListView.builder(
                  itemCount:
                      sleepingGoalsReminder.sleepingGoalsReminderList.length,
                  itemBuilder: (context, index) {
                    final goal =
                        sleepingGoalsReminder.sleepingGoalsReminderList[index];
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white12,
                            borderRadius: BorderRadius.circular(10)),
                        child: ListTile(
                            contentPadding: const EdgeInsets.all(12),
                            title: Text(
                              'Day:  ${goal.reminderDay}\nTime:  ${goal.reminderHour}:${goal.reminderMinute.toString().padLeft(2, '0')}\nMode: ${goal.modeEmoji}',
                              style: const TextStyle(
                                  fontSize: 14, color: Colors.white),
                            ),
                            subtitle: Text(
                              'Active: ${goal.reminderValue ? "Yes" : "No"}',
                              style: const TextStyle(
                                  fontSize: 14, color: Colors.white),
                            ),
                            trailing: FittedBox(
                              child: Row(
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.delete,
                                        color: Colors.red),
                                    onPressed: () async {
                                      await sleepingGoalsReminder
                                          .removeSleepingGoal(goal.reminderId);
                                      Get.snackbar('Deleted',
                                          'Reminder removed successfully.',
                                          backgroundColor: Colors.grey.shade200,
                                          colorText: Colors.black);
                                    },
                                  ),
                                  Switch(
                                      activeColor: Colors.blue,
                                      value: goal.reminderValue,
                                      onChanged: (val) {
                                        goal.reminderValue = val;
                                        if (val) {
                                          NotificationService()
                                              .scheduledNotification(
                                            scheduledTime:
                                                timeZone.TZDateTime.from(
                                              goal.reminderDateTime,
                                              timeZone.local,
                                            ),
                                            id: goal.reminderId,
                                            title: 'Sleeping Goal Reminder',
                                            content: 'Time to sleep!',
                                          );
                                        } else {
                                          NotificationService()
                                              .cancelReminder(goal.reminderId);
                                        }
                                        setState(() {});
                                      })
                                ],
                              ),
                            )),
                      ),
                    );
                  },
                );
              }
            }),
          )
        ],
      ),
    );
  }
}
