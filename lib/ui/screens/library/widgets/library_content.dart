import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../model/songs/song.dart';
import '../../../states/settings_state.dart';
import '../../../theme/theme.dart';
import '../view_model/library_view_model.dart';

class LibraryContent extends StatelessWidget {
  const LibraryContent({super.key});

  @override
  Widget build(BuildContext context) {
    // Read only LibraryViewModel and AppSettingsState
    LibraryViewModel viewModel = context.watch<LibraryViewModel>();
    AppSettingsState settingsState = context.watch<AppSettingsState>();

    return Container(
      color: settingsState.theme.backgroundColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 16),
          Text("Library", style: AppTextStyles.heading),

          const SizedBox(height: 50),

          Expanded(
            child: ListView.builder(
              itemCount: viewModel.songs.length,
              itemBuilder: (context, index) {
                final Song song = viewModel.songs[index];
                return _SongTile(
                  song: song,
                  isPlaying: viewModel.isPlaying(song),
                  onTap: () => viewModel.playSong(song),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _SongTile extends StatelessWidget {
  const _SongTile({
    required this.song,
    required this.isPlaying,
    required this.onTap,
  });

  final Song song;
  final bool isPlaying;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      title: Text(song.title),
      trailing: Text(
        isPlaying ? "Playing" : "",
        style: const TextStyle(color: Colors.amber),
      ),
    );
  }
}