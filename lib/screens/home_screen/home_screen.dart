// import 'package:audioplayers/audioplayers.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:sleeping_app/constants.dart';
// import 'package:sleeping_app/controllers/media_player_controller.dart';
// import 'package:sleeping_app/provider/sound_player_controller.dart';
// import 'package:sleeping_app/screens/sounds_screen/widgets/single_sound_box.dart';
// import 'package:sleeping_app/utils/global_variables.dart';

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   String? currentSoundPath;

//   int tapped = 0;

//   bool isPlaying = false;

//   String? _currentSoundPath;

//   String? _currentSoundName;

//   IconData? _currentSoundIcon;

//   final audioPlayer = AudioPlayer();
//   void toggleAnimation(String soundPath) async {
//     if (soundPath.isNotEmpty) {
//       final soundController = Get.find<SoundPlayerController>();

//       if (isPlaying && _currentSoundPath == soundPath) {
//         await audioPlayer.stop();
//         soundController.removeSound(soundPath);

//         setState(() {
//           _currentSoundName = null;
//           _currentSoundIcon = null;
//           isPlaying = false;
//           currentSoundPath = null;
//         });
//       } else {
//         if (currentSoundPath != soundPath) {
//           await audioPlayer.stop();
//           soundController.stopSound(soundPath);
//         }

//         await audioPlayer.play(UrlSource(soundPath));

//         setState(() {
//           isPlaying = true;
//           _currentSoundPath = soundPath;
//           _currentSoundName = _currentSoundName;
//           _currentSoundIcon = _currentSoundIcon;
//         });
//       }
//     }
//   }

//   void singleToggleAnimation(String soundPath) async {
//     Get.log('sound path:$soundPath');
//     if (soundPath.isNotEmpty) {
//       // Stop the currently playing sound if it's different from the tapped one
//       if (isPlaying && currentSoundPath != soundPath) {
//         await audioPlayer.stop();
//       }

//       // If the tapped sound is already playing, stop it
//       if (currentSoundPath == soundPath && isPlaying) {
//         await audioPlayer.stop();
//         setState(() {
//           isPlaying = false;
//           currentSoundPath = null;
//         });
//         return;
//       }

//       // Play the new sound
//       await audioPlayer.play(UrlSource(soundPath));

//       setState(() {
//         isPlaying = true;
//         currentSoundPath = soundPath;
//       });
//     }
//   }

//   @override
//   void dispose() {
//     audioPlayer.dispose();
//     super.dispose();
//   }

