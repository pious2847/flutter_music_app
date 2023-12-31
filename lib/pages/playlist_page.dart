import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_music_app/pages/playlist_provider.dart';
import 'package:provider/provider.dart';

class PlaylistPage extends StatefulWidget {
  const PlaylistPage({super.key});

  @override
  _PlaylistPageState createState() => _PlaylistPageState();
}

class _PlaylistPageState extends State<PlaylistPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () async {
                await _loadPlaylist(context);
              },
              child: const Text('Load Playlist'),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: Consumer<PlaylistProvider>(
                builder: (context, playlistProvider, _) {
                  return ListView.builder(
                    itemCount: playlistProvider.playlist.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(_getFileName(playlistProvider.playlist[index])),
                        // Add more customization as needed
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _loadPlaylist(BuildContext context) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.audio,
      allowMultiple: true,
    );

    if (result != null) {
      List<String> musicFiles = result.paths.map((path) => path ?? "").toList();

      context.read<PlaylistProvider>().updatePlaylist(musicFiles);
    }
  }

  String _getFileName(String path) {
    return path.split('/').last;
  }
}
