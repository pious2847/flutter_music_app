// music_player_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_music_app/pages/audio_player_provider.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:file_picker/file_picker.dart';
import 'package:provider/provider.dart';

class MusicPlayerScreen extends StatefulWidget {
  const MusicPlayerScreen({super.key});

  @override
  _MusicPlayerScreenState createState() => _MusicPlayerScreenState();
}

class _MusicPlayerScreenState extends State<MusicPlayerScreen> {
  late AudioPlayerProvider audioPlayerProvider;
  String albumArtPath = 'assets/cover.jpg';

 @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    audioPlayerProvider = Provider.of<AudioPlayerProvider>(context);
  }

  void loadMusic() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.audio,
      allowMultiple: true,
    );

    if (result != null) {
      List<String> musicFiles = result.paths.map((path) => path ?? "").toList();
      audioPlayerProvider.loadMusic(musicFiles);
    }
  }

  void playMusic() {
    audioPlayerProvider.playMusic();
  }

  void pauseMusic() {
    audioPlayerProvider.pauseMusic();
  }

  void seek(Duration duration) {
    audioPlayerProvider.seek(duration);
  }

  void seekToPrevious() {
    audioPlayerProvider.seekToPrevious();
  }

  void seekToNext() {
    audioPlayerProvider.seekToNext();
  }

  void uploadPaths() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: [
        'mp3',
        'wav',
        'flac'
      ], // Add more extensions if needed
      allowMultiple: true,
    );

    if (result != null) {
      List<String> newMusicFiles =
          result.paths.map((path) => path ?? "").toList();

      for (String newMusicFile in newMusicFiles) {
        await audioPlayerProvider.player.setFilePath(newMusicFile);
      }

      setState(() {
        audioPlayerProvider.loaded = true;
      });

      print("Music paths uploaded!");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Spacer(
            flex: 2,
          ),
          Image.asset(
            albumArtPath,
            height: 300,
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: StreamBuilder(
              stream: audioPlayerProvider.player.positionStream,
              builder: (context, snapshot1) {
                final Duration duration = audioPlayerProvider.loaded
                    ? snapshot1.data ?? const Duration(seconds: 0)
                    : const Duration(seconds: 0);
                return StreamBuilder(
                  stream: audioPlayerProvider.player.bufferedPositionStream,
                  builder: (context, snapshot2) {
                    final Duration bufferedDuration = audioPlayerProvider.loaded
                        ? snapshot2.data ??
                            const Duration(seconds: 0)
                        : const Duration(seconds: 0);
                    return SizedBox(
                      height: 30,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: ProgressBar(
                          progress: duration,
                          total: audioPlayerProvider.player.duration ??
                              const Duration(seconds: 0),
                          buffered: bufferedDuration,
                          timeLabelPadding: -1,
                          timeLabelTextStyle: const TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                          ),
                          progressBarColor: Colors.red,
                          baseBarColor: Colors.grey[200],
                          bufferedBarColor: Colors.grey[350],
                          thumbColor: Colors.red,
                          onSeek: audioPlayerProvider.loaded
                              ? (duration) async {
                                  await audioPlayerProvider.player
                                      .seek(duration);
                                }
                              : null,
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const SizedBox(
                width: 10,
              ),
              IconButton(
                onPressed: audioPlayerProvider.loaded ? seekToPrevious : null,
                icon: const Icon(Icons.skip_previous),
              ),
              IconButton(
                onPressed: audioPlayerProvider.loaded
                    ? () async {
                        if (audioPlayerProvider.player.position.inSeconds >=
                            10) {
                          await audioPlayerProvider.player.seek(Duration(
                              seconds: audioPlayerProvider
                                      .player.position.inSeconds -
                                  10));
                        } else {
                          await audioPlayerProvider.player
                              .seek(const Duration(seconds: 0));
                        }
                      }
                    : null,
                icon: const Icon(Icons.fast_rewind_rounded),
              ),
              Container(
                height: 50,
                width: 50,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.red,
                ),
                child: IconButton(
                  onPressed: audioPlayerProvider.loaded
                      ? () {
                          if (audioPlayerProvider.playing) {
                            pauseMusic();
                          } else {
                            playMusic();
                          }
                        }
                      : null,
                  icon: Icon(
                    audioPlayerProvider.playing
                        ? Icons.pause
                        : Icons.play_arrow,
                    color: Colors.white,
                  ),
                ),
              ),
              IconButton(
                onPressed: audioPlayerProvider.loaded
                    ? () async {
                        if (audioPlayerProvider.player.position.inSeconds +
                                10 <=
                            audioPlayerProvider.player.duration!.inSeconds) {
                          await audioPlayerProvider.player.seek(Duration(
                              seconds: audioPlayerProvider
                                      .player.position.inSeconds +
                                  10));
                        } else {
                          await audioPlayerProvider.player
                              .seek(const Duration(seconds: 0));
                        }
                      }
                    : null,
                icon: const Icon(Icons.fast_forward_rounded),
              ),
              IconButton(
                onPressed: audioPlayerProvider.loaded ? seekToNext : null,
                icon: const Icon(Icons.skip_next),
              ),
              const SizedBox(
                width: 10,
              ),
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // ... Your existing buttons ...

              FloatingActionButton(
                onPressed: uploadPaths,
                tooltip: 'Upload Paths',
                child: const Icon(Icons.upload),
              ),
            ],
          ),
          const Spacer(
            flex: 2,
          ),
        ],
      ),
    );
  }
}
