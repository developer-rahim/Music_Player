import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class BottomNavBar extends StatefulWidget {
  
   BottomNavBar({this.title,this.image,this.url, }) ;
// bool? IsShowBottom;
String? title;
String? image;
String? url;
  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  AudioPlayer audioPlayer = AudioPlayer();
  PlayerState audioPlayerState = PlayerState.PAUSED;
  int timeProgress = 0;
  int audioDuration = 0;
  
  bool showdata = false;
  List dataList = [];
  int currentIndex = -1;
    int indexloop = 0;
  int seletedindex = -1;
  bool playsymbol = false;
 bool isShow=false;
  
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

  @override
  void initState() {
    super.initState();
    // playautonextsong();

    print(dataList);

    /// Compulsory
    audioPlayer.onPlayerStateChanged.listen((state) {
      setState(() {
        audioPlayerState = state;
      });
    });

    /// Optional

    audioPlayer.play(musicList[indexloop][
        'url']); // Triggers the onDurationChanged listener and sets the max duration string
    audioPlayer.onDurationChanged.listen((Duration duration) {
      setState(() {
        audioDuration = duration.inSeconds;
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
    // audioPlayer.release();
    // audioPlayer.onSeekComplete;
    // audioPlayerState.index;
    audioPlayer.dispose();
    super.dispose();
  }

  /// Compulsory
  playMusic() async {
    // Add the parameter "isLocal: true" if you want to access a local file
    await audioPlayer.play(musicList[indexloop]['url']);
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


  onselectedIndex(int index) {
    setState(() {
      seletedindex = index;
    });
  }

  // playautonextsong() {
  //   audioPlayer.onPlayerCompletion.listen((event) {
  //     if (  audioPlayerState == PlayerState.PLAYING){
  //         setState(() {
  //       indexloop ++;
  //       seletedindex ++;
  //       alldata = musicList[indexloop];
  //       playMusic();
  //     });
  //     }else {
  //       return null;
  //     }

  //   });
  // }
  @override
  Widget build(BuildContext context) {
    return Container(height: 80,color: Colors.blueGrey,
      child: ListTile(
        leading: Container(
            margin: EdgeInsets.only(top: 10),
            width: 100,
            height: 100,
            child: Center(
              child: Image.network(widget.image!),
            )),
              
        title: Text(widget.title!),
        // subtitle: Text('Singer Name'),
        trailing: Wrap(
          children: [Row(children: [

        
            IconButton(
              icon: Icon(Icons.skip_previous_rounded),
              iconSize: 40.0,
              onPressed: () {
                // if(currentIndex<dataList.length){
                //   currentIndex++;
                //   pauseMusic();
                // }
                print("index beforer next:$indexloop");
                setState(() {
                  indexloop--;
                  if (indexloop >= musicList.length - 1) {
                    musicList[indexloop];
                    print(indexloop);
                    playMusic();
                    // seletedindex++;
                    // onselectedIndex(indexloop);
                  } else {
                    setState(() {
                      // indexloop = 0;
                      // seletedindex = 0;
                      musicList[indexloop];
                      playMusic();
                    });
                  }
                });
              },
            )

            ,
            IconButton(
              onPressed: (() {
                // onselectedIndex(indexloop);
                setState(() {
                  // print(alldata);

                  // skip = data;
                  playMusic();
                  audioPlayerState == PlayerState.PLAYING 
                      ? pauseMusic()
                      : playMusic();
                });
              }),
              icon: audioPlayerState == PlayerState.PLAYING
                  ? Icon(
                      Icons.pause,
                      size: 40,
                    )
                  : Icon(
                      Icons.play_arrow,
                      size: 40,
                    ),
            ),
            // icon: Icon(
            //   Icons.play_arrow,
            //   size: 40,
            // )
            //),
            IconButton(
              icon: Icon(Icons.skip_next),
              iconSize: 40.0,
              onPressed: () {
                // if(currentIndex<dataList.length){
                //   currentIndex++;
                //   pauseMusic();
                // }
                print("index beforer next:$indexloop");
                setState(() {
                  indexloop++;
                  if (indexloop <= musicList.length - 1) {
                    // musicList[indexloop];
                    print(indexloop);
                    playMusic();
                    seletedindex++;
                    // onselectedIndex(indexloop);
                  } else {
                    setState(() {
                      indexloop = 0;
                      // seletedindex = 0;
                      musicList[indexloop];
                      playMusic();
                    });
                  }
                });
              },
            )
          ],
        ),
       ],) ),
    );
  }
}
