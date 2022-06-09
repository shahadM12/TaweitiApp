import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:covid_19/widgets/my_button.dart';
import 'package:flutter/foundation.dart';
import 'dart:typed_data';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/services.dart';

import '../../../constants.dart';

// @dart=2.9
class quiz_chapter3G extends StatefulWidget {
  static const String screenRoute = 'quiz_chapter3G_screen';

  @override
  _quiz_chapter3GState createState() => _quiz_chapter3GState();
}

class _quiz_chapter3GState extends State<quiz_chapter3G> {
  AudioPlayer player = AudioPlayer();
  var n = 0;
  var score = 0;
  var que = [
    questions(
        'السؤال 1 : ',
        ["test_boy/images-test/spaceTG.gif", "test_boy/images-test/spaceF.gif"],
        0,
        "test_boy/audio-test/spacegirl.mp3"),
    questions(
        'السؤال 2 : ',
        ["test_boy/images-test/touchF.gif", "test_boy/images-test/touchTG.gif"],
        1,
        'test_boy/audio-test/touchgirl.mp3'),
    questions(
        'السؤال 3 : ',
        [
          "test_boy/images-test/thingsT.gif",
          "test_boy/images-test/thingsFG.gif"
        ],
        0,
        'test_boy/audio-test/thingsgirl.mp3'),
  ];

  @override
  void initState() {
    super.initState();
    playAudio(que[n].audio);
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  playAudio(String path) async {
    String audioasset = path;
    ByteData bytes = await rootBundle.load(audioasset); //load sound from assets
    Uint8List soundbytes =
        bytes.buffer.asUint8List(bytes.offsetInBytes, bytes.lengthInBytes);
    int result = await player.playBytes(soundbytes);
    if (result == 1) {
      //play success
      print("Sound playing successful.");
    } else {
      print("Error while playing sound.");
    }
  }

  void check(int choice, BuildContext ctx) {
    if (choice == que[n].ans) {
      score = score + 1;
      if (score == 3) {
        FirebaseFirestore.instance
            .collection('users')
            .doc(UID)
            .collection('seasons')
            .doc('3')
            .set({'finishSeason': true});
        seasonsKeys[2] = true;
        //    Navigator.pop(context);
      }
      final snackbar = SnackBar(
        content: Text('إجابة صحيحة',
         style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                            fontFamily: 'Cairo'),),
        duration: Duration(milliseconds: 600),
        backgroundColor: Colors.green,
      );
      // ignore: deprecated_member_use
      Scaffold.of(ctx).showSnackBar(snackbar);
    } else {
      final snackbar = SnackBar(
        content: Text('إجابة خاطئة',
         style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                            fontFamily: 'Cairo'),),
        duration: Duration(milliseconds: 600),
        backgroundColor: Colors.red,
      );
      // ignore: deprecated_member_use
      Scaffold.of(ctx).showSnackBar(snackbar);
    }
    setState(() {
      if (n < que.length - 1) {
        n = n + 1;
        playAudio(que[n].audio);
      } else {
        Widget okButton = FlatButton(
          child: Text("OK"),
          onPressed: () {},
        );
        AlertDialog alert = AlertDialog(
          // title: Text("النتيجة"),
          content: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(bottom: 120),
                child: Image.asset(
                  image(),
                  height: 100,
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 130),
                child: Text(
                 'النتيجة :  $score/3 \n $resultPhrase', textAlign: TextAlign.center,
                  style: TextStyle(
                            color: Colors.blue.shade800,
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                            fontFamily: 'Cairo')
                ),
              ),
            ],
          ),
          actions: <Widget>[
            CupertinoButton(
                child: Text('إغلاق'),
                onPressed: () {
                  Navigator.pop(context);
                })
          ],
        );
        // show the dialog
        showDialog(
          context: ctx,
          builder: (BuildContext ctx) {
            return alert;
          },
        );
      }
    });
  }

 String get resultPhrase {
    String resultText;
    if (score == 1) {
      resultText = 'غير جيده! \n يجب عليك أن تحاول';
    } else if (score == 2) {
      resultText = 'غير جيده! \n يجب عليك أن تبذل مجهوداً أكثر';
    } else if (score == 3) {
      resultText = 'ممتازة جداً! \n لقد إجتزت الإختبار بنجاح';
    } else {
      resultText = 'سيئة جداً \n حاول مرة أخرى';
    }
    return resultText;
  }
  void reset() {
    setState(() {
      n = 0;
      score = 0;
    });
  }

 String image(){
   if(score == 3){
    return 'images/happy.png';
   }else{
      return 'images/sad.png';
   }
 }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(
            " إختبار قصير ",
            style: TextStyle(fontFamily: 'Cairo'),
          ),
          backgroundColor: Color.fromARGB(255, 47, 145, 162),
          centerTitle: true,
        ),
        body: Builder(
          builder: (ctx) => Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(30),
                child: Container(
                  margin: EdgeInsets.only(left: 18, right: 18),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "الدرجة :  $score/3",
                        style: TextStyle(
                            color: Colors.blue.shade800,
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                            fontFamily: 'Cairo'),
                      ),
                      InkWell(
                          onTap: () => reset(),
                          child: Text(
                            "إعادة المحاولة",
                            style: TextStyle(
                            color: Colors.red,
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                            fontFamily: 'Cairo'),
                          ))
                    ],
                  ),
                ),
              ),
 SizedBox(
                child: Container(
                  margin: EdgeInsets.fromLTRB(0, 0, 50, 10),
                  child: Text(que[n].que
                  ,style: TextStyle(
                            color: Colors.blue.shade800,
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                            fontFamily: 'Cairo'),),
                ),
              ),

              SizedBox(
                child: Container(
                  margin: EdgeInsets.fromLTRB(0, 0, 165, 60),
                  child: Tab(
                    icon: IconButton(
                      iconSize: 40,
                      onPressed: () {
                        playAudio(que[n].audio);
                      },
                      icon: Icon(Icons.play_circle,color: Colors.blue,),
                    ),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(12.0),
                child: Row(
                  children: [
                    Expanded(
                        child: Container(
decoration: BoxDecoration(
                          border: Border.all(),),
                          child: GestureDetector(
                              onTap: () => check(0, ctx),
                              child: Image.asset("${que[n].imagesURL[0]}")),
                        )),
                    SizedBox(
                      width: 15.0,
                    ),
                    Expanded(
                        child: Container(
decoration: BoxDecoration(
                          border: Border.all(),),
                          child: GestureDetector(
                              onTap: () => check(1, ctx),
                              child: Image.asset("${que[n].imagesURL[1]}")),
                        )),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
