import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class AudioFile extends StatefulWidget {
  final AudioPlayer advancedPlayer;

  const AudioFile({super.key, required this.advancedPlayer});

  @override
  State<AudioFile> createState() => _AudioFileState();
}

class _AudioFileState extends State<AudioFile> {
  Duration _duration = new Duration();
  Duration _position = new Duration();
  final String path = "https://st.bslmeiy.com/uploads/%e6%9c%97%e6%98%";
  bool isPlaying = false;
  bool isPaused = false;
  bool isLoop = false;
  final List<IconData> _icons = [
    Icons.play_circle_fill,
    Icons.pause_circle_filled
  ];

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