//   String selectedCategory = "None";

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.transparent,
//       body: DefaultTabController(
//         length: soundCategories.length,
//         child: Padding(
//           padding: const EdgeInsets.only(top: 20.0),
//           child: Column(
//             children: [
//               Container(
//                 height: 170,
//                 color: Colors.red,
//                 width: MediaQuery.sizeOf(context).width - 20,
//                 child: ListView.builder(
//                     physics: const BouncingScrollPhysics(),
//                     scrollDirection: Axis.horizontal,
//                     itemCount: soundCategories.length,
//                     itemBuilder: (context, index) {
//                       Map<String, dynamic> sound = soundCategories[index];
//                       return Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: GestureDetector(
//                           onTap: () {
//                             mediaPlayerController.stopAllSounds();
//                             globalController.selectedSoundCategory.value =
//                                 sound['name'] ?? '';
//                             Get.log(
//                                 'selected category name: ${globalController.selectedSoundCategory.value}');
//                           },
//                           child: Tab(
//                             height: 160,
//                             child: Column(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 ClipRRect(
//                                   borderRadius: BorderRadius.circular(
//                                       30), // 30 radius for rounded corners
//                                   child: Image.asset(
//                                     sound['imagePath'] ??
//                                         'assets/image/default.png', // Fallback image
//                                     height: 100,
//                                   ),
//                                 ),
//                                 const SizedBox(
//                                     height:
//                                         10), // Space between images and text
//                                 Obx(() {
//                                   return Text(
//                                     sound['name'] ?? '',
//                                     style: TextStyle(
//                                         fontSize: 12,
//                                         color: globalController
//                                                     .selectedSoundCategory
//                                                     .value ==
//                                                 sound['name']
//                                             ? Colors.blue
//                                             : Colors.black),
//                                   );
//                                 })
//                               ],
//                             ),
//                           ),
//                         ),
//                       );
//                     }),
//               ),
//               // Expanded to fit the TabBarView in remaining space
//               Obx(() {
//                 return Expanded(
//                   child: TabBarView(
//                     children: soundCategories.map((category) {
//                       return SizedBox(
//                         height: MediaQuery.of(context).size.height *
//                             0.5, // Give height for GridView
//                         child: GridView.builder(
//                           scrollDirection: Axis.vertical,
//                           gridDelegate:
//                               const SliverGridDelegateWithFixedCrossAxisCount(
//                             crossAxisCount: 3,
//                           ),
//                           itemCount: globalController
//                                       .selectedSoundCategory.value ==
//                                   'Music'
//                               ? musicCategoryData.length
//                               : globalController.selectedSoundCategory.value ==
//                                       'Mixes'
//                                   ? mixesCategoryData.length
//                                   : globalController
//                                               .selectedSoundCategory.value ==
//                                           'Sound'
//                                       ? soundCategoryData.length
//                                       : globalController.selectedSoundCategory
//                                                   .value ==
//                                               'SleepTales'
//                                           ? sleepTalesData.length
//                                           : globalController
//                                                       .selectedSoundCategory
//                                                       .value ==
//                                                   'Breathe'
//                                               ? breatheData.length
//                                               : globalController
//                                                           .selectedSoundCategory
//                                                           .value ==
//                                                       'Meditations'
//                                                   ? meditationData.length
//                                                   : sleepMoveData.length,
//                           itemBuilder: (context, index) {
//                             Map<String, dynamic> sound = globalController
//                                             .selectedSoundCategory.value ==
//                                         'Music' ||
//                                     globalController
//                                             .selectedSoundCategory.value ==
//                                         'Mixes'
//                                 ? soundData[index]
//                                 : globalController
//                                             .selectedSoundCategory.value ==
//                                         'Sound'
//                                     ? soundCategoryData[index]
//                                     : globalController
//                                                 .selectedSoundCategory.value ==
//                                             'SleepTales'
//                                         ? sleepTalesData[index]
//                                         : globalController.selectedSoundCategory
//                                                     .value ==
//                                                 'Breathe'
//                                             ? breatheData[index]
//                                             : globalController
//                                                         .selectedSoundCategory
//                                                         .value ==
//                                                     'Meditations'
//                                                 ? meditationData[index]
//                                                 : sleepMoveData[index];
//                             return SingleSoundBox(
//                               icon: sound['icon'],
//                               text: sound['name'],
//                               isPaid: sound['isPaid'],
//                               filePath: sound['filePath'],
//                               onTap: () async {
//                                 mediaPlayerController.currentPlayingSound
//                                     .value = sound['filePath'];

//                                 RecentPlayingSoundModel recentSoundListElement =
//                                     RecentPlayingSoundModel(
//                                   soundName: sound['name'],
//                                   path: sound['filePath'],
//                                   playing: false,
//                                 );

//                                 if (globalController
//                                         .selectedSoundCategory.value ==
//                                     'Mixes') {
//                                   mediaPlayerController.currentPlayingSoundName
//                                       .value = 'Playing Mixes';
//                                   // add multiple sounds in list
//                                   Get.log('added');

