import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_music_app/mpdels/song.dart';

class PlaylistProvider extends ChangeNotifier {
  // playlist of songs
  final List<Song> _playlist = [
// song 1
    Song(
        songName: 'Arjit singh',
        artistName: 'Arjit',
        albumArtistImagePath: 'assets/image/images.jpeg',
        audioPath: 'assets/audio/new_320_01 - Shayad - Love Aaj Kal (2020).mp3'),
    // song 2
    Song(
        songName: ' singh',
        artistName: 'Ar',
        albumArtistImagePath: 'assets/image/istockphoto-1175435360-612x612.jpg',
        audioPath: 'assets/audio/bollywood_HAK - Hamari Adhuri Kahani.mp3'),
    // song 3
    Song(
        songName: 'Ak',
        artistName: 'YAdav',
        albumArtistImagePath: 'assets/image/images.jpeg',
        audioPath: 'assets/audio/bollywood_HAK - Hamari Adhuri Kahani.mp3')
  ];

// current song playing index
  int? _currentSongIndex;

// A U D I O P L A Y E R

  // audio player
  final AudioPlayer _audioPlayer = AudioPlayer();

  // duration
  Duration _currentDuration = Duration.zero;
  Duration _totalDuration = Duration.zero;

  // constructor
  PlaylistProvider() {
    listenToDuratio();
  }
  // initially not playing
  bool _isPlaying = false;
  // play the song
  void play() async {
    final String path = _playlist[_currentSongIndex!].audioPath;
    await _audioPlayer.stop();
    await _audioPlayer.play(AssetSource(path));
    _isPlaying = true;
  }

  // pause current song
  void pause() async {
    await _audioPlayer.pause();
    _isPlaying = false;
    notifyListeners();
  }

  // resume playing
  void resume() async {
    await _audioPlayer.resume();
    _isPlaying = true;
    notifyListeners();
  }

  // pause or resume
  void pauseOrResume() async {
    if (_isPlaying) {
      pause();
    } else {
      resume();
    }
    notifyListeners();
  }

  // seek to specific potition in current song
  void seek(Duration position) async {
    await _audioPlayer.seek(position);
  }

  // play next song
  void playNextSong() {
    if (_currentSongIndex != null) {
      if (_currentSongIndex! < _playlist.length - 1) {
        currentSongIndex = _currentSongIndex! + 1;
      } else {
        currentSongIndex = 0;
      }
    }
  }

  // play previous song
  void playPreviousSong() async {
    if (_currentDuration.inSeconds > 2) {
      seek(Duration.zero);
    } else {
      if (_currentSongIndex! > 0) {
        currentSongIndex = _currentSongIndex! - 1;
      } else {
        currentSongIndex = _playlist.length - 1;
      }
    }
  }

  // list to duration
  void listenToDuratio() {
    // listen for total duration
    _audioPlayer.onDurationChanged.listen((newDuration) {
      _totalDuration = newDuration;
      notifyListeners();
    });
    // listen for current duration
    _audioPlayer.onPositionChanged.listen((newPosition) {
      _currentDuration = newPosition;
      notifyListeners();
    });

    // listen for song completion
    _audioPlayer.onPlayerComplete.listen((event) {
      playNextSong();
    });
  }

  // dispose audio player

// G E T T E R S

  List<Song> get playlist => _playlist;
  int? get currentSongIndex => _currentSongIndex;
  bool get isPlaying => _isPlaying;
  Duration get currentDuration => _currentDuration;
  Duration get totalDuration => _totalDuration;

  // S E T T E R S

  set currentSongIndex(int? newindex) {
    // update current song index
    _currentSongIndex = newindex;

    if (newindex != null) {
      play();
    }

    // update UI
    notifyListeners();
  }
}
