import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:sleeping_app/packages.dart';

class MediaPlayerController extends GetxController {
  RxList<AudioPlayer> audioPlayers =
      <AudioPlayer>[].obs; // To track multiple audio players
  Rx<Duration> currentPosition = Duration.zero.obs;
  Rx<Duration> totalDuration = Duration.zero.obs;
  RxString currentPlayingSound = ''.obs;
  RxString currentPlayingSoundName = ''.obs;
  RxDouble volume = 1.0.obs;
  RxBool soundPauseByLifeCycle = false.obs;
  RxBool soundTimerSet = false.obs;
  RxDouble soundTimer = 0.0.obs;

  RxList<RecentPlayingSoundModel> recentSounds =
      <RecentPlayingSoundModel>[].obs;

  @override
  void onInit() {
    super.onInit();

    // // Listen for position and duration updates for the main audio player
    // audioPlayer.onDurationChanged.listen((Duration d) {
    //   totalDuration.value = d;
    // });
    //
    // audioPlayer.onPositionChanged.listen((Duration p) {
    //   currentPosition.value = p;
    // });
  }

  // function for timer set and stop the sound
  startSoundTimer({required int timerValue}) {
    soundTimer.value = timerValue.toDouble();
    Get.log('sound timer set for $timerValue ');
    soundTimerSet.value = true;
    Get.snackbar('Alert', 'Timer set', backgroundColor: Colors.grey);
    Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      if (soundTimer.value > 0) {
        soundTimer.value--;
      } else {
        soundTimerSet.value = false;
        mediaPlayerController.stopAllSounds();
        timer.cancel();
        Get.log('sound timer completed');
      }
    });
  }

  // Function to update the playing status of a sound

  void updatePlayingStatus(
      {required String soundName, required bool isPlaying}) {
    int index =
        recentSounds.indexWhere((element) => element.soundName == soundName);
    if (index != -1) {
      recentSounds[index] = RecentPlayingSoundModel(
        soundName: recentSounds[index].soundName,
        path: recentSounds[index].path,
        playing: isPlaying,
      );
      Get.log(
          'Sound with name "$soundName" is ${isPlaying ? "playing" : "stopped"}');
    }
  }

  // Function to play a single sound
  playSound({required String soundPath, required String soundName}) async {
    final int index =
        recentSounds.indexWhere((sound) => sound.soundName == soundName);
    Get.log('index: $index');

    if (index == -1) {
      Get.snackbar('Alert', 'Sound not found', backgroundColor: Colors.red);
      return;
    }

    if (soundPath.isNotEmpty) {
      if (audioPlayers.isNotEmpty && audioPlayers.length > index) {
        AudioPlayer existingPlayer = audioPlayers[index];

        if (existingPlayer.source == soundPath &&
            existingPlayer.state == PlayerState.playing) {
          Get.log('Sound is already playing');
          return;
        }

        try {
          await existingPlayer.setSourceAsset(soundPath);
          existingPlayer.setReleaseMode(ReleaseMode.loop);
          existingPlayer.play(AssetSource(soundPath));
        } catch (e) {
          Get.snackbar('Error', 'Failed to play sound: ${e.toString()}');
          Get.log('Error: ${e.toString()}');
        }

        Get.log('Playing sound at index: $index');

        updatePlayingStatus(soundName: soundName, isPlaying: true);
      } else {
        Get.log('Creating a new AudioPlayer for the sound');

        AudioPlayer newAudioPlayer = AudioPlayer();

        try {
          await newAudioPlayer.setSourceAsset(soundPath);
          newAudioPlayer.setReleaseMode(ReleaseMode.loop);
          newAudioPlayer.play(AssetSource(soundPath));
        } catch (e) {
          Get.snackbar('Error', 'Failed to play sound: ${e.toString()}');
          Get.log('Error: ${e.toString()}');
        }
        audioPlayers.add(newAudioPlayer);

        currentPlayingSound.value = soundPath;
        currentPlayingSoundName.value = soundName;

        updatePlayingStatus(soundName: soundName, isPlaying: true);
      }
    } else {
      Get.snackbar('Alert', 'Please select a sound first',
          backgroundColor: Colors.red);
    }
  }

  // Function to stop the current sound
  stopSound({required String soundName}) {
    for (int i = 0; i < recentSounds.length; i++) {
      if (recentSounds[i].soundName == soundName) {
        audioPlayers[i].stop();
        Get.log('stopping sound at:$i');
        updatePlayingStatus(soundName: soundName, isPlaying: false);
        break;
      }
    }
  }

  // Function to play all sounds simultaneously
  playAllSounds() async {
    if (recentSounds.isEmpty) {
      Get.snackbar('Alert', 'No sounds available to play',
          backgroundColor: Colors.red);
      return;
    }

    for (int i = 0; i < recentSounds.length; i++) {
      var sound = recentSounds[i];

      if (!sound.playing) {
        Get.log('Playing sound path: ${sound.path}');

        // Create a new AudioPlayer for each sound to play sequentially
        final AudioPlayer newAudioPlayer = AudioPlayer();

        currentPlayingSound.value = sound.path;
        currentPlayingSoundName.value = sound.soundName;

        // Set source and play sound after a 1-second delay for each sound
        await Future.delayed(const Duration(
            milliseconds: 500)); // Delay of 1 second for each sound

        await newAudioPlayer.setSourceAsset(currentPlayingSound.value);
        newAudioPlayer.setReleaseMode(ReleaseMode.loop);
        newAudioPlayer.play(AssetSource(currentPlayingSound.value));

        // Add the new AudioPlayer to the list
        audioPlayers.add(newAudioPlayer);

        // Update the playing status for that sound
        updatePlayingStatus(
          soundName: currentPlayingSoundName.value,
          isPlaying: true,
        );
      }
    }
  }

  // Function to stop all sounds that are playing
  stopAllSounds() {
    for (var player in audioPlayers) {
      player.stop();
    }
    for (var sound in recentSounds) {
      Get.log('stopping playing sound path : ${sound.path}');
      currentPlayingSound.value = sound.path;
      currentPlayingSoundName.value = sound.soundName;
      updatePlayingStatus(
        soundName: currentPlayingSoundName.value,
        isPlaying: false,
      );
    }
  }

  // Function to check if any sound is playing
  bool isAnySoundPlaying() {
    return recentSounds.any((sound) => sound.playing);
  }

  // Function to check if a sound is playing by index
  bool isSoundPlayingAtIndex({required int index}) {
    if (index >= 0 && index < recentSounds.length) {
      return recentSounds[index].playing;
    } else {
      return false;
    }
  }

  bool isSoundPlayingByName({required String soundName}) {
    try {
      // Find the sound by its name
      final sound = recentSounds.firstWhere(
        (sound) => sound.soundName == soundName,
      );

      // Return whether the sound is playing
      return sound.playing;
    } catch (e) {
      // If no sound is found with the name, return false
      return false;
    }
  }
}

// Recent playing sound model
class RecentPlayingSoundModel {
  String soundName;
  String path;
  bool playing;

  RecentPlayingSoundModel({
    required this.soundName,
    required this.path,
    required this.playing,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is RecentPlayingSoundModel &&
        other.soundName == soundName &&
        other.path == path;
  }

  @override
  int get hashCode => soundName.hashCode ^ path.hashCode;
}