//                                   // now in this
//                                   // if this sound is already present in list
//                                   if (mediaPlayerController
//                                           .recentSounds
//                                           .contains(recentSoundListElement) &&
//                                       mediaPlayerController
//                                           .isSoundPlayingByName(
//                                               soundName:
//                                                   recentSoundListElement
//                                                       .soundName)) {
//                                     Get.log(
//                                         'mixes sound is present in list and stopping the sound');
//                                     mediaPlayerController.stopSound(
//                                         soundName:
//                                             recentSoundListElement.soundName);
//                                   } else if (mediaPlayerController
//                                           .recentSounds
//                                           .contains(recentSoundListElement) &&
//                                       !mediaPlayerController
//                                           .isSoundPlayingByName(
//                                               soundName: recentSoundListElement
//                                                   .soundName)) {
//                                     Get.log(
//                                         'mixes sound is present in list and playing the sound');
//                                     mediaPlayerController.playSound(
//                                         soundPath: recentSoundListElement.path,
//                                         soundName:
//                                             recentSoundListElement.soundName);
//                                   } else {
//                                     mediaPlayerController.recentSounds
//                                         .add(recentSoundListElement);
//                                     Get.log(
//                                         'mixes sound is not present in list');
//                                     // play the sound
//                                     mediaPlayerController.playSound(
//                                         soundPath: recentSoundListElement.path,
//                                         soundName:
//                                             recentSoundListElement.soundName);
//                                   }
//                                 } else {
//                                   // first clear list then add
//                                   mediaPlayerController.currentPlayingSoundName
//                                       .value = sound['name'];
//                                   if (mediaPlayerController
//                                           .recentSounds
//                                           .contains(recentSoundListElement) &&
//                                       mediaPlayerController
//                                           .isSoundPlayingByName(
//                                               soundName:
//                                                   recentSoundListElement
//                                                       .soundName)) {
//                                     Get.log(
//                                         'single sound is present in list and stopping the sound');
//                                     mediaPlayerController.stopSound(
//                                         soundName:
//                                             recentSoundListElement.soundName);
//                                   } else if (mediaPlayerController
//                                           .recentSounds
//                                           .contains(recentSoundListElement) &&
//                                       !mediaPlayerController
//                                           .isSoundPlayingByName(
//                                               soundName: recentSoundListElement
//                                                   .soundName)) {
//                                     Get.log(
//                                         'single sound is present in list and playing the sound');
//                                     mediaPlayerController.playSound(
//                                         soundPath: recentSoundListElement.path,
//                                         soundName:
//                                             recentSoundListElement.soundName);
//                                   } else {
//                                     // play the sound
//                                     Get.log('clear and added');
//                                     mediaPlayerController.recentSounds.clear();
//                                     mediaPlayerController.recentSounds
//                                         .add(recentSoundListElement);
//                                     Get.log(
//                                         'single sound is not present in list');
//                                     mediaPlayerController.playSound(
//                                         soundPath: recentSoundListElement.path,
//                                         soundName:
//                                             recentSoundListElement.soundName);
//                                   }
//                                 }

//                                 setState(() {
//                                   _currentSoundPath = sound['filePath'];
//                                   _currentSoundName = sound['name'];
//                                   _currentSoundIcon = sound['icon'];
//                                 });

