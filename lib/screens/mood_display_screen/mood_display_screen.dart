import 'package:flutter/material.dart';
import 'package:sleeping_app/services/mood_service/modd_service.dart';
import 'package:table_calendar/table_calendar.dart';

class MoodDisplayScreen extends StatefulWidget {
  @override
  _MoodDisplayScreenState createState() => _MoodDisplayScreenState();
}

class _MoodDisplayScreenState extends State<MoodDisplayScreen> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  Map<DateTime, String> _moods = {}; // Map to store moods with dates
  List<Map<String, dynamic>> _moodEntries = []; // List to store mood data

  @override
  void initState() {
    super.initState();
    _loadMoods();
  }

  // Load moods from MoodService
  Future<void> _loadMoods() async {
    MoodService moodService = MoodService();
    List<Map<String, dynamic>> moods = await moodService.getMoodsFromCache();

    // Convert moods into a map for calendar display
    Map<DateTime, String> moodMap = {};
    for (var moodEntry in moods) {
      DateTime date = DateTime.parse(moodEntry['dateTime']);
      String mood = moodEntry['mood'];
      moodMap[date] = mood;
    }

    setState(() {
      _moods = moodMap;
      _moodEntries = moods;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        iconTheme: const IconThemeData(color: Colors.white),
        centerTitle: false,
        title:
            const Text("Mood History", style: TextStyle(color: Colors.white)),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TableCalendar(
              firstDay: DateTime(2000),
              lastDay: DateTime(2100),
              focusedDay: _focusedDay,
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
                  border:
                      Border.fromBorderSide(BorderSide(color: Colors.white)),
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                ),
                leftChevronIcon: Icon(Icons.chevron_left, color: Colors.white),
                rightChevronIcon:
                    Icon(Icons.chevron_right, color: Colors.white),
              ),
              eventLoader: (date) {
                // Return a list containing the mood emoji if it exists
                if (_moods.containsKey(date)) {
                  return [_moods[date]!];
                }
                return [];
              },
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: _moodEntries.isNotEmpty
                ? ListView.builder(
                    itemCount: _moodEntries.length,
                    itemBuilder: (context, index) {
                      final entry = _moodEntries[index];
                      return Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 13, vertical: 5),
                        decoration: BoxDecoration(
                          color: Colors.white12,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 13.0, vertical: 5),
                          child: Text(
                            'Your mood on ${entry['dateTime'].split('T')[0]}\n recorder${entry['mood']}',
                            style: const TextStyle(
                                fontSize: 15, color: Colors.white),
                          ),
                        ),
                      );
                    },
                  )
                : const Center(
                    child: Text(
                      'No moods found.',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
