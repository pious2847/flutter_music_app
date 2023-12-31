// audio_player_provider.dart

import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class AudioPlayerProvider extends ChangeNotifier {
  AudioPlayer player = AudioPlayer();
  bool loaded = false;
  bool playing = false;

  Future<void> loadMusic(List<String> musicFiles) async {
    player.stop();
    await player.setAudioSource(
      ConcatenatingAudioSource(
        children: musicFiles.map((musicFile) => AudioSource.uri(Uri.parse(musicFile))).toList(),
      ),
      initialIndex: 0,
      initialPosition: Duration.zero,
    );
    loaded = true;
    playing = false;
    notifyListeners();
  }

  void playMusic() {
    player.play();
    playing = true;
    notifyListeners();
  }

  void pauseMusic() {
    player.pause();
    playing = false;
    notifyListeners();
  }

  void seek(Duration duration) async {
    await player.seek(duration);
    notifyListeners();
  }

  void seekToPrevious() async {
    if (player.hasPrevious) {
      await player.seekToPrevious();
    }
  }

  void seekToNext() async {
    if (player.hasNext) {
      await player.seekToNext();
    }
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  
}
