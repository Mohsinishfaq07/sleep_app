import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sleeping_app/common_widgets/app_assets.dart';
import 'package:sleeping_app/common_widgets/custom_button.dart';
import 'package:sleeping_app/common_widgets/dialogue_boxes.dart';
import 'package:sleeping_app/constants.dart';
import 'package:sleeping_app/packages.dart';
import 'package:sleeping_app/services/notification/notification.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:timezone/timezone.dart' as timeZone;

// Reminder Model
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

  String toJson() => json.encode(toMap());

  factory ReminderModel.fromJson(String source) =>
      ReminderModel.fromMap(json.decode(source));
}

class SleepingReminder extends GetxController {
  RxList<ReminderModel> sleepingReminderList = <ReminderModel>[].obs;

  late SharedPreferences prefs;

  Future<void> initPreferences() async {
    prefs = await SharedPreferences.getInstance();
    loadSleepingGoals();
  }

  Future<void> addSleepingReminderIfNotExists(ReminderModel newGoal) async {
    bool exists = sleepingReminderList
        .any((goal) => goal.reminderId == newGoal.reminderId);

    if (!exists) {
      sleepingReminderList.add(newGoal);
      await saveReminder();
      Get.snackbar('Reminder Set',
          'Reminder set for ${newGoal.reminderDateTime.toString()}',
          backgroundColor: Colors.grey, colorText: Colors.black);
      try {
        await notificationService.scheduledNotification(
          scheduledTime: timeZone.TZDateTime.from(
            newGoal.reminderDateTime,
            timeZone.local, // Ensure correct time zone
          ),
          id: newGoal.reminderId,
          title: 'Sleep Reminder',
          content: 'It\'s time for your sleep reminder! }',
        );
      } catch (e) {
        Get.log('Error scheduling notification in cache : ${e.toString()}');
      }
    } else {
      Get.log('Reminder already exists');
    }
  }

  Future<void> loadSleepingGoals() async {
    final String? storedData = prefs.getString('reminders');
    if (storedData != null) {
      try {
        List<dynamic> decodedList = json.decode(storedData);

        sleepingReminderList.value = decodedList
            .map((item) => ReminderModel.fromMap(json.decode(item as String)))
            .toList();
      } catch (e) {
        Get.log("Error loading reminders: $e");
      }
    }
  }

  Future<void> saveReminder() async {
    List<String> encodedList =
        sleepingReminderList.map((item) => json.encode(item.toMap())).toList();

    Get.log("Encoded List to Save: $encodedList");

    await prefs.setString('reminders', json.encode(encodedList));
  }
}

class SetReminderScreen extends StatefulWidget {
  final bool showBackButton;
  const SetReminderScreen({super.key, required this.showBackButton});

  @override
  State<SetReminderScreen> createState() => _SetReminderScreenState();
}

class _SetReminderScreenState extends State<SetReminderScreen> {
  final SleepingReminder sleepingReminder = SleepingReminder();

  int hour = 0;
  int minute = 0;
  String timeState = 'AM';
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  String selectedModeEmoji = '⛔';

  int currentIndex = 0;

  setClockData() {
    setState(() {
      hour = DateTime.now().hour;
      minute = DateTime.now().minute;
      if (hour > 12) {
        hour -= 12;
      } else if (hour == 0) {
        hour = 12;
      }
    });
    setTimeState();
  }

  setTimeState() {
    setState(() {
      if (DateTime.now().hour > 11) {
        timeState = 'PM';
      } else {
        timeState = 'AM';
      }
    });
  }

  setTimeStateManually({required String state}) {
    setState(() {
      timeState = state;
    });
  }

  increaseHour() {
    if (hour == 12) {
    } else {
      if (hour > 11) {
        setState(() {
          hour++;
        });
      } else if (hour <= 11) {
        setState(() {
          hour++;
        });
      }
    }
  }

