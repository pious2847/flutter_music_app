import 'package:flutter/material.dart';

class PlaylistProvider extends ChangeNotifier {
  List<String> _playlist = [];

  List<String> get playlist => _playlist;

  void updatePlaylist(List<String> newPlaylist) {
    _playlist = newPlaylist;
    notifyListeners();
  }
}
