import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/shims/dart_ui_real.dart';
//import 'package:just_audio/just_audio.dart';
//import 'package:just_audio/just_audio.dart';
import 'package:test_app/screen/bottomAppbar.dart';
import 'package:test_app/screen/bottomSheet.dart';

class AudioPlayerUrl extends StatefulWidget {
  @override
  _AudioPlayerUrlState createState() => _AudioPlayerUrlState();
}

class _AudioPlayerUrlState extends State<AudioPlayerUrl> {
  AudioPlayer audioPlayer = AudioPlayer();
  PlayerState audioPlayerState = PlayerState.COMPLETED;
  Duration position = new Duration();
  Duration musicLength = new Duration();
  late bool isLoop;

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
  var alldata;
  // var skip;
  bool showdata = false;
  List dataList = [];
  int currentIndex = -1;
  // var data;

  /// Optional
  Widget slider() {
    return Container(
      width: 300.0,
      child: Slider.adaptive(
          value: timeProgress.toDouble(),
          max: audioDuration.toDouble(),
          onChanged: (value) {
            seekToSec(value.toInt());
            //   print(audioDuration.toDouble());
            //   print(value);
            // if(value== audioDuration.toDouble()){
            //   indexloop ++;
            //   setState(() {
            //     alldata=musicList[indexloop];
            //   });
            // }
          }),
    );
  }

  nextSongAutomatic({int p = 0, int a = 0}) {
    if (p == a) {
      indexloop++;
      setState(() {
        alldata = musicList[indexloop];
      });
    }
  }

  @override
  void initState() {
    super.initState();
    playautonextsong();
    dataList.add(alldata);
    print(dataList);

    /// Compulsory
    audioPlayer.onPlayerStateChanged.listen((state) {
      setState(() {
        audioPlayerState = state;
      });
    });

    /// Optional

    audioPlayer.play(showdata
        ? alldata['url']
        : null); // Triggers the onDurationChanged listener and sets the max duration string
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
    audioPlayer.onSeekComplete;
    audioPlayerState.index;
    audioPlayer.dispose();
    super.dispose();
  }