//                                 Get.log(
//                                     'current playing sound :${mediaPlayerController.currentPlayingSound.value}');
//                               },
//                               isPlaying: isPlaying,
//                               toggleAnimation: () {
//                                 //  toggleAnimation(sound['filePath'] ?? '');
//                                 singleToggleAnimation(sound['filePath'] ?? '');
//                               },
//                               multipleSounds: globalController
//                                           .selectedSoundCategory.value ==
//                                       'Mixes'
//                                   ? true
//                                   : false,
//                               fileName: sound['name'],
//                             );
//                           },
//                         ),
//                       );
//                     }).toList(),
//                   ),
//                 );
//               })
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sleeping_app/constants.dart';
import 'package:sleeping_app/controllers/media_player_controller.dart';
import 'package:sleeping_app/provider/sound_player_controller.dart';
import 'package:sleeping_app/screens/sounds_screen/widgets/single_sound_box.dart';
import 'package:sleeping_app/utils/global_variables.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  String? currentSoundPath;
  int tapped = 0;
  bool isPlaying = false;
  String? _currentSoundPath;
  String? _currentSoundName;
  IconData? _currentSoundIcon;
  final audioPlayer = AudioPlayer();
  late TabController _tabController;
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: soundCategories.length, vsync: this);
    _scrollController = ScrollController();
    _tabController.addListener(() {
      if (_tabController.indexIsChanging || _tabController.index != null) {
        globalController.selectedSoundCategory.value =
            soundCategories[_tabController.index]['name'] ?? '';
        Get.log(
            'Swiped to category: ${globalController.selectedSoundCategory.value}');
        _scrollToIndex(_tabController.index);
      }
    });
  }

  void toggleAnimation(String soundPath) async {
    if (soundPath.isNotEmpty) {
      final soundController = Get.find<SoundPlayerController>();

      if (isPlaying && _currentSoundPath == soundPath) {
        await audioPlayer.stop();
        soundController.removeSound(soundPath);

        setState(() {
          _currentSoundName = null;
          _currentSoundIcon = null;
          isPlaying = false;
          currentSoundPath = null;
        });
      } else {
        if (currentSoundPath != soundPath) {
          await audioPlayer.stop();
          soundController.stopSound(soundPath);
        }

        await audioPlayer.play(UrlSource(soundPath));

        setState(() {
          isPlaying = true;
          _currentSoundPath = soundPath;
          _currentSoundName = _currentSoundName;
          _currentSoundIcon = _currentSoundIcon;
        });
      }
    }
  }

  void singleToggleAnimation(String soundPath) async {
    Get.log('sound path:$soundPath');
    if (soundPath.isNotEmpty) {
      if (isPlaying && currentSoundPath != soundPath) {
        await audioPlayer.stop();
      }

      if (currentSoundPath == soundPath && isPlaying) {
        await audioPlayer.stop();
        setState(() {
          isPlaying = false;
          currentSoundPath = null;
        });
        return;
      }

      await audioPlayer.play(UrlSource(soundPath));

      setState(() {
        isPlaying = true;
        currentSoundPath = soundPath;
      });
    }
  }

  void _scrollToIndex(int index) {
    double scrollOffset = index * 120.0; // Adjust item width + padding
    _scrollController.animateTo(
      scrollOffset,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: Column(
            children: [
              SizedBox(
                height: 170,
                width: MediaQuery.sizeOf(context).width - 20,
                child: ListView.builder(
                    controller: _scrollController,
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemCount: soundCategories.length,
                    itemBuilder: (context, index) {
                      Map<String, dynamic> sound = soundCategories[index];
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () {
                            mediaPlayerController.stopAllSounds();
                            globalController.selectedSoundCategory.value =
                                sound['name'] ?? '';
                            _tabController.animateTo(
                                index); // Switch tab when category is tapped
                            _scrollToIndex(index);
                            Get.log(
                                'selected category name: ${globalController.selectedSoundCategory.value}');
                          },
                          child: Tab(
                            height: 160,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(30),
                                  child: Image.asset(
                                    sound['imagePath'] ??
                                        'assets/image/default.png',
                                    height: 100,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Obx(() {
                                  return Text(
                                    sound['name'] ?? '',
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: globalController
                                                    .selectedSoundCategory
                                                    .value ==
                                                sound['name']
                                            ? Colors.blue
                                            : Colors.white),
                                  );
                                })
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
              ),
              Obx(() {
                return Expanded(
                    child: GridView.builder(
                  scrollDirection: Axis.vertical,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                  ),
                  itemCount: globalController.selectedSoundCategory.value ==
                          'Music'
                      ? musicCategoryData.length
                      : globalController.selectedSoundCategory.value == 'Mixes'
                          ? mixesCategoryData.length
                          : globalController.selectedSoundCategory.value ==
                                  'Sound'
                              ? soundCategoryData.length
                              : globalController.selectedSoundCategory.value ==
                                      'SleepTales'
                                  ? sleepTalesData.length
                                  : globalController
                                              .selectedSoundCategory.value ==
                                          'Breathe'
                                      ? breatheData.length
                                      : globalController.selectedSoundCategory
                                                  .value ==
                                              'Meditations'
                                          ? meditationData.length
                                          : sleepMoveData.length,
                  itemBuilder: (context, index) {
                    Map<String, dynamic> sound = globalController
                                    .selectedSoundCategory.value ==
                                'Music' ||
                            globalController.selectedSoundCategory.value ==
                                'Mixes'
                        ? soundData[index]
                        : globalController.selectedSoundCategory.value ==
                                'Sound'
                            ? soundCategoryData[index]
                            : globalController.selectedSoundCategory.value ==
                                    'SleepTales'
                                ? sleepTalesData[index]
                                : globalController
                                            .selectedSoundCategory.value ==
                                        'Breathe'
                                    ? breatheData[index]
                                    : globalController
                                                .selectedSoundCategory.value ==
                                            'Meditations'
                                        ? meditationData[index]
                                        : sleepMoveData[index];
                    return SingleSoundBox(
                      icon: sound['icon'],
                      text: sound['name'],
                      isPaid: sound['isPaid'],
                      filePath: sound['filePath'],
                      onTap: () async {
                        // if user is not logged in show snack bar to login first
                        mediaPlayerController.currentPlayingSound.value =
                            sound['filePath'];

                        RecentPlayingSoundModel recentSoundListElement =
                            RecentPlayingSoundModel(
                          soundName: sound['name'],
                          path: sound['filePath'],
                          playing: false,
                        );

                        if (globalController.selectedSoundCategory.value ==
                            'Mixes') {
                          mediaPlayerController.currentPlayingSoundName.value =
                              'Playing Mixes';
                          Get.log('added');

                          if (mediaPlayerController.recentSounds
                                  .contains(recentSoundListElement) &&
                              mediaPlayerController.isSoundPlayingByName(
                                  soundName:
                                      recentSoundListElement.soundName)) {
                            Get.log(
                                'mixes sound is present in list and stopping the sound');
                            mediaPlayerController.stopSound(
                                soundName: recentSoundListElement.soundName);
                          } else if (mediaPlayerController.recentSounds
                                  .contains(recentSoundListElement) &&
                              !mediaPlayerController.isSoundPlayingByName(
                                  soundName:
                                      recentSoundListElement.soundName)) {
                            Get.log(
                                'mixes sound is present in list and playing the sound');
                            mediaPlayerController.playSound(
                                soundPath: recentSoundListElement.path,
                                soundName: recentSoundListElement.soundName);
                          } else {
                            mediaPlayerController.recentSounds
                                .add(recentSoundListElement);
                            Get.log('mixes sound is not present in list');
                            mediaPlayerController.playSound(
                                soundPath: recentSoundListElement.path,
                                soundName: recentSoundListElement.soundName);
                          }
                        } else {
                          mediaPlayerController.currentPlayingSoundName.value =
                              sound['name'];
                          if (mediaPlayerController.recentSounds
                                  .contains(recentSoundListElement) &&
                              mediaPlayerController.isSoundPlayingByName(
                                  soundName:
                                      recentSoundListElement.soundName)) {
                            Get.log(
                                'single sound is present in list and stopping the sound');
                            mediaPlayerController.stopSound(
                                soundName: recentSoundListElement.soundName);
                          } else if (mediaPlayerController.recentSounds
                                  .contains(recentSoundListElement) &&
                              !mediaPlayerController.isSoundPlayingByName(
                                  soundName:
                                      recentSoundListElement.soundName)) {
                            Get.log(
                                'single sound is present in list and playing the sound');
                            mediaPlayerController.playSound(
                                soundPath: recentSoundListElement.path,
                                soundName: recentSoundListElement.soundName);
                          } else {
                            Get.log('clear and added');
                            mediaPlayerController.recentSounds.clear();
                            mediaPlayerController.recentSounds
                                .add(recentSoundListElement);
                            mediaPlayerController.playSound(
                                soundPath: recentSoundListElement.path,
                                soundName: recentSoundListElement.soundName);
                          }

                          setState(() {
                            _currentSoundPath = sound['filePath'];
                            _currentSoundName = sound['name'];
                            _currentSoundIcon = sound['icon'];
                          });

                          Get.log(
                              'current playing sound :${mediaPlayerController.currentPlayingSound.value}');
                        }
                      },
                      isPlaying: isPlaying,
                      toggleAnimation: () {
                        singleToggleAnimation(sound['filePath'] ?? '');
                      },
                      multipleSounds:
                          globalController.selectedSoundCategory.value ==
                              'Mixes',
                      fileName: sound['name'],
                    );
                  },
                ));
              })
            ],
          ),
        ),
      ),
    );
  }
}
