import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';
import 'dart:io';
import 'package:chewie/chewie.dart';
import 'package:chewie/src/chewie_player.dart';

class Story extends StatefulWidget {
  static const String screenRoute = 'story_screen';

  const Story({Key? key}) : super(key: key);

  @override
  _StoryState createState() => _StoryState();
}
//    _videoPlayerController = VideoPlayerController.asset('videos/story.mp4')

class _StoryState extends State<Story> {
  late VideoPlayerController _videoPlayerController;
   
  @override
  void initState() { 
    _videoPlayerController = VideoPlayerController.asset('videos/story.mp4');
    _videoPlayerController.addListener(() {
      setState(() { });
    });
    _videoPlayerController.initialize().then((_) => setState((){}));
    _videoPlayerController.play();

    super.initState();

  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    super.dispose();
  }

    bool reSize = false;

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: Text(
            " القصة",
            style: TextStyle(fontFamily: 'Cairo'),
          ),
          backgroundColor: Color.fromARGB(255, 47, 145, 162),
          centerTitle: true,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _videoPlayerController.value.isInitialized
                ? reSize
                    ? Expanded(
                        child: AspectRatio(
                            aspectRatio:
                                _videoPlayerController.value.aspectRatio * 100,
                            child: Stack(
                              children: [
                                VideoPlayer(_videoPlayerController),
                                Positioned(
                                  bottom: 0,
                                  right: 0,
                                  child: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          reSize = !reSize;
                                          print(reSize);
                                          if (reSize) {
                                            SystemChrome
                                                .setPreferredOrientations([
                                              DeviceOrientation.landscapeLeft
                                            ]);
                                          } else {
                                            SystemChrome
                                                .setPreferredOrientations([
                                              DeviceOrientation.portraitUp
                                            ]);
                                          }
                                        });
                                      },
                                      icon: Icon(
                                        Icons.fullscreen,
                                      )),
                                ),
                              ],
                            )),
                      )
                    : AspectRatio(
                        aspectRatio: _videoPlayerController.value.aspectRatio,
                        child: Stack(
                          children: [
                            VideoPlayer(_videoPlayerController),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      reSize = !reSize;
                                      print(reSize);
                                      if (reSize) {
                                        SystemChrome.setPreferredOrientations(
                                            [DeviceOrientation.landscapeRight]);
                                      } else {
                                        SystemChrome.setPreferredOrientations(
                                            [DeviceOrientation.portraitUp]);
                                      }
                                    });
                                  },
                                  icon: Icon(
                                    Icons.fullscreen,
                                  )),
                            ),
                          ],
                        ))
                : Container(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(),
                ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Color(0xffff6348))),
                    onPressed: () {
                      _videoPlayerController.pause();
                    },
                    child: Icon(Icons.pause)),
                Padding(padding: EdgeInsets.all(2)),
                ElevatedButton(
                    onPressed: () {
                      _videoPlayerController.play();
                    },
                    child: Icon(Icons.play_arrow))
              ],
            ),
          ],
        ),
      );
    }
  }
