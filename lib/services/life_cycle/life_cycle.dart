import 'dart:ffi';

import 'package:sleeping_app/constants.dart';
import 'package:sleeping_app/packages.dart';

// so we needed a life cycle management that will overlook overall on the whole app
// so if a sound is playing then from any screen user make minimize app then it stops the sound
// so we need this just call this on main function in main .dart then it will overlook on the whole app
class AppLifecycleService extends WidgetsBindingObserver {
  static final AppLifecycleService _instance = AppLifecycleService._internal();

  factory AppLifecycleService() => _instance;

  AppLifecycleService._internal() {
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      if (mediaPlayerController.isAnySoundPlaying()) {
        mediaPlayerController.stopAllSounds();
      }
      Get.log('App is in background');
    } else if (state == AppLifecycleState.resumed) {
      Get.log('App is in foreground');
    }
  }

  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
  }
}
