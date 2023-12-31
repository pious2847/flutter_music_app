import 'package:flutter/material.dart';
import 'package:flutter_music_app/constants/AppConstants.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  final Function(int) onTabTapped;
  final int currentIndex;

  const CustomBottomNavigationBar({super.key, 
    required this.onTabTapped,
    required this.currentIndex,
  });

  @override
  _CustomBottomNavigationBarState createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState
    extends State<CustomBottomNavigationBar> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: widget.currentIndex,
      onTap: widget.onTabTapped,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: AppConstants.home,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.library_music),
          label: AppConstants.playlist,
        ),
        // Add more BottomNavigationBarItems if needed
      ],
    );
  }
}
