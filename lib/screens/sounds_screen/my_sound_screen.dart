import 'package:flutter/material.dart';
import 'package:sleeping_app/common_widgets/custom_appbar.dart';
import 'package:sleeping_app/common_widgets/dialogue_boxes.dart';
import 'package:sleeping_app/constants.dart';
import 'package:sleeping_app/controllers/favorie_sound_controller.dart';
import 'package:sleeping_app/controllers/media_player_controller.dart';
import 'package:sleeping_app/packages.dart';

playerButton(
    {required Icon icon,
    required Color containerColor,
    required double height,
    required double width,
    required Function() onTap}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      height: height,
      width: width,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0), color: containerColor),
      child: icon,
    ),
  );
}

class MySoundScreen extends StatefulWidget {
  const MySoundScreen({super.key});

  @override
  State<MySoundScreen> createState() => _MySoundScreenState();
}

class _MySoundScreenState extends State<MySoundScreen> {
  @override
  void dispose() {
    mediaPlayerController.stopAllSounds();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    FavoriteSoundController favoriteSoundController =
        Get.put(FavoriteSoundController());
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: const CustomAppBarWidget(
        showTitle: true,
        title: Text(
          "Play Sleep sounds",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Sound List
              Obx(() {
                return mediaPlayerController.recentSounds.isEmpty
                    ? const SizedBox.shrink()
                    : SizedBox(
                        height: 200,
                        child: ListView.builder(
                          itemCount: mediaPlayerController.recentSounds.length,
                          itemBuilder: (BuildContext context, int index) {
                            RecentPlayingSoundModel sound =
                                mediaPlayerController.recentSounds[index];
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: ListTile(
                                tileColor: Colors.white12,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0)),
                                title: Text(
                                  sound.soundName,
                                  style: const TextStyle(color: Colors.white),
                                ),
                                trailing: FittedBox(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      // fav / un fav button
                                      GestureDetector(
                                        onTap: () async {
                                          !favoriteSoundController
                                                  .isSoundFavorite(
                                                      sound.soundName,
                                                      sound.path)
                                              ? favoriteSoundController
                                                  .addSoundToFavorites(
                                                      sound.soundName,
                                                      sound.path)
                                              : favoriteSoundController
                                                  .removeSoundFromFavorites(
                                                      sound.soundName,
                                                      sound.path);
                                        },
                                        child: Obx(() {
                                          return favoriteSoundController
                                                  .isSoundFavorite(
                                                      sound.soundName,
                                                      sound.path)
                                              ? const Icon(
                                                  Icons.favorite,
                                                  color: Colors.red,
                                                )
                                              : const Icon(
                                                  Icons.favorite_border,
                                                  color: Colors.red,
                                                );
                                        }),
                                      ),
                                      const SizedBox(width: 20),
                                      // Play/Pause Button
                                      GestureDetector(
                                        onTap: () async {
                                          if (mediaPlayerController
                                              .isSoundPlayingAtIndex(
                                                  index: index)) {
                                            Get.log(
                                                'sound was playing at $index');
                                            mediaPlayerController.stopSound(
                                                soundName: sound.soundName);
                                          } else {
                                            Get.log(
                                                'sound started playing at $index');
                                            mediaPlayerController.playSound(
                                                soundPath: sound.path,
                                                soundName: sound.soundName);
                                          }
                                        },
                                        child: Obx(() {
                                          return Icon(
                                            mediaPlayerController
                                                    .isSoundPlayingAtIndex(
                                                        index: index)
                                                ? Icons.pause_circle_filled
                                                : Icons.play_circle_filled,
                                            color: Colors.white,
                                          );
                                        }),
                                      ),
                                      const SizedBox(width: 20),

                                      // Delete Sound Button
                                      GestureDetector(
                                        onTap: () {
                                          Get.log('remove');
                                          // if (mediaPlayerController
                                          //     .isAnySoundPlaying()) {
                                          //   mediaPlayerController.stopSound(
                                          //       soundName: sound.soundName);
                                          //   mediaPlayerController.recentSounds
                                          //       .remove(sound);
                                          //   mediaPlayerController.audioPlayers
                                          //       .removeAt(index);
                                          //   mediaPlayerController
                                          //       .currentPlayingSound.value = '';
                                          //   mediaPlayerController
                                          //       .currentPlayingSoundName.value = '';
                                          // }
                                          mediaPlayerController.stopAllSounds();
                                          mediaPlayerController.recentSounds
                                              .remove(sound);
                                          mediaPlayerController.audioPlayers
                                              .removeAt(index);
                                          if (globalController
                                                  .selectedSoundCategory
                                                  .value ==
                                              'Mixes') {
                                            mediaPlayerController
                                                .currentPlayingSound.value = '';
                                            mediaPlayerController
                                                .currentPlayingSoundName
                                                .value = 'Playing Mixes';
                                          } else {
                                            mediaPlayerController
                                                .currentPlayingSound.value = '';
                                            mediaPlayerController
                                                .currentPlayingSoundName
                                                .value = '';
                                          }

                                          // Remove sound from the list
                                        },
                                        child: const Icon(
                                          Icons.delete,
                                          color: Colors.red,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      );
              }),

              // Song Title
              Obx(() {
                return Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Text(
                    !mediaPlayerController.isAnySoundPlaying()
                        ? 'No sound is selected'
                        : mediaPlayerController.currentPlayingSoundName.value,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
              }),

              const SizedBox(height: 10),

              // Song Duration and Slider
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     Text(
              //       _formatDuration(mediaPlayerController.currentPosition.value),
              //       style: const TextStyle(color: Colors.white),
              //     ),
              //     const SizedBox(width: 8),
              //     Slider(
              //       min: 0.0,
              //       max: mediaPlayerController.totalDuration.value.inSeconds
              //           .toDouble(),
              //       value: mediaPlayerController.currentPosition.value.inSeconds
              //           .toDouble(),
              //       activeColor: Colors.blue,
              //       inactiveColor: Colors.white24,
              //       onChanged: (value) {
              //         // mediaPlayerController.audioPlayer.seek(
              //         //     Duration(seconds: value.toInt()));
              //       },
              //     ),
              //     const SizedBox(width: 8),
              //     Text(
              //       _formatDuration(mediaPlayerController.totalDuration.value),
              //       style: const TextStyle(color: Colors.white),
              //     ),
              //   ],
              // ),

              Obx(() {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Slider(
                        activeColor: Colors.blue.shade800,
                        value: mediaPlayerController.volume.value,
                        onChanged: (value) {
                          for (var players
                              in mediaPlayerController.audioPlayers) {
                            players.setVolume(value);
                            mediaPlayerController.volume.value = value;
                            Get.log(players.volume.toString());
                          }
                        },
                        min: 0.0,
                        max: 1.0,
                        divisions: 10,
                        label: (mediaPlayerController.volume.value * 100)
                            .toInt()
                            .toString(),
                      ),
                    ),
                    Text(
                      'Volume: ${(mediaPlayerController.volume.value * 100).toInt()}%',
                      style: const TextStyle(fontSize: 12, color: Colors.white),
                    ),
                  ],
                );
              }),
              const SizedBox(height: 20),

              // Play/Pause All Sounds and Seek Controls
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  playerButton(
                    icon: const Icon(
                      Icons.timer_outlined,
                      color: Colors.white,
                      size: 25,
                    ),
                    containerColor: Colors.blue.shade800,
                    height: 50,
                    width: 40,
                    onTap: () {
                      if (mediaPlayerController.isAnySoundPlaying() &&
                          !mediaPlayerController.soundTimerSet.value) {
                        showTimerDialogue();
                      } else if (mediaPlayerController.isAnySoundPlaying() &&
                          mediaPlayerController.soundTimerSet.value) {
                        Get.snackbar('Alert', 'Timer is already set  :)',
                            backgroundColor: Colors.grey);
                      } else {
                        Get.snackbar('Alert',
                            'Please play a sound before setting a timer :)',
                            backgroundColor: Colors.grey);
                      }
                    },
                  ),
                  playerButton(
                      icon: const Icon(
                        Icons.skip_previous,
                        color: Colors.white,
                        size: 30,
                      ),
                      containerColor: Colors.blue.shade800,
                      height: 50,
                      width: 50,
                      onTap: () {
                        // mediaPlayerController.audioPlayer.seek(
                        //     mediaPlayerController.currentPosition.value -
                        //         const Duration(seconds: 10));
                      }),
                  Obx(() {
                    return playerButton(
                        icon: Icon(
                          mediaPlayerController.isAnySoundPlaying()
                              ? Icons.pause_circle_filled
                              : Icons.play_circle_filled,
                          color: Colors.white,
                          size: 40,
                        ),
                        containerColor: Colors.blue.shade800,
                        height: 50,
                        width: 100,
                        onTap: () {
                          if (mediaPlayerController.isAnySoundPlaying()) {
                            mediaPlayerController.stopAllSounds();
                          } else {
                            mediaPlayerController.playAllSounds();
                          }
                        });
                  }),
                  playerButton(
                      icon: const Icon(
                        Icons.skip_next,
                        color: Colors.white,
                        size: 30,
                      ),
                      containerColor: Colors.blue.shade800,
                      height: 50,
                      width: 50,
                      onTap: () {}),

                  // IconButton(
                  //   icon: const Icon(
                  //     Icons.replay_10,
                  //     color: Colors.white,
                  //     size: 36,
                  //   ),
                  //   onPressed: () {
                  //     // Seek back by 10 seconds
                  //     // mediaPlayerController.audioPlayer
                  //     //     .seek(mediaPlayerController.currentPosition.value -
                  //     //     const Duration(seconds: 10));
                  //   },
                  // ),

                  // IconButton(
                  //   icon: const Icon(
                  //     Icons.forward_10,
                  //     color: Colors.white,
                  //     size: 36,
                  //   ),
                  //   onPressed: () {
                  //     // Seek forward by 10 seconds
                  //     // mediaPlayerController.audioPlayer
                  //     //     .seek(mediaPlayerController.currentPosition.value +
                  //     //     const Duration(seconds: 10));
                  //   },
                  // ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper function to format duration to MM:SS
  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return "$minutes:$seconds";
  }
}

//  if (mediaPlayerController
//                                           .isSoundPlayingAtIndex(
//                                           index: index)) {
//                                         mediaPlayerController.stopSound(soundName: sound.soundName);
//                                         mediaPlayerController
//                                             .updatePlayingStatus(
//                                                 soundName: sound.soundName,
//                                                 isPlaying:
//                                                     !mediaPlayerController
//                                                         .isAnySoundPlaying());
//                                       } else {
//                                         // await mediaPlayerController.audioPlayer
//                                         //     .setSourceAsset(sound.path);
//                                         // mediaPlayerController.audioPlayer
//                                         //     .play(AssetSource(sound.path));
//                                         mediaPlayerController.playSound(soundPath: sound.path, index: index);
//                                         mediaPlayerController
//                                             .updatePlayingStatus(
//                                                 soundName: sound.soundName,
//                                                 isPlaying:
//                                                     !mediaPlayerController
//                                                         .isAnySoundPlaying());
//                                         mediaPlayerController
//                                             .currentPlayingSound
//                                             .value = sound.path;
//                                         mediaPlayerController
//                                             .currentPlayingSoundName
//                                             .value = sound.soundName;
//                                       }
//                                       // if (isPlaying) {
//                                       //   _audioPlayer.pause();
//                                       //   mediaPlayerController
//                                       //       .updatePlayingStatus(
//                                       //           soundName: sound.soundName,
//                                       //           isPlaying:
//                                       //               !mediaPlayerController
//                                       //                   .isAnySoundPlaying());
//                                       //   setState(() {
//                                       //     isPlaying = false;
//                                       //   });
//                                       // } else {
//                                       //   //set asset
//                                       //   await _audioPlayer.setSourceAsset(
//                                       //       mediaPlayerController
//                                       //           .recentSounds[index].path);
//                                       //   // play asset
//                                       //   _audioPlayer.play(AssetSource(
//                                       //       mediaPlayerController
//                                       //           .recentSounds[index].path));
//                                       //   // update asset playing bool
//                                       //   mediaPlayerController
//                                       //       .updatePlayingStatus(
//                                       //           soundName: sound.soundName,
//                                       //           isPlaying:
//                                       //               !mediaPlayerController
//                                       //                   .isAnySoundPlaying());
//                                       //   setState(() {
//                                       //     isPlaying = true;
//                                       //   });
//                                       // }


/*

 IconButton(
                  icon: Obx(() {
                    return Icon(
                      mediaPlayerController.isAnySoundPlaying()
                          ? Icons.pause_circle_filled
                          : Icons.play_circle_filled,
                      color: Colors.blue,
                      size: 80,
                    );
                  }),
                  onPressed: () {
                    Get.log(
                        'player status: ${mediaPlayerController.isAnySoundPlaying()}');
                    // Play or pause based on the current player state
                    if (mediaPlayerController.isAnySoundPlaying()) {
                      mediaPlayerController.stopAllSounds();
                    } else {
                      mediaPlayerController.playAllSounds();
                    }
                  },
                ),

*/