import 'package:sleeping_app/common_widgets/custom_button.dart';
import 'package:sleeping_app/packages.dart';
import 'package:sleeping_app/screens/sounds_screen/my_sound_screen.dart';

showProcessingDialog({required String title}) {
  showDialog(
    context: Get.context!,
    barrierDismissible: false, // Prevent dismissing by tapping outside
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.grey,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0), // Rounded corners
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CircularProgressIndicator(
              color: Colors.black, // Black color for the progress indicator
            ),
            const SizedBox(height: 20.0),
            Text(
              '$title...',
              style: const TextStyle(
                color: Colors.black, // Black color for the text
                fontSize: 16.0,
              ),
            ),
          ],
        ),
      );
    },
  );
}

showExitDialogue() {
  showDialog(
    context: Get.context!,
    barrierDismissible: false, // Prevent dismissing by tapping outside
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.grey,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0), // Rounded corners
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'are you sure to exit?',
              style: TextStyle(
                color: Colors.black, // Black color for the text
                fontSize: 16.0,
              ),
            ),
            const SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomButton(
                  text: 'Yes',
                  onPressed: () {
                    SystemChannels.platform.invokeMethod('SystemNavigator.pop');
                  },
                  width: 90,
                ),
                CustomButton(
                  text: 'No',
                  onPressed: () {
                    Get.back();
                  },
                  width: 90,
                ),
              ],
            )
          ],
        ),
      );
    },
  );
}

showMoodDialogue(
    {required Function() onTap, required DateTime passedDateTime}) {
  showDialog(
    context: Get.context!,
    barrierDismissible: false, // Prevent dismissing by tapping outside
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.grey,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0), // Rounded corners
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'How Was your mood today?',
              style: TextStyle(
                color: Colors.black, // Black color for the text
                fontSize: 13.0,
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
                        moodService.addMoodToCache(
                            passedDateTime, moodService.moodEmojis[index]);
                        Get.back();
                        Future.delayed(
                            const Duration(
                              milliseconds: 200,
                            ), () {
                          onTap();
                        });
                      },
                      child: Text(moodService.moodEmojis[index]),
                    );
                  }),
            )
          ],
        ),
      );
    },
  );
}

showTimerDialogue() {
  List<String> times = ['5s', '5m', '10m', '1h'];
  List<int> actualTime = [5, 300, 600, 3600];
  showDialog(
    context: Get.context!,
    barrierDismissible: false, // Prevent dismissing by tapping outside
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.grey,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0), // Rounded corners
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: playerButton(
                    icon: const Icon(
                      Icons.close,
                      color: Colors.white,
                    ),
                    containerColor: Colors.blue,
                    height: 40,
                    width: 40,
                    onTap: () {
                      Get.back();
                    }),
              ),
            ),
            const Text(
              'Set Timer For Sound',
              style: TextStyle(
                color: Colors.black, // Black color for the text
                fontSize: 13.0,
              ),
            ),
            const SizedBox(height: 20.0),
            SizedBox(
              height: 50,
              width: double.infinity,
              child: ListView.builder(
                  itemCount: times.length,
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        mediaPlayerController.startSoundTimer(
                            timerValue: actualTime[index]);
                        Navigator.pop(context);
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 5.0),
                        padding: const EdgeInsets.symmetric(horizontal: 5.0),
                        decoration: BoxDecoration(
                          color: Colors.white12,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.timer_outlined,
                              color: Colors.black,
                            ),
                            Text(
                              times[index],
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 10.0),
                            )
                          ],
                        ),
                      ),
                    );
                  }),
            ),
          ],
        ),
      );
    },
  );
}
