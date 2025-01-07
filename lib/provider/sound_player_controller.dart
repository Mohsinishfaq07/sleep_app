import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

class SoundPlayerController extends GetxController {
  Timer? _shutdownTimer;
  var _isPlaying = <String, bool>{}.obs;
  var _players = <String, AudioPlayer>{}.obs;
  var _currentPlaying = RxnString();
  var _currentSoundName = RxnString();
  var _currentSoundIndex = RxnInt();
  var playingSounds = <SoundDetails>[].obs;
  var _anyActiveSound = false.obs;
  Timer? _loopTimer;

  String? get currentSoundName => _currentSoundName.value;
  int? get currentSoundIndex => _currentSoundIndex.value;
  String? get currentPlaying => _currentPlaying.value;
  bool get anyActiveSound => _anyActiveSound.value;

  Future<void> stopAllSounds() async {
    for (var player in _players.values) {
      if (player.state == PlayerState.playing) {
        await player.stop();
      }
    }
    _isPlaying.clear();
    playingSounds.clear();
  }

  void scheduleStop(Duration duration) {
    _shutdownTimer?.cancel(); // Cancel any existing timer
    _shutdownTimer = Timer(duration, pauseAllSounds);
  }

  Future<void> setVolumeForSound(String filePath, double volume) async {
    var player = _players[filePath];
    if (player != null) {
      await player.setVolume(volume);
      playingSounds.firstWhere((sound) => sound.filePath == filePath).volume =
          volume;
    }
  }

  Future<void> toggleSound(String filePath, String soundName,
      [IconData? icon]) async {
    var player = _players[filePath];
    if (player == null) {
      player = AudioPlayer();
      _players[filePath] = player;
      player.onPlayerStateChanged.listen((state) {
        _isPlaying[filePath] = state == PlayerState.playing;
        if (state == PlayerState.completed) {
          _isPlaying[filePath] = false;
          playingSounds.removeWhere((sound) => sound.filePath == filePath);
        }
      });
    }

    final isCurrentlyPlaying = _isPlaying[filePath] ?? false;
    if (isCurrentlyPlaying) {
      await player.pause();
      _isPlaying[filePath] = false;
    } else {
      await player.setReleaseMode(ReleaseMode.loop);
      await player.play(AssetSource(filePath));
      _isPlaying[filePath] = true;
      if (!playingSounds.any((sound) => sound.filePath == filePath)) {
        playingSounds.add(
            SoundDetails(filePath: filePath, soundName: soundName, icon: icon));
      }
    }
  }

  AudioPlayer _getOrCreatePlayer(String filePath) {
    return _players.putIfAbsent(filePath, () => AudioPlayer());
  }

  bool isSoundPlaying(String filePath) {
    return _isPlaying[filePath] ?? false;
  }

  @override
  void onClose() {
    _loopTimer?.cancel();
    for (var player in _players.values) {
      player.dispose();
    }
    _players.clear();
    super.onClose();
  }

  Future<void> playAllSounds() async {
    for (var filePath in _players.keys) {
      if (!(_isPlaying[filePath] ?? false)) {
        await playSound(
            filePath,
            playingSounds
                .firstWhere((sound) => sound.filePath == filePath)
                .soundName);
      }
    }
  }

  Future<void> playSound(String filePath, String soundName,
      [IconData? icon]) async {
    final player = _getOrCreatePlayer(filePath);
    await player.play(AssetSource(filePath));
    _isPlaying[filePath] = true;
    playingSounds.add(SoundDetails(
        filePath: filePath, soundName: soundName, icon: icon, volume: 1.0));
  }

  Future<void> pauseAllSounds() async {
    for (var player in _players.values) {
      if (player.state == PlayerState.playing) {
        await player.pause();
      }
    }
  }

  bool isSoundPaused(String filePath) {
    return _players[filePath]?.state == PlayerState.paused;
  }

  void removeSound(String filePath) {
    if (_players.containsKey(filePath)) {
      _players[filePath]?.stop();
      _players.remove(filePath);
    }
    playingSounds.removeWhere((sound) => sound.filePath == filePath);
  }

  int get numberOfActiveSounds => _isPlaying.length;

  int get numberOfPlayingSounds =>
      _isPlaying.values.where((isPlaying) => isPlaying).length;

  Future<void> stopSound(String filePath) async {
    AudioPlayer? player = _players[filePath];
    if (player != null) {
      await player.stop();
      _players.remove(filePath);
      _isPlaying.remove(filePath);
      if (_currentPlaying.value == filePath) {
        _currentPlaying.value = null;
      }
      if (_players.isEmpty) {
        _anyActiveSound.value = false;
      }
    }
  }

  void setCurrentSound(String filePath, String soundName, IconData icon) {
    _currentPlaying.value = filePath;
    _currentSoundName.value = soundName;
  }

  var _closeAppOnTimerEnd = false.obs;

  bool get closeAppOnTimerEnd => _closeAppOnTimerEnd.value;

  void setCloseAppOnTimerEnd(bool value) {
    _closeAppOnTimerEnd.value = value;
    _saveCloseAppSetting(value);
  }

  Future<void> _saveCloseAppSetting(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('closeAppOnTimerEnd', value);
  }

  RxInt selectedCategoryIndex = (-1).obs; // -1 means no category is selected

  RxString currentCategory = 'All'.obs;
  RxInt currentIndex = 0.obs;
  final AudioPlayer audioPlayer = AudioPlayer();
  var isPlaying = false.obs;
  var currentSoundPath = ''.obs;

  // Method to play/pause the audio
  void togglePlayPause(String soundPath) async {
    if (isPlaying.value && currentSoundPath.value == soundPath) {
      await audioPlayer.stop();
      isPlaying.value = false;
      currentSoundPath.value = '';
    } else {
      if (currentSoundPath.value != soundPath) {
        await audioPlayer.stop();
      }
      await audioPlayer.play(UrlSource(soundPath));
      isPlaying.value = true;
      currentSoundPath.value = soundPath;
    }
  }

  Rx<Duration> currentPosition = Duration.zero.obs;
  Rx<Duration> totalDuration = Duration.zero.obs;
}

class SoundDetails {
  String filePath;
  String soundName;
  IconData? icon;
  double volume;

  SoundDetails({
    required this.filePath,
    required this.soundName,
    this.icon,
    this.volume = 1.0,
  });
}
