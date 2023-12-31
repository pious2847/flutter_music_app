import 'package:flutter/material.dart';
import 'package:flutter_music_app/constants/AppConstants.dart';
import 'package:flutter_music_app/constants/bottom_navigator.dart';
import 'package:flutter_music_app/pages/audio_player_provider.dart';
import 'package:flutter_music_app/pages/music_player_screen.dart';
import 'package:flutter_music_app/pages/playlist_page.dart';
import 'package:flutter_music_app/pages/playlist_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MultiProvider(
        providers: [
          ChangeNotifierProvider<AudioPlayerProvider>(
            create: (context) => AudioPlayerProvider(),
          ),
          ChangeNotifierProvider<PlaylistProvider>(
            create: (context) => PlaylistProvider(),
          ),
          // Add other providers if needed
        ],
        child: const MainScreen(),
      ),
      debugShowCheckedModeBanner: false,
      title: "Music Player",
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const MusicPlayerScreen(),
    const PlaylistPage(),
    // Add more screens if needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _currentIndex == 0 ? AppConstants.home : AppConstants.playlist,
          style: const TextStyle(
            fontSize: 12,
          ),
        ),
      ),
      body: _screens[_currentIndex],
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: _currentIndex,
        onTabTapped: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