  /// Compulsory
  playMusic() async {
    // Add the parameter "isLocal: true" if you want to access a local file
    await audioPlayer.play(showdata ? alldata['url'] : null);
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

  int indexloop = 0;
  int seletedindex = -1;
  bool playsymbol = false;
  onselectedIndex(int index) {
    setState(() {
      seletedindex = index;
    });
  }

  playautonextsong() {
    audioPlayer.onPlayerCompletion.listen((event) {
      if (audioPlayerState == PlayerState.PLAYING) {
        setState(() {
          indexloop++;
          seletedindex++;
          alldata = musicList[indexloop];
          playMusic();
        });
      } else {
        return null;
      }
    });
  }

  bool showBottom = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Music Player'),
        centerTitle: true,
      ),
      // bottomNavigationBar:showBottom == false? Container(height: 10,width: double.infinity,): GestureDetector(
      //     onTap: () {
      // showModalBottomSheet(
      //     useRootNavigator: true,
      //     isScrollControlled: true,
      //     elevation: 100,
      //     backgroundColor: Colors.black38,
      //     context: context,
      //     builder: (context) {
      //       return BottomSheetWidget();
      //     });
      //     },
      //     child:BottomNavBar(title: alldata["title"],image: alldata['image'],url: alldata['url'], )),
      // bottomNavigationBar: Container(height: 10,width: double.infinity,),
      bottomNavigationBar: showdata
          ? GestureDetector(
              onTap: () {
                showModalBottomSheet(
                    useRootNavigator: true,
                    isScrollControlled: true,
                    elevation: 100,
                    backgroundColor: Colors.black38,
                    context: context,
                    builder: (context) {
                      return Container(
                        width: double.infinity,
                        color: Colors.grey,
                        child: Stack(children: [
                          Container(
                            height: 660,
                            child: Column(
                              children: [
                                Container(
                                  height: 300,
                                  color: Colors.pink,
                                  child: Column(
                                    children: [
                                      Positioned(
                                          child: Container(
                                              height: 300,
                                              child: Image.network(
                                                alldata['image'],
                                                fit: BoxFit.cover,
                                              ))),
                                    ],
                                  ),
                                ),
                                Card(
                                  child: ListTile(
                                    leading: Image.network(alldata['image']),
                                    title: Text(alldata['title']),
                                    subtitle: Text(alldata['singer']),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(getTimeString(timeProgress)),
                                    SizedBox(width: 20),
                                    Container(width: 200, child: slider()),
                                    SizedBox(width: 20),
                                    Text(getTimeString(
                                        audioDuration - timeProgress)),
                                    // nextSongAutomatic(p:timeProgress, a:audioDuration),
                                  ],
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    IconButton(
                                        icon: Icon(Icons.repeat),
                                        iconSize: 30.0,
                                        onPressed: () {
                                          if (isLoop == false) {
                                            audioPlayer.setReleaseMode(
                                                ReleaseMode.LOOP);
                                            setState(() {
                                              isLoop = true;
                                            });
                                          } else {
                                            audioPlayer.setReleaseMode(
                                                ReleaseMode.RELEASE);
                                            setState(() {
                                              isLoop = false;
                                            });
                                          }
                                        }

                                        //  audioPlayer.seek(
                                        //   Duration.zero,
                                        // ),
                                        ),
                                    IconButton(
                                      icon: Icon(Icons.skip_previous),
                                      iconSize: 35.0,
                                      onPressed: () {
                                        setState(() {
                                          setState(() {
                                            indexloop--;
                                            alldata = musicList[indexloop];
                                            print(indexloop);
                                            playMusic();
                                          });
                                        });
                                      },
                                    ),
                                    IconButton(
                                        iconSize: 35,
                                        onPressed: () {
                                          audioPlayerState ==
                                                  PlayerState.PLAYING
                                              ? showdata
                                                  ? pauseMusic()
                                                  : null
                                              : showdata
                                                  ? playMusic()
                                                  : null;
                                        },
                                        icon: Icon(audioPlayerState ==
                                                PlayerState.PLAYING
                                            ? Icons.pause_rounded
                                            : Icons.play_arrow_rounded)),
                                    IconButton(
                                      icon: Icon(Icons.skip_next),
                                      iconSize: 35.0,
                                      onPressed: () {
                                        // if(currentIndex<dataList.length){
                                        //   currentIndex++;
                                        //   pauseMusic();
                                        // }
                                        print("index beforer next:$indexloop");
                                        setState(() {
                                          indexloop++;
                                          if (indexloop <=
                                                  musicList.length - 1 &&
                                              seletedindex <=
                                                  musicList.length - 1) {
                                            alldata = musicList[indexloop];
                                            print(indexloop);
                                            playMusic();
                                            seletedindex++;
                                            // onselectedIndex(indexloop);
                                          } else {
                                            setState(() {
                                              indexloop = 0;
                                              seletedindex = 0;
                                              alldata = musicList[indexloop];
                                              playMusic();
                                            });
                                          }
                                        });
                                      },
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ]),
                      );
                    });
              },
              child: Container(
                height: 80,
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Card(
                        color: Colors.grey,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                                width: 100,
                                height: 70,
                                child: Image.network(
                                  alldata['image'],
                                  fit: BoxFit.cover,
                                )),
                            Column(
                              children: [
                                Container(
                                    width: 100,
                                    child: Text(
                                      alldata['title'],
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600),
                                    )),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                    width: 100, child: Text(alldata['singer'])),
                              ],
                            ),
                            IconButton(
                              icon: Icon(Icons.skip_previous),
                              iconSize: 35.0,
                              onPressed: () {
                                setState(() {
                                  setState(() {
                                    indexloop--;
                                    alldata = musicList[indexloop];
                                    print(indexloop);
                                    playMusic();
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
                                // if(currentIndex<dataList.length){
                                //   currentIndex++;
                                //   pauseMusic();
                                // }
                                print("index beforer next:$indexloop");
                                setState(() {
                                  indexloop++;
                                  if (indexloop <= musicList.length - 1 &&
                                      seletedindex <= musicList.length - 1) {
                                    alldata = musicList[indexloop];
                                    print(indexloop);
                                    playMusic();
                                    seletedindex++;
                                    // onselectedIndex(indexloop);
                                  } else {
                                    setState(() {
                                      indexloop = 0;
                                      seletedindex = 0;
                                      alldata = musicList[indexloop];
                                      playMusic();
                                    });
                                  }
                                });
                              },
                            ),
                          ],
                        )

                        //  ListTile(
                        //   leading: Container(
                        //       width: 100,
                        //       height: 100,
                        //       child: Image.network(
                        //         alldata['image'],
                        //         fit: BoxFit.cover,
                        //       )),
                        //   title: Container(
                        //     width: 50,
                        //     child: Text(alldata['title'])),
                        //   // subtitle: Text(alldata['singer']),
                        //   trailing: Wrap(crossAxisAlignment: WrapCrossAlignment.end,
                        //     children: [
                        //       IconButton(
                        //         icon: Icon(Icons.skip_previous),
                        //         iconSize: 35.0,
                        //         onPressed: () {
                        //           setState(() {
                        //             setState(() {
                        //               indexloop--;
                        //               alldata = musicList[indexloop];
                        //               print(indexloop);
                        //               playMusic();
                        //             });
                        //           });
                        //         },
                        //       ),
                        //       IconButton(
                        //           iconSize: 35,
                        //           onPressed: () {
                        //             audioPlayerState == PlayerState.PLAYING
                        //                 ? showdata
                        //                     ? pauseMusic()
                        //                     : null
                        //                 : showdata
                        //                     ? playMusic()
                        //                     : null;
                        //           },
                        //           icon: Icon(
                        //               audioPlayerState == PlayerState.PLAYING
                        //                   ? Icons.pause_rounded
                        //                   : Icons.play_arrow_rounded)),
                        //       IconButton(
                        //         icon: Icon(Icons.skip_next),
                        //         iconSize: 35.0,
                        //         onPressed: () {
                        //           // if(currentIndex<dataList.length){
                        //           //   currentIndex++;
                        //           //   pauseMusic();
                        //           // }
                        //           print("index beforer next:$indexloop");
                        //           setState(() {
                        //             indexloop++;
                        //             if (indexloop <= musicList.length - 1 &&
                        //                 seletedindex <= musicList.length - 1) {
                        //               alldata = musicList[indexloop];
                        //               print(indexloop);
                        //               playMusic();
                        //               seletedindex++;
                        //               // onselectedIndex(indexloop);
                        //             } else {
                        //               setState(() {
                        //                 indexloop = 0;
                        //                 seletedindex = 0;
                        //                 alldata = musicList[indexloop];
                        //                 playMusic();
                        //               });
                        //             }
                        //           });
                        //         },
                        //       ),
                        //     ],
                        //   ),
                        // ),
                        ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Text(getTimeString(timeProgress)),
                        // SizedBox(width: 20),
                        // Container(width: 200, child: slider()),
                        // SizedBox(width: 20),
                        // Text(getTimeString(audioDuration - timeProgress)),
                        // // nextSongAutomatic(p:timeProgress, a:audioDuration),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // IconButton(
                        //     icon: Icon(Icons.repeat),
                        //     iconSize: 30.0,
                        //     onPressed: () {
                        //       if (isLoop == false) {
                        //         audioPlayer.setReleaseMode(ReleaseMode.LOOP);
                        //         setState(() {
                        //           isLoop = true;
                        //         });
                        //       } else {
                        //         audioPlayer.setReleaseMode(ReleaseMode.RELEASE);
                        //         setState(() {
                        //           isLoop = false;
                        //         });
                        //       }
                        //     }

                        //     //  audioPlayer.seek(
                        //     //   Duration.zero,
                        //     // ),
                        //     ),
                        // IconButton(
                        //   icon: Icon(Icons.skip_previous),
                        //   iconSize: 35.0,
                        //   onPressed: () {
                        //     setState(() {
                        //       setState(() {
                        //         indexloop--;
                        //         alldata = musicList[indexloop];
                        //         print(indexloop);
                        //         playMusic();
                        //       });
                        //     });
                        //   },
                        // ),
                        //   IconButton(
                        //       iconSize: 35,
                        //       onPressed: () {
                        //         audioPlayerState == PlayerState.PLAYING
                        //             ? showdata
                        //                 ? pauseMusic()
                        //                 : null
                        //             : showdata
                        //                 ? playMusic()
                        //                 : null;
                        //       },
                        //       icon: Icon(audioPlayerState == PlayerState.PLAYING
                        //           ? Icons.pause_rounded
                        //           : Icons.play_arrow_rounded)),
                        //   IconButton(
                        //     icon: Icon(Icons.skip_next),
                        //     iconSize: 35.0,
                        //     onPressed: () {
                        //       // if(currentIndex<dataList.length){
                        //       //   currentIndex++;
                        //       //   pauseMusic();
                        //       // }
                        //       print("index beforer next:$indexloop");
                        //       setState(() {
                        //         indexloop++;
                        //         if (indexloop <= musicList.length - 1 &&
                        //             seletedindex <= musicList.length - 1) {
                        //           alldata = musicList[indexloop];
                        //           print(indexloop);
                        //           playMusic();
                        //           seletedindex++;
                        //           // onselectedIndex(indexloop);
                        //         } else {
                        //           setState(() {
                        //             indexloop = 0;
                        //             seletedindex = 0;
                        //             alldata = musicList[indexloop];
                        //             playMusic();
                        //           });
                        //         }
                        //       });
                        //     },
                        //   )
                        //
                      ],
                    )
                  ],
                ),
              ),
            )
          : Container(
              height: 10,
              width: double.infinity,
            ),
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
                  itemBuilder: ((context, indexloop) {
                    var data = musicList[indexloop];

                    return Container(
                        color: Colors.white,
                        child: GestureDetector(
                          onTap: () {},
                          child: Card(
                              child: ListTile(
                            leading: Container(
                                width: 100,
                                child: Image.network(
                                  data['image'],
                                  fit: BoxFit.cover,
                                )),
                            title: Text(data['title']),
                            subtitle: Text(data['singer']),
                            trailing: IconButton(
                              onPressed: () {
                                //  playsymbol=true;
                                onselectedIndex(indexloop);
                                setState(() {
                                  showdata = true;
                                  showBottom = true;
                                  // print(showdata);
                                  alldata = data;
                                  // print(alldata);
                                  dataList.add(' AllDara$alldata');
                                  print(dataList);
                                  print("index: $indexloop");
                                  // skip = data;
                                  playMusic();
                                  audioPlayerState == PlayerState.PLAYING
                                      ? pauseMusic()
                                      : playMusic();
                                });
                              },
                              icon: seletedindex != null &&
                                      seletedindex == indexloop &&
                                      audioPlayerState == PlayerState.PLAYING
                                  ? Icon(Icons.pause)
                                  : Icon(Icons.play_arrow),
                            ),
                          )),
                        ));
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

              // showdata
              //     ? Column(
              //         children: [
              //           Card(
              //             child: ListTile(
              //               leading: Image.network(alldata['image']),
              //               title: Text(alldata['title']),
              //               subtitle: Text(alldata['singer']),
              //             ),
              //           ),
              //           Row(
              //             mainAxisAlignment: MainAxisAlignment.center,
              //             children: [
              //               Text(getTimeString(timeProgress)),
              //               SizedBox(width: 20),
              //               Container(width: 200, child: slider()),
              //               SizedBox(width: 20),
              //               Text(getTimeString(audioDuration -timeProgress)),
              //               // nextSongAutomatic(p:timeProgress, a:audioDuration),
              //             ],
              //           ),
              //           Row(
              //             crossAxisAlignment: CrossAxisAlignment.start,
              //             mainAxisAlignment: MainAxisAlignment.center,
              //             children: [
              //               IconButton(
              //                   icon: Icon(Icons.repeat),
              //                   iconSize: 30.0,
              //                   onPressed: () {
              //                     if (isLoop == false) {
              //                       audioPlayer
              //                           .setReleaseMode(ReleaseMode.LOOP);
              //                       setState(() {
              //                         isLoop = true;
              //                       });
              //                     } else {
              //                       audioPlayer
              //                           .setReleaseMode(ReleaseMode.RELEASE);
              //                       setState(() {
              //                         isLoop = false;
              //                       });
              //                     }
              //                   }

              //                   //  audioPlayer.seek(
              //                   //   Duration.zero,
              //                   // ),
              //                   ),
              //               IconButton(
              //                 icon: Icon(Icons.skip_previous),
              //                 iconSize: 35.0,
              //                 onPressed: () {
              //                   setState(() {
              //                     setState(() {
              //                       indexloop--;
              //                       alldata = musicList[indexloop];
              //                       print(indexloop);
              //                       playMusic();
              //                     });
              //                   });
              //                 },
              //               ),
              //               IconButton(
              //                   iconSize: 35,
              //                   onPressed: () {
              //                     audioPlayerState == PlayerState.PLAYING
              //                         ? showdata
              //                             ? pauseMusic()
              //                             : null
              //                         : showdata
              //                             ? playMusic()
              //                             : null;
              //                   },
              //                   icon: Icon(
              //                       audioPlayerState == PlayerState.PLAYING
              //                           ? Icons.pause_rounded
              //                           : Icons.play_arrow_rounded)),
              //               IconButton(
              //                 icon: Icon(Icons.skip_next),
              //                 iconSize: 35.0,
              //                 onPressed: () {
              //                   // if(currentIndex<dataList.length){
              //                   //   currentIndex++;
              //                   //   pauseMusic();
              //                   // }
              //                   print("index beforer next:$indexloop");
              //                   setState(() {
              //                     indexloop++;
              //                     if (indexloop <= musicList.length - 1 &&
              //                         seletedindex <= musicList.length - 1) {
              //                       alldata = musicList[indexloop];
              //                       print(indexloop);
              //                       playMusic();
              //                       seletedindex++;
              //                       // onselectedIndex(indexloop);
              //                     } else {
              //                       setState(() {
              //                         indexloop = 0;
              //                         seletedindex = 0;
              //                         alldata = musicList[indexloop];
              //                         playMusic();
              //                       });
              //                     }
              //                   });
              //                 },
              //               )
              //             ],
              //           )
              //         ],
              //       )
              //     : Container(),
              // IconButton(
              //   splashRadius: 20,
              //   padding: const EdgeInsets.all(0),
              //   onPressed: () {
              //     showModalBottomSheet(
              //         useRootNavigator: true,
              //         isScrollControlled: true,
              //         elevation: 100,
              //         backgroundColor: Colors.black38,
              //         context: context,
              //         builder: (context) {
              //           return BottomSheetWidget();
              //         });
              //   },
              //   icon: const Icon(
              //     Icons.more_vert,
              //     color: Colors.white,
              //   ),
              // ),
            ],
          )),
    );
  }
}
