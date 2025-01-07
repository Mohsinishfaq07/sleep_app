import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:sleeping_app/packages.dart';

class FavSoundModel {
  String soundName;
  String path;
  bool playing;
  bool favorite;

  FavSoundModel(
      {required this.soundName,
      required this.path,
      required this.playing,
      required this.favorite});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is FavSoundModel &&
        other.soundName == soundName &&
        other.path == path;
  }

  @override
  int get hashCode => soundName.hashCode ^ path.hashCode;
}

class FavoriteSoundController extends GetxController {
  // List to store favorite sound names and paths
  RxList<FavSoundModel> favoriteSounds = <FavSoundModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    // Load favorite sounds from SharedPreferences when the controller is initialized
    _loadFavoriteSounds();
  }

  // Load favorite sounds from SharedPreferences
  Future<void> _loadFavoriteSounds() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String>? storedFavorites =
        prefs.getStringList('favorite_sounds');

    if (storedFavorites != null) {
      favoriteSounds.value = storedFavorites.map((sound) {
        final parts = sound.split('|');
        return FavSoundModel(
          soundName: parts[0],
          path: parts[1],
          playing: false, // Initially not playing
          favorite:
              true, // All sounds loaded from favorites are considered favorites
        );
      }).toList();
    }
  }

  // Add a sound to favorites
  Future<void> addSoundToFavorites(String soundName, String soundPath) async {
    if (!favoriteSounds.any(
        (sound) => sound.soundName == soundName && sound.path == soundPath)) {
      final newSound = FavSoundModel(
        soundName: soundName,
        path: soundPath,
        playing: false,
        favorite: true,
      );
      favoriteSounds.add(newSound);

      // Save updated favorites to SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      final favoriteStrings = favoriteSounds
          .map((sound) =>
              '${sound.soundName}|${sound.path}') // Store as name|path
          .toList();
      await prefs.setStringList('favorite_sounds', favoriteStrings);

      Get.snackbar('Success', '$soundName added to favorites!',
          backgroundColor: Colors.grey);
    } else {
      Get.snackbar('Already Favorite', '$soundName is already in favorites.',
          backgroundColor: Colors.grey);
    }
  }

  // Remove a sound from favorites
  Future<void> removeSoundFromFavorites(
      String soundName, String soundPath) async {
    final soundToRemove = favoriteSounds.firstWhere(
      (sound) => sound.soundName == soundName && sound.path == soundPath,
      orElse: () => FavSoundModel(
          soundName: '', path: '', playing: false, favorite: false),
    );

    if (soundToRemove.soundName.isNotEmpty) {
      favoriteSounds.remove(soundToRemove);

      // Save updated favorites to SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      final favoriteStrings = favoriteSounds
          .map((sound) =>
              '${sound.soundName}|${sound.path}') // Store as name|path
          .toList();
      await prefs.setStringList('favorite_sounds', favoriteStrings);

      Get.snackbar('Removed', '$soundName removed from favorites!',
          backgroundColor: Colors.grey);
    } else {
      Get.snackbar('Not in Favorites', '$soundName is not in your favorites.',
          backgroundColor: Colors.grey);
    }
  }

  // Check if a sound is in favorites
  bool isSoundFavorite(String soundName, String soundPath) {
    return favoriteSounds.any(
        (sound) => sound.soundName == soundName && sound.path == soundPath);
  }

  // Clear all favorites (optional)
  Future<void> clearAllFavorites() async {
    favoriteSounds.clear();

    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('favorite_sounds');

    Get.snackbar('Favorites Cleared', 'All favorite sounds have been removed.');
  }
}
