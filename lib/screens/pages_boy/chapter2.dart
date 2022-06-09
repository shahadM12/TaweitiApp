import 'package:covid_19/screens/home_page_boy.dart';
import 'package:covid_19/screens/pages_boy/chapter2_clips.dart/quiz_chapter2.dart';
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
import 'package:covid_19/screens/pages_boy/chapter2_clips.dart/gloves.dart';
import 'package:covid_19/screens/pages_boy/chapter2_clips.dart/mask.dart';
import 'package:covid_19/screens/pages_boy/chapter2_clips.dart/soap.dart';
import 'package:covid_19/screens/pages_boy/chapter2_clips.dart/sterilizer.dart';
import 'package:covid_19/widgets/my_button.dart';

import '../../constants.dart';

class Chapter2 extends StatefulWidget {
static const String screenRoute = 'chapter2_screen';

  @override
  _Chapter2State createState() => _Chapter2State();
}

class _Chapter2State extends State<Chapter2> {
 
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
        onWillPop: () async{
           Navigator.pushReplacementNamed(context, HomePageBoy.screenRoute);
           return true;
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              "الفصل الثاني",
              style: TextStyle(fontFamily: 'Cairo'),
            ),
            leading: IconButton(
            onPressed: () {
              Navigator.pushReplacementNamed(context, HomePageBoy.screenRoute);
            },
            icon: Icon(Icons.arrow_back),),
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
                   Navigator.pushNamed(context, gloves.screenRoute);

                      },
                      title: Text(
                        'إرتداء القفازات',
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
                    color: videosInSeasons[1][0] ? Color(0xffff6348) : Colors.grey,
                    child: ListTile(
                      enabled: videosInSeasons[1][0],
                      leading: Icon(
                        videosInSeasons[1][0] ? Icons.key : Icons.key_off,
                        size: 30,
                        color: Colors.white,
                      ),
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                        size: 30,
                        color: Colors.white,
                      ),
                      onTap: () {
                    Navigator.pushNamed(context, mask.screenRoute);

                      },
                      title: Text(
                        'إرتداء الكمامة',
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
                    color: videosInSeasons[1][1] ? Color(0xffff6348) : Colors.grey,
                    child: ListTile(
                      enabled: videosInSeasons[1][1],
                      leading: Icon(
                        videosInSeasons[1][1] ? Icons.key : Icons.key_off,
                        size: 30,
                        color: Colors.white,
                      ),
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                        size: 30,
                        color: Colors.white,
                      ),
                      onTap: () {
                     Navigator.pushNamed(context, soap.screenRoute);

                      },
                      title: Text(
                        ' إستخدام الصابون ',
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
                     color: videosInSeasons[1][2] ? Color(0xffff6348) : Colors.grey,
                     child: ListTile(
                       enabled: videosInSeasons[1][2],
                       leading: Icon(
                         videosInSeasons[1][2] ? Icons.key : Icons.key_off,
                        size: 30,
                        color: Colors.white,
                      ),
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                        size: 30,
                        color: Colors.white,
                      ),
                      onTap: () {
                       Navigator.pushNamed(context, sterilizer.screenRoute);

                      },
                      title: Text(
                        ' إستخدام المعقم ',
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
                        MyButton(enable: videosInSeasons[1][3],

                          color: Color.fromARGB(255, 47, 145, 162),
                          title: 'إختبار قصير',
                          onPressed: () {
                            Navigator.pushNamed(
                                context,quiz_chapter2.screenRoute);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                ],
              ),
            ),
          ),

          //

          //
        ),
      );
    }
  }

