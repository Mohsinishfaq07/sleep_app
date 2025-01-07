import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

const String appName = "Sleep Mingle";
List<Map<String, dynamic>> soundData = [
  {
    'name': 'Air Travel',
    'icon': CupertinoIcons.airplane,
    'isPaid': false,
    'filePath': 'sounds/Air Travel.MP3',
  },
  {
    'name': 'Ocean',
    'icon': FontAwesomeIcons.water,
    'isPaid': false,
    'filePath': 'sounds/Ocean.MP3'
  },
  {
    'name': 'Airplane In Flight',
    'icon': Icons.flight_takeoff,
    'isPaid': true,
    'filePath': 'sounds/Airplane In Flight.MP3'
  },
  {
    'name': 'Electric Razor',
    'icon': Icons.edgesensor_low_sharp,
    'isPaid': false,
    'filePath': 'sounds/Electric Razor.mp3'
  },
  {
    'name': 'Air Conditioner',
    'icon': FontAwesomeIcons.airFreshener,
    'isPaid': true,
    'filePath': 'sounds/Air conditioner.mp3'
  },
  // {'name': 'Airplane', 'icon': Icons.airplanemode_active, 'isPaid': false,'filePath': 'Airplane.MP3'},
  {
    'name': 'Bamboo Rustling',
    'icon': FontAwesomeIcons.treeCity,
    'isPaid': true,
    'filePath': 'sounds/Bamboo Rustling.mp3'
  },
  {
    'name': 'Binaural',
    'icon': Icons.headphones,
    'isPaid': false,
    'filePath': 'sounds/Binaural.mp3'
  },
  {
    'name': 'Bird',
    'icon': FontAwesomeIcons.twitter,
    'isPaid': false,
    'filePath': 'sounds/Bird.MP3'
  },
  {
    'name': 'Bird 2',
    'icon': FontAwesomeIcons.twitter,
    'isPaid': true,
    'filePath': 'sounds/Bird 2.MP3'
  },
  {
    'name': 'Blender',
    'icon': Icons.kitchen,
    'isPaid': false,
    'filePath': 'sounds/Blender.mp3'
  },
  {
    'name': 'Boat Speeding',
    'icon': Icons.directions_boat,
    'isPaid': false,
    'filePath': 'sounds/Boat Speeding.mp3'
  },
  {
    'name': 'Brown Noise',
    'icon': Icons.graphic_eq,
    'isPaid': true,
    'filePath': 'sounds/Brown Noise.MP3'
  },
  {
    'name': 'Buzzing Light',
    'icon': Icons.highlight,
    'isPaid': false,
    'filePath': 'sounds/Buzzing Light.mp3'
  },
  {
    'name': 'Cafe',
    'icon': Icons.restaurant,
    'isPaid': true,
    'filePath': 'sounds/Cafe.MP3'
  },
  {
    'name': 'Car',
    'icon': Icons.directions_car,
    'isPaid': true,
    'filePath': 'sounds/Car.MP3'
  },
  {
    'name': 'Car Passing',
    'icon': FontAwesomeIcons.car,
    'isPaid': false,
    'filePath': 'sounds/Car Passing.MP3'
  },
  {
    'name': 'Cat Purring',
    'icon': FontAwesomeIcons.cat,
    'isPaid': false,
    'filePath': 'sounds/Cat Purring.MP3'
  },
  {
    'name': 'Cave',
    'icon': Icons.landscape,
    'isPaid': false,
    'filePath': 'sounds/Cave.MP3'
  },
  {
    'name': 'Cicada',
    'icon': FontAwesomeIcons.locust,
    'isPaid': false,
    'filePath': 'sounds/Cicada.MP3'
  },
  {
    'name': 'Clock',
    'icon': Icons.access_time,
    'isPaid': true,
    'filePath': 'sounds/Clock.MP3'
  },
  {
    'name': 'Construction',
    'icon': Icons.construction,
    'isPaid': false,
    'filePath': 'sounds/Construction.MP3'
  },
  {
    'name': 'Creaking Ship',
    'icon': Icons.directions_boat,
    'isPaid': true,
    'filePath': 'sounds/Creaking Ship.mp3'
  },
  {
    'name': 'Creek',
    'icon': FontAwesomeIcons.water,
    'isPaid': false,
    'filePath': 'sounds/Creek.MP3'
  },
  {
    'name': 'Cricket',
    'icon': FontAwesomeIcons.campground,
    'isPaid': false,
    'filePath': 'sounds/Cricket.MP3'
  },
  {
    'name': 'Crowd',
    'icon': Icons.people_alt_outlined,
    'isPaid': false,
    'filePath': 'sounds/Crowd.MP3'
  },
  {
    'name': 'Desert',
    'icon': CupertinoIcons.brightness_solid,
    'isPaid': false,
    'filePath': 'sounds/Desert.MP3'
  },
  {
    'name': 'Didgeridoo',
    'icon': Icons.memory,
    'isPaid': false,
    'filePath': 'sounds/Didgeridoo.mp3'
  },
  {
    'name': 'Dishwasher',
    'icon': Icons.bubble_chart,
    'isPaid': true,
    'filePath': 'sounds/Dishwasher.mp3'
  },
  {
    'name': 'Dolphins',
    'icon': FontAwesomeIcons.fish,
    'isPaid': false,
    'filePath': 'sounds/Dolphins.mp3'
  },
  {
    'name': 'Dream',
    'icon': FontAwesomeIcons.goodreads,
    'isPaid': false,
    'filePath': 'sounds/Dream.mp3'
  },
  {
    'name': 'Drip',
    'icon': CupertinoIcons.add_circled_solid,
    'isPaid': false,
    'filePath': 'sounds/Drip.MP3'
  },
  {
    'name': 'Dryer',
    'icon': Icons.air,
    'isPaid': false,
    'filePath': 'sounds/Dryer.MP3'
  },
  {
    'name': 'Elephant',
    'icon': FontAwesomeIcons.elementor,
    'isPaid': false,
    'filePath': 'sounds/Elephant.mp3'
  },
  {
    'name': 'Fan',
    'icon': FontAwesomeIcons.fan,
    'isPaid': false,
    'filePath': 'sounds/Fan.MP3'
  },
  {
    'name': 'Farm',
    'icon': CupertinoIcons.slider_horizontal_below_rectangle,
    'isPaid': false,
    'filePath': 'sounds/Farm.MP3'
  },
  {
    'name': 'Fire',
    'icon': FontAwesomeIcons.fire,
    'isPaid': false,
    'filePath': 'sounds/Fire.MP3'
  },
  {
    'name': 'Flute',
    'icon': FontAwesomeIcons.bullhorn,
    'isPaid': true,
    'filePath': 'sounds/Flute.MP3'
  },
  {
    'name': 'Fog Horn',
    'icon': FontAwesomeIcons.hornbill,
    'isPaid': false,
    'filePath': 'sounds/Fog Horn.mp3'
  },
  {
    'name': 'Forest',
    'icon': FontAwesomeIcons.tree,
    'isPaid': false,
    'filePath': 'sounds/Forest.MP3'
  },
  {
    'name': 'Forest Stream',
    'icon': FontAwesomeIcons.treeCity,
    'isPaid': false,
    'filePath': 'sounds/Forest Stream.mp3'
  },
  {
    'name': 'Frog',
    'icon': FontAwesomeIcons.frog,
    'isPaid': true,
    'filePath': 'sounds/Frog.MP3'
  },
  {
    'name': 'Frog 2',
    'icon': FontAwesomeIcons.jugDetergent,
    'isPaid': false,
    'filePath': 'sounds/Frog 2.MP3'
  },
  {
    'name': 'Grandfather Clock',
    'icon': FontAwesomeIcons.clock,
    'isPaid': false,
    'filePath': 'soundsGrandfather Clock.mp3'
  },
  {
    'name': 'Grassland',
    'icon': Icons.grass,
    'isPaid': false,
    'filePath': 'sounds/Grassland.MP3'
  },
  {
    'name': 'Green Noise',
    'icon': Icons.hearing_sharp,
    'isPaid': true,
    'filePath': 'sounds/Green Noise.mp3'
  },
  {
    'name': 'Guitar',
    'icon': FontAwesomeIcons.guitar,
    'isPaid': false,
    'filePath': 'sounds/Guitar.MP3'
  },
  {
    'name': 'Guzheng',
    'icon': Icons.location_city,
    'isPaid': false,
    'filePath': 'sounds/Guzheng.MP3'
  },
  {
    'name': 'Hail',
    'icon': FontAwesomeIcons.cloudRain,
    'isPaid': false,
    'filePath': 'sounds/Hail.mp3'
  },
  {
    'name': 'Hair Drawer',
    'icon': FontAwesomeIcons.airFreshener,
    'isPaid': false,
    'filePath': 'sounds/Hair Dryer.MP3'
  },
  {
    'name': 'Harmony',
    'icon': Icons.computer,
    'isPaid': false,
    'filePath': 'sounds/Harmony.MP3'
  },
  {
    'name': 'Harmony sound',
    'icon': CupertinoIcons.tv_music_note,
    'isPaid': true,
    'filePath': 'sounds/Harmony_1.mp3'
  },
  {
    'name': 'Harp',
    'icon': FontAwesomeIcons.heartMusicCameraBolt,
    'isPaid': false,
    'filePath': 'sounds/Harp.MP3'
  },
  {
    'name': 'HeartBeat',
    'icon': FontAwesomeIcons.heartbeat,
    'isPaid': false,
    'filePath': 'sounds/Heart Beat.MP3'
  },
  {
    'name': 'Heavy Rain',
    'icon': CupertinoIcons.cloud_bolt_rain,
    'isPaid': false,
    'filePath': 'sounds/Heavy Rain.MP3'
  },
  {
    'name': 'Heavy Rain on tent',
    'icon': FontAwesomeIcons.cloudMoonRain,
    'isPaid': false,
    'filePath': 'sounds/Heavy Rain On Tent.mp3'
  },
  {
    'name': 'Hope for better',
    'icon': FontAwesomeIcons.usersBetweenLines,
    'isPaid': false,
    'filePath': 'sounds/Hope For Better.MP3'
  },
  {
    'name': 'Inspiration',
    'icon': Icons.graphic_eq,
    'isPaid': false,
    'filePath': 'sounds/Inspiration.mp3'
  },
  {
    'name': 'KeyBoard',
    'icon': Icons.keyboard_alt_outlined,
    'isPaid': false,
    'filePath': 'sounds/Keyboard.MP3'
  },
  {
    'name': 'Lake',
    'icon': Icons.train,
    'isPaid': false,
    'filePath': 'sounds/Lake.MP3'
  },
  {
    'name': 'Lawn Mower',
    'icon': FontAwesomeIcons.shirt,
    'isPaid': false,
    'filePath': 'sounds/Lawn Mower.mp3'
  },
  {
    'name': 'Leaf Blower',
    'icon': FontAwesomeIcons.plantWilt,
    'isPaid': false,
    'filePath': 'sounds/Leaf Blower.mp3'
  },
  {
    'name': 'Light Rain',
    'icon': Icons.location_city,
    'isPaid': true,
    'filePath': 'sounds/Light Rain.MP3'
  },
  {
    'name': 'Lion Roar',
    'icon': FontAwesomeIcons.wolfPackBattalion,
    'isPaid': false,
    'filePath': 'sounds/Lion Roar.mp3'
  },
  {
    'name': 'Look Within',
    'icon': CupertinoIcons.squares_below_rectangle,
    'isPaid': false,
    'filePath': 'sounds/Look Within.MP3'
  },
  {
    'name': 'Loon',
    'icon': FontAwesomeIcons.wolfPackBattalion,
    'isPaid': false,
    'filePath': 'sounds/Loon.MP3'
  },
  {
    'name': 'Lullabay',
    'icon': Icons.doorbell_outlined,
    'isPaid': false,
    'filePath': 'sounds/Lullabay.MP3'
  },
  {
    'name': 'Meditation Bell',
    'icon': FontAwesomeIcons.bellConcierge,
    'isPaid': false,
    'filePath': 'sounds/Meditation Bell.MP3'
  },
  {
    'name': 'Natural Thunder',
    'icon': FontAwesomeIcons.thunderstorm,
    'isPaid': true,
    'filePath': 'sounds/Natural Thunder.mp3'
  },
  {
    'name': 'Natural Waterfall',
    'icon': FontAwesomeIcons.bridgeWater,
    'isPaid': false,
    'filePath': 'sounds/Natural Waterfall.mp3'
  },
  {
    'name': 'Night',
    'icon': FontAwesomeIcons.chessKnight,
    'isPaid': false,
    'filePath': 'sounds/Night.MP3'
  },
  {
    'name': 'Ocean',
    'icon': Icons.sailing_outlined,
    'isPaid': false,
    'filePath': 'sounds/Ocean.MP3'
  },
  {
    'name': 'Owl',
    'icon': Icons.adb,
    'isPaid': false,
    'filePath': 'sounds/Owl.MP3'
  },
  {
    'name': 'Panting Dog',
    'icon': FontAwesomeIcons.paintbrush,
    'isPaid': true,
    'filePath': 'sounds/Panting Dog.mp3'
  },
  {
    'name': 'Peaceful',
    'icon': FontAwesomeIcons.peace,
    'isPaid': true,
    'filePath': 'sounds/Peacefull.mp3'
  },
  {
    'name': 'Piano',
    'icon': Icons.piano,
    'isPaid': false,
    'filePath': 'sounds/Piano.MP3'
  },
  {
    'name': 'Pink Noise',
    'icon': Icons.notification_important_sharp,
    'isPaid': true,
    'filePath': 'sounds/Pink Noise.MP3'
  },
  {
    'name': 'Pipe Organ',
    'icon': FontAwesomeIcons.piedPiper,
    'isPaid': false,
    'filePath': 'sounds/Pipe Organ.mp3'
  },
  {
    'name': 'Playground',
    'icon': FontAwesomeIcons.campground,
    'isPaid': false,
    'filePath': 'sounds/Playground.mp3'
  },
  {
    'name': 'Rain',
    'icon': FontAwesomeIcons.water,
    'isPaid': false,
    'filePath': 'sounds/Rain.MP3'
  },
  {
    'name': 'Rain on puddle',
    'icon': FontAwesomeIcons.cloudRain,
    'isPaid': false,
    'filePath': 'sounds/Rain On Puddle.MP3'
  },
  {
    'name': 'Rain on roof',
    'icon': CupertinoIcons.cloud_rain_fill,
    'isPaid': false,
    'filePath': 'sounds/Rain on Roof.mp3'
  },
  {
    'name': 'Rain on tent',
    'icon': CupertinoIcons.cloud_moon_rain_fill,
    'isPaid': false,
    'filePath': 'sounds/Rain on Tent.mp3'
  },
  {
    'name': 'Rain on Umbrella',
    'icon': CupertinoIcons.cloud_bolt_rain,
    'isPaid': false,
    'filePath': 'sounds/Rain on Umbrella.mp3'
  },
  {
    'name': 'Rain on window',
    'icon': CupertinoIcons.cloud_heavyrain,
    'isPaid': false,
    'filePath': 'sounds/Rain on window.mp3'
  },
  {
    'name': 'RainMusic',
    'icon': FontAwesomeIcons.cloudSunRain,
    'isPaid': false,
    'filePath': 'sounds/rain_music.mp3'
  },
  {
    'name': 'RainSound',
    'icon': FontAwesomeIcons.cloudRain,
    'isPaid': false,
    'filePath': 'sounds/rain_music1.mp3'
  },
  {
    'name': 'RainForest',
    'icon': FontAwesomeIcons.cloudMoonRain,
    'isPaid': false,
    'filePath': 'sounds/Rainforest.mp3'
  },
  {
    'name': 'Reflaction',
    'icon': FontAwesomeIcons.repeat,
    'isPaid': false,
    'filePath': 'sounds/Reflection.mp3'
  },
  {
    'name': 'Relaxing',
    'icon': Icons.bed,
    'isPaid': false,
    'filePath': 'sounds/Relaxing.mp3'
  },
  {
    'name': 'Seagull',
    'icon': FontAwesomeIcons.kiwiBird,
    'isPaid': false,
    'filePath': 'sounds/Seagull.MP3'
  },
  {
    'name': 'Siren',
    'icon': Icons.emergency_outlined,
    'isPaid': false,
    'filePath': 'sounds/Siren.mp3'
  },
  {
    'name': 'Snoring',
    'icon': FontAwesomeIcons.nairaSign,
    'isPaid': false,
    'filePath': 'sounds/Snoring.mp3'
  },
  {
    'name': 'Snow',
    'icon': FontAwesomeIcons.snowflake,
    'isPaid': false,
    'filePath': 'sounds/Snow.MP3'
  },
  {
    'name': 'Thunder',
    'icon': FontAwesomeIcons.thunderstorm,
    'isPaid': false,
    'filePath': 'sounds/Thunder.mp3'
  },
  {
    'name': 'Tibetan Bowl',
    'icon': Icons.rice_bowl_outlined,
    'isPaid': false,
    'filePath': 'sounds/Tibetan Bowl.mp3'
  },
  {
    'name': 'Train',
    'icon': FontAwesomeIcons.train,
    'isPaid': false,
    'filePath': 'sounds/Train.MP3'
  },
  {
    'name': 'Train Journey',
    'icon': FontAwesomeIcons.trainTram,
    'isPaid': false,
    'filePath': 'sounds/Train Journey.MP3'
  },
  {
    'name': 'Tropical Birds',
    'icon': FontAwesomeIcons.fly,
    'isPaid': false,
    'filePath': 'sounds/Tropical Birds.mp3'
  },
  {
    'name': 'Ukulele',
    'icon': CupertinoIcons.guitars,
    'isPaid': false,
    'filePath': 'sounds/Ukulele.mp3'
  },
  {
    'name': 'UnderWater',
    'icon': FontAwesomeIcons.arrowUpFromGroundWater,
    'isPaid': false,
    'filePath': 'sounds/Underwater.mp3'
  },
  {
    'name': 'Vacuum Cleaner',
    'icon': FontAwesomeIcons.vaadin,
    'isPaid': false,
    'filePath': 'sounds/Vacuum Cleaner.mp3'
  },
  {
    'name': 'Violin',
    'icon': CupertinoIcons.music_albums,
    'isPaid': false,
    'filePath': 'sounds/Violin.MP3'
  },
  {
    'name': 'Washing Machine',
    'icon': CupertinoIcons.macwindow,
    'isPaid': false,
    'filePath': 'sounds/Washing Machine.mp3'
  },
  {
    'name': 'Waterfall',
    'icon': FontAwesomeIcons.waterLadder,
    'isPaid': false,
    'filePath': 'sounds/Waterfall.MP3'
  },
  {
    'name': 'Whale',
    'icon': FontAwesomeIcons.fish,
    'isPaid': false,
    'filePath': 'sounds/Whale.MP3'
  },
  {
    'name': 'White Noise',
    'icon': FontAwesomeIcons.bellSlash,
    'isPaid': false,
    'filePath': 'sounds/White Noise.MP3'
  },
  {
    'name': 'Wind',
    'icon': FontAwesomeIcons.wind,
    'isPaid': false,
    'filePath': 'sounds/Wind.MP3'
  },
  {
    'name': 'Wind Chime',
    'icon': FontAwesomeIcons.bellSlash,
    'isPaid': false,
    'filePath': 'sounds/Wind Chime.MP3'
  },
  {
    'name': 'Wind Leaves',
    'icon': FontAwesomeIcons.leaf,
    'isPaid': false,
    'filePath': 'sounds/Wind Leaves.MP3'
  },
  {
    'name': 'Wiper',
    'icon': FontAwesomeIcons.wikipediaW,
    'isPaid': false,
    'filePath': 'sounds/Wiper.MP3'
  },
  {
    'name': 'Wolf',
    'icon': FontAwesomeIcons.dog,
    'isPaid': false,
    'filePath': 'sounds/Wolf.MP3'
  },
  {
    'name': 'Womb',
    'icon': FontAwesomeIcons.worm,
    'isPaid': false,
    'filePath': 'sounds/Womb.mp3'
  },
];

