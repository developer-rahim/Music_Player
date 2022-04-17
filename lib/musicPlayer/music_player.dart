// import 'package:audioplayers/audioplayers.dart';
// import 'package:flutter/material.dart';

// class MusicPlayer extends StatefulWidget {
//   const MusicPlayer({Key? key}) : super(key: key);

//   @override
//   State<MusicPlayer> createState() => _MusicPlayerState();
// }

// class _MusicPlayerState extends State<MusicPlayer> {
//   // List<String> sounds = SoundManager.sounds;
//   final audioPlayer = AudioPlayer();
//   bool isPlaying = false;
//   Duration seek = Duration.zero;
//   Duration duration = Duration.zero;
//   Duration position = Duration.zero;

//   @override
//   void dispose() {
//     // TODO: implement dispose

//     audioPlayer.dispose();
//   }

//   Future setAudio() async {
//     final player = AudioCache(prefix: 'assets/');
//     final url = await player.load('sound1.mp3');
//     audioPlayer.setUrl(url.path, isLocal: true);
//   }

//   @override
//   void initState() {
//     // TODO: implement initState
//     setAudio();

//     audioPlayer.onPlayerStateChanged.listen((state) {
//       setState(() {
//         isPlaying = state == PlayerState.PLAYING;
//       });
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Container(
//           height: 300,
//           width: double.infinity,
//           color: Color.fromARGB(255, 192, 115, 115),
//           child: Column(
//             children: [
//               Slider(
//                   min: 0,
//                   max: duration.inMilliseconds.toDouble(),
//                   value: position.inSeconds.toDouble(),
//                   onChanged: (value) async {
//                     final position = Duration(seconds: value.toInt());
//                     await audioPlayer.seek(position);
//                   }),
//               CircleAvatar(
//                 radius: 35,
//                 child: IconButton(
//                     onPressed: () async {
//                       if (isPlaying) {
//                         await audioPlayer.pause();
//                       } else {
//                         var url = setAudio();
//                         await audioPlayer.play(
//                           "https://gaana.com/song/shaadi-karke-le-jayega-mujhe.mp3",
//                           // isLocal: true,
//                         );
//                       }
//                     },
//                     icon:
//                         isPlaying ? Icon(Icons.pause) : Icon(Icons.play_arrow)),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// // class SoundManager {
// //   static const List<String> sounds = [
// //     'assets/sounds/sound1.mp3',
// //     'assets/sounds/AaVzVwbK.mp3',
// //   ];
// // }import 'package:audioplayers/audioplayers.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class AudioPlayerUrl extends StatefulWidget {
  @override
  _AudioPlayerUrlState createState() => _AudioPlayerUrlState();
}

class _AudioPlayerUrlState extends State<AudioPlayerUrl> {
  /// For clarity, I added the terms compulsory and optional to certain sections
  /// to maintain clarity as to what is really needed for a functioning audio player
  /// and what is added for further interaction.
  ///
  /// 'Compulsory': A functioning audio player with:
  ///             - Play/Pause button
  ///
  /// 'Optional': A functioning audio player with:
  ///             - Play/Pause button
  ///             - time stamps for progress and duration
  ///             - slider to jump within the audio file
  ///
  /// Compulsory
  AudioPlayer audioPlayer = AudioPlayer();
 PlayerState audioPlayerState = PlayerState.PAUSED;
   String url = 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-14.mp3';
  // String url='assets/sounds/AaVzVwbK.mp3';

  /// Optional
  int timeProgress = 0;
  int audioDuration = 0;

  /// Optional
  Widget slider() {
    return Container(
      width: 300.0,
      child: Slider.adaptive(
          value: timeProgress.toDouble(),
          max: audioDuration.toDouble(),
          onChanged: (value) {
            seekToSec(value.toInt());
          }),
    );
  }

  @override
  void initState() {
    super.initState();

    /// Compulsory
    audioPlayer.onPlayerStateChanged.listen(( state) {
      setState(() {
        audioPlayerState = state;
      });
    });

    /// Optional
    audioPlayer.setUrl(
        url,
        ); // Triggers the onDurationChanged listener and sets the max duration string
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
    audioPlayer.release();
    audioPlayer.dispose();
    super.dispose();
  }

  /// Compulsory
  playMusic() async {
    // Add the parameter "isLocal: true" if you want to access a local file
    await audioPlayer.play(url);
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
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
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
             'Play Music As Your Mood',
                style: TextStyle(color: Colors.white, fontSize: 30),
              ),
            ),
          ),
              IconButton(
                  iconSize: 50,
                  onPressed: () {
                    audioPlayerState == PlayerState.PLAYING
                        ? pauseMusic()
                        : playMusic();
                  },
                  icon: Icon(audioPlayerState == PlayerState.PLAYING
                      ? Icons.pause_rounded
                      : Icons.play_arrow_rounded)),

              /// Optional
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(getTimeString(timeProgress)),
                  SizedBox(width: 20),
                  Container(width: 200, child: slider()),
                  SizedBox(width: 20),
                  Text(getTimeString(audioDuration))
                ],
              )
            ],
          )),
    );
  }
}
