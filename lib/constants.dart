import 'package:shared_preferences/shared_preferences.dart';
import 'package:sleeping_app/Functions/common_functions.dart';

import 'package:sleeping_app/controllers/media_player_controller.dart';
import 'package:sleeping_app/controllers/theme_controller.dart';
import 'package:sleeping_app/packages.dart';

import 'package:sleeping_app/services/mood_service/modd_service.dart';
import 'package:sleeping_app/services/notification/notification.dart';
import 'package:sleeping_app/utils/global_variables.dart';

late CommonFunctions commonFunctions;

late GlobalController globalController;
late SoundPlayerController soundPlayerController;
late MediaPlayerController mediaPlayerController;
late SharedPreferences prefs;
late ThemeController themeController;
late MoodService moodService;
late NotificationService notificationService;
initializeControllers() async {
  commonFunctions = Get.put(CommonFunctions());

  globalController = Get.put(GlobalController());
  soundPlayerController = Get.put(SoundPlayerController());
  mediaPlayerController = Get.put(MediaPlayerController());
  moodService = MoodService();
  notificationService = NotificationService();

  prefs = await SharedPreferences.getInstance();
  themeController = Get.put(ThemeController());

  notificationService.initNotification();
}
