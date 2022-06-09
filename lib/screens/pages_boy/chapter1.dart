import 'package:covid_19/constants.dart';
import 'package:covid_19/screens/pages_boy/chapter1_clips.dart/quiz_chapter1.dart';
import 'package:covid_19/screens/pages_boy/chapter1_clips.dart/wash_teeth.dart';
import 'package:covid_19/screens/profileboy.dart';
import 'package:covid_19/screens/signin_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:covid_19/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:io';
import 'dart:async';
import 'package:covid_19/screens/story.dart';
import 'package:get/get.dart';
import 'package:covid_19/screens/pages_boy/chapter1_clips.dart/wash_hands.dart';
import 'package:covid_19/screens/pages_boy/chapter1_clips.dart/bathing.dart';
import 'package:covid_19/screens/pages_boy/chapter1_clips.dart/wash_teeth.dart';
import 'package:covid_19/widgets/my_button.dart';
import 'package:covid_19/screens/pages_boy/chapter1_clips.dart/quiz_chapter1.dart';

import '../home_page_boy.dart';

class Chapter1 extends StatefulWidget {
  static const String screenRoute = 'chapter1_screen';

  @override
  _Chapter1State createState() => _Chapter1State();
}

class _Chapter1State extends State<Chapter1> {
  final _auth = FirebaseAuth.instance;
  late User signedInUser;
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        signedInUser = user;
        print(signedInUser.email);
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacementNamed(context, HomePageBoy.screenRoute);
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "الفصل الأول",
            style: TextStyle(fontFamily: 'Cairo'),
          ),
          leading: IconButton(
            onPressed: () {
              Navigator.pushReplacementNamed(context, HomePageBoy.screenRoute);
            },
            icon: Icon(Icons.arrow_back),
          ),
          backgroundColor: Color.fromARGB(255, 47, 145, 162),
          centerTitle: true,
        ),

        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('images/boy-home.gif'),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: ListView(
              scrollDirection: Axis.vertical,
              children: <Widget>[
                Container(
                  height: 50,
                  margin: EdgeInsets.only(bottom: 10, right: 30, left: 30),
                  color: Color(0xffff6348),
                  child: ListTile(
                    leading: Icon(
                      Icons.key,
                      size: 30,
                      color: Colors.white,
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      size: 30,
                      color: Colors.white,
                    ),
                    onTap: () {
                      Navigator.pushNamed(context, Wash_hands.screenRoute);
                    },
                    title: Text(
                      'غسل اليدين',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          fontFamily: 'Cairo',
                          color: Colors.white),
                    ),
                  ),
                ),
                Container(
                  height: 50,
                  margin: EdgeInsets.only(bottom: 10, right: 30, left: 30),
                  color: videosInSeasons[0][0] ? Color(0xffff6348) : Colors.grey,
                  child: ListTile(
                    enabled: videosInSeasons[0][0],
                    leading: Icon(
                      videosInSeasons[0][0] ? Icons.key:Icons.key_off,
                      size: 30,
                      color: Colors.white,
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      size: 30,
                      color: Colors.white,
                    ),
                    onTap: () {
                      Navigator.pushNamed(context, bathing.screenRoute);
                    },
                    title: Text(
                      'الإستحمام',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          fontFamily: 'Cairo',
                          color: Colors.white),
                    ),
                  ),
                ),
                Container(
                  height: 50,
                  margin: EdgeInsets.only(bottom: 10, right: 30, left: 30),
                  color: videosInSeasons[0][1] ? Color(0xffff6348) : Colors.grey,
                  child: ListTile(
                    enabled: videosInSeasons[0][1],
                    leading: Icon(
                      videosInSeasons[0][1] ? Icons.key:Icons.key_off,
                      size: 30,
                      color: Colors.white,
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      size: 30,
                      color: Colors.white,
                    ),
                    onTap: () {
                      Navigator.pushNamed(context, wash_teeth.screenRoute);
                    },
                    title: Text(
                      'تنظيف الأسنان ',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          fontFamily: 'Cairo',
                          color: Colors.white),
                    ),
                  ),
                ),
                Container(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 70),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SizedBox(height: 30),
                        MyButton(
                          enable: videosInSeasons[0][2],
                          color:videosInSeasons[0][2] ? Color.fromARGB(255, 47, 145, 162) : Colors.grey,
                          title: 'إختبار قصير',
                          onPressed: () {
                            Navigator.pushNamed(
                                context, quiz_chapter1.screenRoute);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                //
              ],
            ),
          ),
        ),

        //

        //
        backgroundColor: Color(0xfff1f2f6),
      ),
    );
  }
}
