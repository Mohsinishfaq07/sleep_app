import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:sleeping_app/packages.dart';

class MoodService {
  List<String> moodEmojis = [
    '⛔',
    '😊',
    '😢',
    '😭',
    '😄',
    '😐',
  ];
// Add a new mood entry to the cache
  Future<void> addMoodToCache(DateTime dateTime, String mood) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      // Retrieve existing mood list or create a new one
      String? moodsJson = prefs.getString('moodsCache');
      List<Map<String, dynamic>> moodList = moodsJson != null
          ? List<Map<String, dynamic>>.from(jsonDecode(moodsJson))
          : [];

      // Add the new mood entry
      moodList.add({
        'dateTime': dateTime.toIso8601String(),
        'mood': mood, // Emoji for mood
      });

      // Save updated mood list back to SharedPreferences
      await prefs.setString('moodsCache', jsonEncode(moodList));
      Get.log('Mood added successfully!');
      Get.snackbar('', '$mood recorded for ${dateTime.toIso8601String()}',
          backgroundColor: Colors.grey);
    } catch (e) {
      Get.log('Error adding mood: $e');
      Get.snackbar('Try Again', '', backgroundColor: Colors.grey);
    }
  }

// Retrieve all mood entries from the cache
  Future<List<Map<String, dynamic>>> getMoodsFromCache() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? moodsJson = prefs.getString('moodsCache');

      if (moodsJson != null) {
        // Decode JSON string to a list of maps
        return List<Map<String, dynamic>>.from(jsonDecode(moodsJson));
      }
      return []; // Return empty list if no data found
    } catch (e) {
      Get.log('Error retrieving moods: $e');
      return [];
    }
  }

// Clear all mood entries from the cache
  Future<void> clearMoodsCache() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.remove('moodsCache');
      Get.log('All moods cleared successfully!');
    } catch (e) {
      Get.log('Error clearing moods: $e');
    }
  }

  Future<bool> checkIfPresentDateInCache() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      // Retrieve the mood list from cache
      String? moodsJson = prefs.getString('moodsCache');

      if (moodsJson != null) {
        // Decode the JSON string into a list of maps
        List<Map<String, dynamic>> moodList =
            List<Map<String, dynamic>>.from(jsonDecode(moodsJson));

        // Get the current date
        DateTime currentDate = DateTime.now();
        String currentDateString = currentDate
            .toIso8601String()
            .split('T')[0]; // Get the date part (YYYY-MM-DD)

        // Check if any date in the mood list matches the current date
        bool dateFound = false;
        List<String> datesInList = [];

        for (var mood in moodList) {
          String moodDate =
              mood['dateTime'].split('T')[0]; // Extract date part from DateTime
          datesInList.add(moodDate);

          if (moodDate == currentDateString) {
            dateFound = true;
            break;
          }
        }

        // Get.log the result
        if (dateFound) {
          Get.log('Date is present in the list.');
          Get.snackbar('', 'mood is already recorded for this date',
              backgroundColor: Colors.grey);
        } else {
          Get.log('Date is not in the list.');
        }

        Get.log('Current Date: $currentDateString');
        Get.log('Dates in the List: $datesInList');
        return true;
      } else {
        Get.log('No moods found in the cache.');
        return false;
      }
    } catch (e) {
      Get.log('Error checking mood dates: $e');
      return false;
    }
  }
}
