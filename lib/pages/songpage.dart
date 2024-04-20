import 'package:flutter/material.dart';
import 'package:flutter_music_app/component/nue_box.dart';
import 'package:flutter_music_app/mpdels/playlist_provider.dart';
import 'package:provider/provider.dart';

class SongPage extends StatelessWidget {
  const SongPage({super.key});

// convert duration into min : sec
  String formatTime(Duration duration) {
    String twoDigitSecond = duration.inSeconds.remainder(60).toString();
    String formattedTime = "${duration.inMinutes}:$twoDigitSecond";
    return formattedTime;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PlaylistProvider>(builder: (context, value, child) {
// get playlist
      final playlist = value.playlist;

      final currentSong = playlist[value.currentSongIndex ?? 0];

      return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: SafeArea(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.arrow_back),
                  ),
                  const Text('P L A Y L I S T'),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.menu),
                  ),
                ],
              ),
              SizedBox(
                height: 300,
                width: 380,
                child: NeuBox(
                  child: Image.asset(
                    currentSong.albumArtistImagePath,
                  ),
                ),
              ),
              const SizedBox(height: 15),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // start time
                      Text(formatTime(value.currentDuration)),
                      // Suffle icon
                      const Icon(Icons.shuffle),

                      // repeat icon
                      const Icon(Icons.repeat),

                      // end time
                      Text(formatTime(value.totalDuration)),
                    ],
                  ),
                  SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                        thumbShape:
                            const RoundSliderThumbShape(enabledThumbRadius: 0)),
                    child: Slider(
                      min: 0,
                      max: value.totalDuration.inSeconds.toDouble(),
                      value: value.totalDuration.inSeconds.toDouble(),
                      onChanged: (double double) {},
                      onChangeEnd: (double double) {
                        value.seek(Duration(seconds: double.toInt()));
                      },
                      activeColor: Colors.green,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: value.playPreviousSong,
                          // onTap: () => value.playPreviousSong(),
                          child: const SizedBox(
                            height: 50,
                            width: 20,
                            child: Icon(Icons.skip_previous),
                          ),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: value.pauseOrResume,
                          child: SizedBox(
                            height: 50,
                            width: 20,
                            child: Icon(value.isPlaying
                                ? Icons.pause
                                : Icons.play_arrow),
                          ),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: value.playNextSong,
                          child: const Icon(
                            Icons.skip_next,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      );
    });
  }
}
