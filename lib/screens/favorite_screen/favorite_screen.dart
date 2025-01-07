import 'package:sleeping_app/common_widgets/custom_appbar.dart';
import 'package:sleeping_app/controllers/favorie_sound_controller.dart';

import 'package:sleeping_app/controllers/media_player_controller.dart'; // Use this to play sounds
import 'package:sleeping_app/packages.dart'; // Your custom packages

class FavoriteSoundScreen extends StatefulWidget {
  const FavoriteSoundScreen({super.key});

  @override
  State<FavoriteSoundScreen> createState() => _FavoriteSoundScreenState();
}

class _FavoriteSoundScreenState extends State<FavoriteSoundScreen> {
  // Controllers
  final FavoriteSoundController favoriteSoundController =
      Get.put(FavoriteSoundController());
  final MediaPlayerController mediaPlayerController =
      Get.put(MediaPlayerController());

  @override
  void dispose() {
    mediaPlayerController.stopAllSounds();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: const CustomAppBarWidget(
        showTitle: true,
        title: Text(
          "Favorite Sounds",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Obx(() {
            // Fetch the list of favorite sounds
            final favoriteSounds = favoriteSoundController.favoriteSounds;

            if (favoriteSounds.isEmpty) {
              return const Center(
                  child: Text(
                "No favorite sounds found.",
                style: TextStyle(color: Colors.white),
              ));
            }

            return ListView.builder(
              itemCount: favoriteSounds.length,
              itemBuilder: (context, index) {
                final sound = favoriteSounds[index];

                return ListTile(
                  tileColor: Colors.white12,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  contentPadding: EdgeInsets.zero,
                  leading: const Icon(Icons.music_note, color: Colors.white),
                  title: Text(
                    sound.soundName,
                    style: const TextStyle(color: Colors.white),
                  ),
                  trailing: FittedBox(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        // Play/Pause Button
                        GestureDetector(
                          onTap: () async {
                            RecentPlayingSoundModel recentSoundListElement =
                                RecentPlayingSoundModel(
                              soundName: sound.soundName,
                              path: sound.path,
                              playing: false,
                            );

                            if (globalController.selectedSoundCategory.value ==
                                'Mixes') {
                              mediaPlayerController.currentPlayingSoundName
                                  .value = 'Playing Mixes';
                              // add multiple sounds in list
                              Get.log('added');

                              // now in this
                              // if this sound is already present in list
                              if (mediaPlayerController.recentSounds
                                      .contains(recentSoundListElement) &&
                                  mediaPlayerController.isSoundPlayingByName(
                                      soundName:
                                          recentSoundListElement.soundName)) {
                                Get.log(
                                    'mixes sound is present in list and stopping the sound');
                                mediaPlayerController.stopSound(
                                    soundName:
                                        recentSoundListElement.soundName);
                              } else if (mediaPlayerController.recentSounds
                                      .contains(recentSoundListElement) &&
                                  !mediaPlayerController.isSoundPlayingByName(
                                      soundName:
                                          recentSoundListElement.soundName)) {
                                Get.log(
                                    'mixes sound is present in list and playing the sound');
                                mediaPlayerController.playSound(
                                    soundPath: recentSoundListElement.path,
                                    soundName:
                                        recentSoundListElement.soundName);
                              } else {
                                mediaPlayerController.recentSounds
                                    .add(recentSoundListElement);
                                Get.log('mixes sound is not present in list');
                                // play the sound
                                mediaPlayerController.playSound(
                                    soundPath: recentSoundListElement.path,
                                    soundName:
                                        recentSoundListElement.soundName);
                              }
                            } else {
                              // first clear list then add
                              mediaPlayerController.currentPlayingSoundName
                                  .value = sound.soundName;
                              if (mediaPlayerController.recentSounds
                                      .contains(recentSoundListElement) &&
                                  mediaPlayerController.isSoundPlayingByName(
                                      soundName:
                                          recentSoundListElement.soundName)) {
                                Get.log(
                                    'single sound is present in list and stopping the sound');
                                mediaPlayerController.stopSound(
                                    soundName:
                                        recentSoundListElement.soundName);
                              } else if (mediaPlayerController.recentSounds
                                      .contains(recentSoundListElement) &&
                                  !mediaPlayerController.isSoundPlayingByName(
                                      soundName:
                                          recentSoundListElement.soundName)) {
                                Get.log(
                                    'single sound is present in list and playing the sound');
                                mediaPlayerController.playSound(
                                    soundPath: recentSoundListElement.path,
                                    soundName:
                                        recentSoundListElement.soundName);
                              } else {
                                // play the sound
                                Get.log('clear and added');
                                mediaPlayerController.recentSounds.clear();
                                mediaPlayerController.recentSounds
                                    .add(recentSoundListElement);
                                Get.log('single sound is not present in list');
                                mediaPlayerController.playSound(
                                    soundPath: recentSoundListElement.path,
                                    soundName:
                                        recentSoundListElement.soundName);
                              }
                            }
                          },
                          child: Obx(() {
                            return Icon(
                              mediaPlayerController.isSoundPlayingByName(
                                      soundName: sound.soundName)
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
                            favoriteSoundController.removeSoundFromFavorites(
                                sound.soundName, sound.path);
                            mediaPlayerController.stopAllSounds();
                            // mediaPlayerController.recentSounds.removeAt(index);
                            // mediaPlayerController.audioPlayers.removeAt(index);

                            // Remove sound from the list
                          },
                          child: const Icon(
                            Icons.favorite,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }),
        ),
      ),
    );
  }
}
