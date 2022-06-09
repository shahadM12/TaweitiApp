import 'package:covid_19/screens/pages_boy/chapter1_clips.dart/quiz_chapter1.dart';
import 'package:covid_19/screens/pages_girl/chapter1_clipsG.dart/quiz_chapter1G.dart';
//import 'package:covid_19/screens/pages_girl/chapter1_clipsG.dart/quiz_chapter1G.dart';

import 'package:covid_19/screens/signin_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:covid_19/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:io';
import 'dart:async';
import 'package:get/get.dart';
import 'package:covid_19/widgets/my_button.dart';

import 'package:covid_19/screens/pages_girl/chapter1_clipsG.dart/bathingG.dart';
import 'package:covid_19/screens/pages_girl/chapter1_clipsG.dart/washG.dart';
import 'package:covid_19/screens/pages_girl/chapter1_clipsG.dart/teethG.dart';

import '../../constants.dart';
import '../home_page_girl.dart';

class Chapter1G extends StatefulWidget {
  static const String screenRoute = 'chapter1G_screen';

  @override
  _Chapter1GState createState() => _Chapter1GState();
}

class _Chapter1GState extends State<Chapter1G> {
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
        Navigator.pushReplacementNamed(context, HomePageGirl.screenRoute);
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
              Navigator.pushReplacementNamed(context, HomePageGirl.screenRoute);
            },
            icon: Icon(Icons.arrow_back),),
          backgroundColor: Color.fromARGB(255, 47, 145, 162),
          centerTitle: true,
        ),

        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('images/backgroundGirl.gif'),
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
                      Navigator.pushNamed(context, WashG.screenRoute);
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
                      videosInSeasons[0][0] ? Icons.key : Icons.key_off,
                      size: 30,
                      color: Colors.white,
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      size: 30,
                      color: Colors.white,
                    ),
                    onTap: () {
                      Navigator.pushNamed(context, bathingG.screenRoute);
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
                      videosInSeasons[0][1] ? Icons.key : Icons.key_off,
                      size: 30,
                      color: Colors.white,
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      size: 30,
                      color: Colors.white,
                    ),
                    onTap: () {
                      Navigator.pushNamed(context, teethG.screenRoute);
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
                          color: Color.fromARGB(255, 47, 145, 162),
                          title: 'إختبار قصير',
                          onPressed: () {
                           Navigator.pushNamed(context,quiz_chapter1G.screenRoute);
                            // Get.to(QuizPage());
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