PageRoute createRightToLeftRoute(Widget page, RouteSettings settings) {
  return PageRouteBuilder(
    settings: settings,
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      var begin = const Offset(1.0, 0.0);
      var end = Offset.zero;
      var curve = Curves.easeInOut;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
      var offsetAnimation = animation.drive(tween);

      return SlideTransition(
        position: offsetAnimation,
        child: child,
      );
    },
    transitionDuration:
        const Duration(seconds: 1), // Slower transition duration
    reverseTransitionDuration: const Duration(
        seconds:
            1), // Optional: Adjust this if you want the reverse transition to have the same duration
  );
}

RxList<Map<String, String>> soundCategories = [
  {'name': 'Music', 'imagePath': 'assets/image/musiccc.PNG'},
  {'name': 'Mixes', 'imagePath': 'assets/image/breath.PNG'},
  {'name': 'Sound', 'imagePath': 'assets/image/musiccc.PNG'},
  {'name': 'SleepTales', 'imagePath': 'assets/image/meditation.PNG'},
  {'name': 'Breathe', 'imagePath': 'assets/image/mixes.jpeg'},
  {'name': 'Meditations', 'imagePath': 'assets/image/sleepTales.jpeg'},
  {'name': 'SleepMoves', 'imagePath': 'assets/image/mov.PNG'},
].obs;

