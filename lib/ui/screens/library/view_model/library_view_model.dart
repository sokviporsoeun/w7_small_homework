import 'package:flutter/material.dart';

import '../../../../data/repositories/songs/song_repository.dart';
import '../../../../model/songs/song.dart';
import '../../../states/player_state.dart';

class LibraryViewModel extends ChangeNotifier {
  final SongRepository _songRepository;
  final PlayerState _playerState;

  List<Song> _songs = [];

  LibraryViewModel({
    required SongRepository songRepository,
    required PlayerState playerState,
  })  : _songRepository = songRepository,
        _playerState = playerState {
    _playerState.addListener(_onPlayerStateChanged);
  }

  // --- Init ---

  void init() {
    _songs = _songRepository.fetchSongs();
    notifyListeners();
  }

  // --- Listener ---

  void _onPlayerStateChanged() {
    notifyListeners();
  }

  // --- Getters (UI data) ---

  List<Song> get songs => _songs;

  bool isPlaying(Song song) => _playerState.currentSong == song;

  // --- User Actions ---

  void playSong(Song song) {
    _playerState.start(song);
  }

  void stopSong() {
    _playerState.stop();
  }

  // --- Dispose ---

  @override
  void dispose() {
    _playerState.removeListener(_onPlayerStateChanged);
    super.dispose();
  }
}