  decreaseHour() {
    if (hour == 1) {
    } else {
      if (hour < 11) {
        setState(() {
          hour--;
        });
      } else if (hour >= 11) {
        setState(() {
          hour--;
        });
      }
    }
  }

  increaseMinute() {
    if (minute == 59) {
      setState(() {
        minute = 0;
      });
    } else {
      setState(() {
        minute++;
      });
    }
  }

  decrementMinute() {
    if (minute == 0) {
      setState(() {
        hour--;
        minute = 59;
      });
    } else {
      setState(() {
        minute--;
      });
    }
  }

  Future<void> _selectDateTime(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: Get.context!,
        initialTime: TimeOfDay.now(),
      );

      if (pickedTime != null) {
        final DateTime combinedDateTime = DateTime(
          pickedDate.year,
          pickedDate.month,
          pickedDate.day,
          pickedTime.hour,
          pickedTime.minute,
        );

        ReminderModel newGoal = ReminderModel(
            reminderId:
                DateTime.now().millisecondsSinceEpoch % 1000000000, // Unique ID
            reminderValue: true,
            reminderDateTime: combinedDateTime,
            modeEmoji: selectedModeEmoji);

        await sleepingReminder.addSleepingReminderIfNotExists(newGoal);
      }
    }
  }

  @override
  void initState() {
    super.initState();
    sleepingReminder.initPreferences();
    setClockData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: widget.showBackButton
              ? IconButton(
                  onPressed: () => Get.back(),
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                )
              : const SizedBox.shrink(),
          title:
              const Text("Set Reminder", style: TextStyle(color: Colors.white)),
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
            Center(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 10.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.white38),
                height: 400,
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    if (currentIndex == 0) clockWidget(),
                    if (currentIndex == 1) calenderWidget(),
                    if (currentIndex == 2) modeSelectionWidget(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        if (currentIndex != 0)
                          CustomButton(
                            text: 'Previous',
                            onPressed: () {
                              setState(() {
                                currentIndex--;
                              });
                            },
                            width: 150,
                          ),
                        CustomButton(
                          width: 150,
                          text: currentIndex == 2 ? 'Set Reminder' : 'Next',
                          onPressed: () async {
                            if (currentIndex == 2) {
                              final DateTime combinedDateTime = DateTime(
                                _focusedDay.year,
                                _focusedDay.month,
                                _focusedDay.day,
                                hour,
                                minute,
                              );
                              ReminderModel newGoal = ReminderModel(
                                  reminderId:
                                      DateTime.now().millisecondsSinceEpoch %
                                          1000000000, // Unique ID
                                  reminderValue: true,
                                  reminderDateTime: combinedDateTime,
                                  modeEmoji: selectedModeEmoji);

                              await sleepingReminder
                                  .addSleepingReminderIfNotExists(newGoal);
                              if (widget.showBackButton) {
                                if (context.mounted) {
                                  Navigator.pop(context);
                                }
                              }
                            } else {
                              setState(() {
                                currentIndex++;
                              });
                            }
                          },
                        )
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ));
  }

  goalButton({
    required Function() onTap,
    required double height,
    required double width,
    required Widget widget,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height,
        width: width,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0), color: Colors.blue),
        child: widget,
      ),
    );
  }

  modeSelectionWidget() {
    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'How was your mood ?',
            style: TextStyle(
              color: Colors.white, // Black color for the text
              fontSize: 18.0,
            ),
          ),
          const SizedBox(height: 20.0),
          SizedBox(
            height: 50,
            width: double.infinity,
            child: ListView.builder(
                itemCount: moodService.moodEmojis.length,
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return TextButton(
                    onPressed: () {
                      selectedModeEmoji = moodService.moodEmojis[index];
                      commonFunctions.shoeSnackMessage(
                          message: '$selectedModeEmoji is selected');
                    },
                    child: Text(moodService.moodEmojis[index]),
                  );
                }),
          )
        ],
      ),
    );
  }

  calenderWidget() {
    return TableCalendar(
      firstDay: DateTime(2000),
      lastDay: DateTime(2100),
      focusedDay: _focusedDay,
      rowHeight: 40,
      daysOfWeekHeight: 25,
      headerVisible: false,
      calendarFormat: _calendarFormat,
      selectedDayPredicate: (day) {
        return isSameDay(_selectedDay, day);
      },
      onDaySelected: (selectedDay, focusedDay) {
        setState(() {
          _selectedDay = selectedDay;
          _focusedDay = focusedDay;
        });
      },
      onFormatChanged: (format) {
        setState(() {
          _calendarFormat = format;
        });
      },
      onPageChanged: (focusedDay) {
        _focusedDay = focusedDay;
      },
      calendarStyle: const CalendarStyle(
        defaultTextStyle: TextStyle(color: Colors.white),
        weekendTextStyle: TextStyle(color: Colors.white),
        todayTextStyle: TextStyle(color: Colors.white),
        todayDecoration: BoxDecoration(
          color: Colors.blue,
          shape: BoxShape.circle,
        ),
        selectedDecoration: BoxDecoration(
          color: Colors.red,
          shape: BoxShape.circle,
        ),
      ),
      daysOfWeekStyle: const DaysOfWeekStyle(
        weekdayStyle: TextStyle(color: Colors.white),
        weekendStyle: TextStyle(color: Colors.white),
      ),
      headerStyle: const HeaderStyle(
        titleTextStyle: TextStyle(color: Colors.white),
        formatButtonTextStyle: TextStyle(color: Colors.white),
        formatButtonDecoration: BoxDecoration(
          color: Colors.transparent,
          border: Border.fromBorderSide(BorderSide(color: Colors.white)),
          borderRadius: BorderRadius.all(Radius.circular(5.0)),
        ),
        leftChevronIcon: Icon(Icons.chevron_left, color: Colors.white),
        rightChevronIcon: Icon(Icons.chevron_right, color: Colors.white),
      ),
    );
  }

  clockWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Center(
              child: goalButton(
                onTap: () {
                  increaseHour();
                },
                height: 30,
                width: 30,
                widget: const Icon(
                  Icons.arrow_upward,
                  color: Colors.white,
                ),
              ),
            ),
            Text(
              '$hour : ',
              style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 23),
            ),
            goalButton(
              onTap: () {
                decreaseHour();
              },
              height: 30,
              width: 30,
              widget: const Icon(
                Icons.arrow_downward,
                color: Colors.white,
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Center(
                child: goalButton(
                  onTap: () {
                    increaseMinute();
                  },
                  height: 30,
                  width: 30,
                  widget: const Icon(
                    Icons.arrow_upward,
                    color: Colors.white,
                  ),
                ),
              ),
              Text(
                '$minute ',
                style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 23),
              ),
              goalButton(
                onTap: () {
                  decrementMinute();
                },
                height: 30,
                width: 30,
                widget: const Icon(
                  Icons.arrow_downward,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
        Column(
          children: [
            Center(
              child: goalButton(
                onTap: () {
                  setTimeStateManually(state: 'AM');
                },
                height: 30,
                width: 30,
                widget: const Icon(
                  Icons.arrow_upward,
                  color: Colors.white,
                ),
              ),
            ),
            Text(timeState,
                style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 23)),
            goalButton(
              onTap: () {
                setTimeStateManually(state: 'PM');
              },
              height: 30,
              width: 30,
              widget: const Icon(
                Icons.arrow_downward,
                color: Colors.white,
              ),
            ),
          ],
        )
      ],
    );
  }
}

/*

 Center(
              child: CustomButton(
                onPressed: () async {
                  bool moodPresent =
                      await moodService.checkIfPresentDateInCache();
                  if (moodPresent) {
                    _selectDateTime(context);
                  } else {
                    showMoodDialogue(
                        onTap: () {
                          _selectDateTime(context);
                        },
                        passedDateTime: DateTime.now());
                  }
                },
                text: 'Set Reminder',
              ),
            ),

*/