// mixes sounds
List<Map<String, dynamic>?> mixesCategoryData = [
  {
    'name': 'Creaking Ship',
    'icon': Icons.directions_boat,
    'isPaid': true,
    'filePath': 'sounds/Creaking Ship.mp3'
  },
  {
    'name': 'Creek',
    'icon': FontAwesomeIcons.water,
    'isPaid': false,
    'filePath': 'sounds/Creek.MP3'
  },
  {
    'name': 'Cricket',
    'icon': FontAwesomeIcons.campground,
    'isPaid': false,
    'filePath': 'sounds/Cricket.MP3'
  },
  {
    'name': 'Crowd',
    'icon': Icons.people_alt_outlined,
    'isPaid': false,
    'filePath': 'sounds/Crowd.MP3'
  },
  {
    'name': 'Desert',
    'icon': CupertinoIcons.brightness_solid,
    'isPaid': false,
    'filePath': 'sounds/Desert.MP3'
  },
];

// music category
List<Map<String, dynamic>> musicCategoryData = [
  {
    'name': 'Air Travel',
    'icon': CupertinoIcons.airplane,
    'isPaid': false,
    'filePath': 'sounds/Air Travel.MP3',
  },
  {
    'name': 'Train',
    'icon': FontAwesomeIcons.train,
    'isPaid': false,
    'filePath': 'sounds/Train.MP3'
  },
  {
    'name': 'Train Journey',
    'icon': FontAwesomeIcons.trainTram,
    'isPaid': false,
    'filePath': 'sounds/Train Journey.MP3'
  },
];

