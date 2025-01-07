import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sleeping_app/constants.dart';
import 'package:sleeping_app/provider/sound_player_controller.dart';
import 'dart:math' as math;

class SingleSoundBox extends StatefulWidget {
  final String text;
  final IconData icon;
  final bool isPaid;
  final VoidCallback onTap;
  final bool isPlaying;
  final VoidCallback toggleAnimation;
  final String filePath;
  final Color iconColor;
  final bool multipleSounds;
  final String fileName;

  const SingleSoundBox(
      {Key? key,
      required this.text,
      required this.icon,
      required this.isPaid,
      required this.onTap,
      required this.isPlaying,
      required this.toggleAnimation,
      required this.filePath,
      this.iconColor = Colors.white,
      required this.multipleSounds,
      required this.fileName})
      : super(key: key);

  @override
  State<SingleSoundBox> createState() => _SingleSoundBoxState();
}

class _SingleSoundBoxState extends State<SingleSoundBox>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  // late AudioPlayer _audioPlayer;
  // final soundController = Get.find<SoundPlayerController>();

  @override
  void initState() {
    super.initState();
    //  _audioPlayer = AudioPlayer();
    _controller = AnimationController(
      animationBehavior: AnimationBehavior.normal,
      vsync: this,
      duration: const Duration(seconds: 12),
      reverseDuration: const Duration(seconds: 12),
    );

    _controller.repeat(reverse: false); // Start the animation

    if (mediaPlayerController.isSoundPlayingByName(
        soundName: widget.fileName)) {
      _controller.repeat();
    }
  }

  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  //   if (soundController.isSoundPlaying(widget.filePath)) {
  //     if (!_controller.isAnimating) {
  //       _controller.repeat();
  //     }
  //   } else {
  //     _controller.stop();
  //     _controller.reset();
  //   }
  // }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  Color getIconColor() {
    if (mediaPlayerController.isSoundPlayingByName(
        soundName: widget.fileName)) {
      return Colors.yellow.shade400; // Playing color
    } else if (mediaPlayerController.isSoundPlayingByName(
        soundName: widget.fileName)) {
      return Colors.yellow.shade600; // Paused color
    }
    return Colors.white; // Default color
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        // if (!widget.multipleSounds) {
        // //  soundController.stopAllSounds();
        //   _controller.stop();
        //   _controller.reset();
        //   setState(() {});
        // }
        widget.onTap();
        // await soundController.toggleSound(widget.filePath, widget.text);
        // if (soundController.isSoundPlaying(widget.filePath)) {
        //   _controller.repeat();
        // } else {
        //   _controller.stop();
        //   _controller.reset();
        // }
        setState(() {});
      },
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Transform.rotate(
            angle: mediaPlayerController.isSoundPlayingByName(
                    soundName: widget.fileName)
                ? math.sin(_controller.value * 2 * math.pi)
                : 0, // Rotate animation

            child: Column(
              children: [
                Stack(
                  children: [
                    Container(
                      height: 65,
                      width: 70,
                      margin: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        boxShadow: mediaPlayerController.isSoundPlayingByName(
                                soundName: widget.fileName)
                            ? [
                                BoxShadow(
                                  color: Colors.yellow.withOpacity(0.1),
                                  spreadRadius: 5,
                                  blurRadius: 7,
                                  offset: const Offset(0, 3),
                                ),
                              ]
                            : null,
                        gradient: const LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Color(0xFFD2B48C), // Light Tan
                            Color.fromARGB(255, 219, 120, 20), // Warm Brown
                          ],
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Icon(
                        widget.icon,
                        size: 37,
                        color: getIconColor(),
                      ),
                    ),
                    if (widget.isPaid)
                      const Positioned(
                        top: 3,
                        right: 3,
                        child: CircleAvatar(
                          radius: 12.5,
                          backgroundColor: Colors.blue,
                          child: Icon(
                            Icons.lock,
                            color: Colors.white,
                            size: 13,
                          ),
                        ),
                      ),
                  ],
                ),
                Flexible(
                  child: Text(
                    widget.text,
                    textAlign: TextAlign.center,
                    softWrap: true,
                    overflow: TextOverflow.visible,
                    style: const TextStyle(color: Colors.white, fontSize: 14),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
