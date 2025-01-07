import 'package:shared_preferences/shared_preferences.dart';
import 'package:sleeping_app/Functions/common_functions.dart';
import 'package:sleeping_app/auth/auth_controller.dart';
import 'package:sleeping_app/controllers/media_player_controller.dart';
import 'package:sleeping_app/controllers/theme_controller.dart';
import 'package:sleeping_app/packages.dart';
import 'package:sleeping_app/services/firebase/firebase_controller.dart';
import 'package:sleeping_app/services/firebase/firebase_service.dart';
import 'package:sleeping_app/services/mood_service/modd_service.dart';
import 'package:sleeping_app/services/notification/notification.dart';
import 'package:sleeping_app/utils/global_variables.dart';

late AuthService authService;
late AuthController authController;
late CommonFunctions commonFunctions;
late FirebaseController firebaseController;
late FirebaseService firebaseService;
late GlobalController globalController;
late SoundPlayerController soundPlayerController;
late MediaPlayerController mediaPlayerController;
late SharedPreferences prefs;
late ThemeController themeController;
late MoodService moodService;
late NotificationService notificationService;
initializeControllers() async {
  authService = Get.put(AuthService());
  authController = Get.put(AuthController());
  commonFunctions = Get.put(CommonFunctions());
  firebaseController = Get.put(FirebaseController());
  firebaseService = Get.put(FirebaseService());
  globalController = Get.put(GlobalController());
  soundPlayerController = Get.put(SoundPlayerController());
  mediaPlayerController = Get.put(MediaPlayerController());
  moodService = MoodService();
  notificationService = NotificationService();

  prefs = await SharedPreferences.getInstance();
  themeController = Get.put(ThemeController());

  notificationService.initNotification();
}
