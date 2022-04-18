import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class AudioPlayerUrl extends StatefulWidget {
  @override
  _AudioPlayerUrlState createState() => _AudioPlayerUrlState();
}

class _AudioPlayerUrlState extends State<AudioPlayerUrl> {
  AudioPlayer audioPlayer = AudioPlayer();
  PlayerState audioPlayerState = PlayerState.PAUSED;
  // String url = 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-14.mp3';
  // String url='assets/sounds/AaVzVwbK.mp3';

  List musicList = [
    {
      'title': 'Allah Amr Rob',
      'singer': 'Kazi Nazrul',
      'url': 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-13.mp3',
      'image':
          'https://thumbs.dreamstime.com/b/environment-earth-day-hands-trees-growing-seedlings-bokeh-green-background-female-hand-holding-tree-nature-field-gra-130247647.jpg'
    },
    {
      'title': 'Allah Amr Sob',
      'singer': ' Sofiya Kamal',
      'url': 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-14.mp3',
      'image': 'https://tinypng.com/images/social/website.jpg'
    },
    {
      'title': 'Allah Amr Malik',
      'singer': 'Begum Requya',
      'url': 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-15.mp3',
      'image': 'https://static.addtoany.com/images/dracaena-cinnabari.jpg'
    },
  ];

  /// Optional
  int timeProgress = 0;
  int audioDuration = 0;
  var title;
  var skip;
  bool showdata = false;

  /// Optional
  Widget slider() {
    return Container(
      width: 300.0,
      child: Slider.adaptive(
          value: timeProgress.toDouble(),
          max: audioDuration.toDouble() - timeProgress.toDouble(),
          onChanged: (value) {
            seekToSec(value.toInt());
          }),
    );
  }

  @override
  void initState() {
    super.initState();

    /// Compulsory
    audioPlayer.onPlayerStateChanged.listen((state) {
      setState(() {
        audioPlayerState = state;
      });
    });

    /// Optional

    audioPlayer.play(showdata
        ? title['url']
        : null); // Triggers the onDurationChanged listener and sets the max duration string
    audioPlayer.onDurationChanged.listen((Duration duration) {
      setState(() {
        audioDuration = duration.inSeconds - timeProgress;
      });
    });
    audioPlayer.onAudioPositionChanged.listen((Duration position) async {
      setState(() {
        timeProgress = position.inSeconds;
      });
    });
  }

  /// Compulsory
  @override
  void dispose() {
    audioPlayer.release();
    audioPlayer.dispose();
    super.dispose();
  }

  /// Compulsory
  playMusic() async {
    // Add the parameter "isLocal: true" if you want to access a local file
    await audioPlayer.play(showdata ? title['url'] : null);
  }

  /// Compulsory
  pauseMusic() async {
    await audioPlayer.pause();
  }

  /// Optional
  void seekToSec(int sec) {
    Duration newPos = Duration(seconds: sec);
    audioPlayer
        .seek(newPos); // Jumps to the given position within the audio file
  }

  /// Optional
  String getTimeString(int seconds) {
    String minuteString =
        '${(seconds / 60).floor() < 10 ? 0 : ''}${(seconds / 60).floor()}';
    String secondString = '${seconds % 60 < 10 ? 0 : ''}${seconds % 60}';
    return '$minuteString:$secondString'; // Returns a string with the format mm:ss
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          alignment: Alignment.center,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ListView.builder(
                  shrinkWrap: true,
                  itemCount: musicList.length,
                  // itemExtent: 120,
                  itemBuilder: ((context, index) {
                    var data = musicList[index];

                    return Container(
                      color: Colors.pink,
                      child: GestureDetector(
                          onTap: () {
                            setState(() {
                              showdata = true;
                              print(showdata);
                              title = data;
                              skip = data;
                              playMusic();
                            });
                          },
                          child: Card(
                            child: ListTile(
                              leading: Image.network(data['image']),
                              title: Text(data['title']),
                              subtitle: Text(data['singer']),
                            ),
                          )),
                    );
                  })),
              SizedBox(
                height: 10,
              ),

              /// Compulsory

              ShaderMask(
                shaderCallback: (Rect bounds) {
                  return RadialGradient(
                    center: Alignment.topLeft,
                    radius: 1.0,
                    tileMode: TileMode.mirror,
                    colors: <Color>[
                      //Colors.pink, // protom color kaj kore na
                      Colors.red,
                      Colors.green
                    ],
                  ).createShader(bounds);
                },
                child: Center(
                  child: Text(
                    ' Islamic world',
                    style: TextStyle(color: Colors.white, fontSize: 30),
                  ),
                ),
              ),
          

              /// Optional

              showdata
                  ? Card(
                      child: ListTile(
                        leading: Image.network(title['image']),
                        title: Text(title['title']),
                        subtitle: Text(title['singer']),
                      ),
                    )
                  : Container(),
              showdata
                  ? Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(getTimeString(timeProgress)),
                            SizedBox(width: 20),
                            Container(width: 200, child: slider()),
                            SizedBox(width: 20),
                            Text(getTimeString(audioDuration - timeProgress)),
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              icon: Icon(Icons.repeat),
                              iconSize: 30.0,
                              onPressed: () => audioPlayer.seek(
                                Duration.zero,
                              ),
                            ),
                            IconButton(
                              icon: Icon(Icons.skip_previous),
                              iconSize: 35.0,
                              onPressed: () {
                                setState(() {
                                  setState(() {
                                    title--;
                                  });
                                });
                              },
                            ),
                            IconButton(
                                iconSize: 35,
                                onPressed: () {
                                  audioPlayerState == PlayerState.PLAYING
                                      ? showdata
                                          ? pauseMusic()
                                          : null
                                      : showdata
                                          ? playMusic()
                                          : null;
                                },
                                icon: Icon(
                                    audioPlayerState == PlayerState.PLAYING
                                        ? Icons.pause_rounded
                                        : Icons.play_arrow_rounded)),
                            IconButton(
                              icon: Icon(Icons.skip_next),
                              iconSize: 35.0,
                              onPressed: () {
                                setState(() {
                                  title++;
                                });
                              },
                            )
                          ],
                        )
                      ],
                    )
                  : Container()
            ],
          )),
    );
  }
}