// sound category
List<Map<String, dynamic>> soundCategoryData = [
  {
    'name': 'Bamboo Rustling',
    'icon': FontAwesomeIcons.treeCity,
    'isPaid': true,
    'filePath': 'sounds/Bamboo Rustling.mp3'
  },
  {
    'name': 'Binaural',
    'icon': Icons.headphones,
    'isPaid': false,
    'filePath': 'sounds/Binaural.mp3'
  },
  {
    'name': 'Bird',
    'icon': FontAwesomeIcons.twitter,
    'isPaid': false,
    'filePath': 'sounds/Bird.MP3'
  },
  {
    'name': 'Bird 2',
    'icon': FontAwesomeIcons.twitter,
    'isPaid': true,
    'filePath': 'sounds/Bird 2.MP3'
  },
  {
    'name': 'Blender',
    'icon': Icons.kitchen,
    'isPaid': false,
    'filePath': 'sounds/Blender.mp3'
  },
];

List<Map<String, dynamic>> sleepTalesData = [
  {
    'name': 'Ocean',
    'icon': FontAwesomeIcons.water,
    'isPaid': false,
    'filePath': 'sounds/Ocean.MP3'
  },
  {
    'name': 'Snoring',
    'icon': FontAwesomeIcons.nairaSign,
    'isPaid': false,
    'filePath': 'sounds/Snoring.mp3'
  },
  {
    'name': 'Snow',
    'icon': FontAwesomeIcons.snowflake,
    'isPaid': false,
    'filePath': 'sounds/Snow.MP3'
  },
  {
    'name': 'Thunder',
    'icon': FontAwesomeIcons.thunderstorm,
    'isPaid': false,
    'filePath': 'sounds/Thunder.mp3'
  },
];
List<Map<String, dynamic>> breatheData = [
  {
    'name': 'Womb',
    'icon': FontAwesomeIcons.worm,
    'isPaid': false,
    'filePath': 'sounds/Womb.mp3'
  },
  {
    'name': 'Tibetan Bowl',
    'icon': Icons.rice_bowl_outlined,
    'isPaid': false,
    'filePath': 'sounds/Tibetan Bowl.mp3'
  },
  {
    'name': 'Train',
    'icon': FontAwesomeIcons.train,
    'isPaid': false,
    'filePath': 'sounds/Train.MP3'
  },
];
List<Map<String, dynamic>> meditationData = [
  {
    'name': 'Wolf',
    'icon': FontAwesomeIcons.dog,
    'isPaid': false,
    'filePath': 'sounds/Wolf.MP3'
  },
  {
    'name': 'Washing Machine',
    'icon': CupertinoIcons.macwindow,
    'isPaid': false,
    'filePath': 'sounds/Washing Machine.mp3'
  },
  {
    'name': 'Waterfall',
    'icon': FontAwesomeIcons.waterLadder,
    'isPaid': false,
    'filePath': 'sounds/Waterfall.MP3'
  },
];
List<Map<String, dynamic>> sleepMoveData = [
  {
    'name': 'Wind Leaves',
    'icon': FontAwesomeIcons.leaf,
    'isPaid': false,
    'filePath': 'sounds/Wind Leaves.MP3'
  },
  {
    'name': 'Wind Chime',
    'icon': FontAwesomeIcons.bellSlash,
    'isPaid': false,
    'filePath': 'sounds/Wind Chime.MP3'
  },
  {
    'name': 'Wind Leaves',
    'icon': FontAwesomeIcons.leaf,
    'isPaid': false,
    'filePath': 'sounds/Wind Leaves.MP3'
  },
  {
    'name': 'Wiper',
    'icon': FontAwesomeIcons.wikipediaW,
    'isPaid': false,
    'filePath': 'sounds/Wiper.MP3'
  },
];

class GlobalController extends GetxController {
  RxString selectedSoundCategory = 'Music'.obs;

  RxString userName = ''.obs;
  RxString userOldPass = ''.obs;
  RxString userNewPass = ''.obs;
}
