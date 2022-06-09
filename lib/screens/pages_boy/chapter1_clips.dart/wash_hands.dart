import 'package:chewie/chewie.dart';
import 'package:covid_19/screens/pages_boy/chapter1.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';
import 'dart:io';

import '../../../constants.dart';

class Wash_hands extends StatefulWidget {
  static const String screenRoute = 'wash_hands_screen';

  const Wash_hands({Key? key}) : super(key: key);

  @override
  _Wash_handsState createState() => _Wash_handsState();
}
//    _videoPlayerController = VideoPlayerController.asset('videos/wash.mp4')

class _Wash_handsState extends State<Wash_hands> {
  late VideoPlayerController _videoPlayerController;

  @override
  void initState() {
    super.initState();
    _videoPlayerController = VideoPlayerController.asset('videos/wash.mp4')
      ..initialize().then((_) {
        setState(() {});
        _videoPlayerController.play();
      });
    _videoPlayerController
        .addListener(() => onVideoEnd(_videoPlayerController, '1', '1'));
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    super.dispose();
  }

  bool reSize = false;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async{
        Navigator.pushReplacementNamed(context, Chapter1.screenRoute);
        return true;
      },
      child: Scaffold(
           appBar: AppBar(
            title: Text(
              "غسل اليدين",
              style: TextStyle(fontFamily: 'Cairo'),
            ),
            leading: IconButton(
              onPressed: () => Navigator.pushReplacementNamed(context, Chapter1.screenRoute),
              icon: Icon(Icons.arrow_back),
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
      ),
    );
  
  }
  
}
