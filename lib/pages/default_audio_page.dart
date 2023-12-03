import 'package:flutter/material.dart';
import 'package:flutter_music_app/constants/audio_file.dart';
import 'package:flutter_music_app/constants/color_pallet.dart' as AppColors;
import 'package:audioplayers/audioplayers.dart';


class DefaultAudioPage extends StatefulWidget {
  const DefaultAudioPage({super.key});

  @override
  State<DefaultAudioPage> createState() => _DefaultAudioPageState();
}

class _DefaultAudioPageState extends State<DefaultAudioPage> {
  late AudioPlayer advancedPlayer;

  @override
  void initState() {
    super.initState();
    advancedPlayer = AudioPlayer();
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColors.audioBluishBakground,
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: screenHeight / 4,
            child: Container(
              color: AppColors.audioBlueBakground,
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: AppBar(
              leading: IconButton(
                icon: const Icon(Icons.arrow_back_ios),
                onPressed: () {},
              ),
              actions: [
                IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {},
                ),
              ],
              backgroundColor: Colors.transparent,
              elevation: 0.0,
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            top: screenHeight * 0.2,
            height: screenHeight * 0.36,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
                color: Colors.white,
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: screenHeight * 0.1,
                  ),
                  const Text(
                    "WARNING WARNING ",
                    style: TextStyle(
                      fontFamily: "Avenir",
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  const Text(
                    "Pious Demon",
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                  AudioFile(advancedPlayer:advancedPlayer)
                ],
              ),
            ),
          ),
          Positioned(
            top: screenHeight * 0.12,
            height: screenHeight * 0.15,
            left: (screenWidth - 150) / 2,
            right: (screenWidth - 150) / 2,
            child: Container(
              decoration: BoxDecoration(
                  color: AppColors.audioGreyBakground,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.white, width: 2)),
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Container(
                  decoration: BoxDecoration(
                    // borderRadius: BorderRadius.circular(20),
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 4),
                    image: const DecorationImage(
                        image: AssetImage("assets/cover.jpg"),
                        fit: BoxFit.cover),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
