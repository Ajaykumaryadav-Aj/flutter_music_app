import 'package:flutter/material.dart';
import 'package:flutter_music_app/component/mydrawer.dart';
import 'package:flutter_music_app/mpdels/playlist_provider.dart';
import 'package:flutter_music_app/mpdels/song.dart';
import 'package:flutter_music_app/pages/songpage.dart';
import 'package:provider/provider.dart';

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({super.key});

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  late final dynamic playlistProvider;
  @override
  void initState() {
    super.initState();

    // get playlist provider
    playlistProvider = Provider.of<PlaylistProvider>(context, listen: false);
  }

// got to a song
  void goToSong(int songIndex) {
    // update current song index
    playlistProvider.currentSongIndex = songIndex;
    // navigate to song page

    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const SongPage(),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: const Text('P L A Y L I S T'),
      ),
      drawer: const MyDrawer(),
      body: Consumer<PlaylistProvider>(
        builder: (context, value, child) {
// get the playlist
          final List<Song> playlist = value.playlist;

// return list view UI
          return ListView.builder(
              itemCount: playlist.length,
              itemBuilder: (context, index) {
                // get the individual song
                final Song song = playlist[index];
                return ListTile(
                  title: Text(song.songName),
                  subtitle: Text(song.artistName),
                  leading: Image.asset(song.albumArtistImagePath),
                  onTap: () => goToSong(index),
                );
              });
        },
      ),
    );
  }
}
