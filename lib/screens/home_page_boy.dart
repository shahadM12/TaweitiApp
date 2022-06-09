import 'package:covid_19/constants.dart';
import 'package:covid_19/screens/pages_boy/chapter1.dart';
import 'package:covid_19/screens/pages_boy/chapter2.dart';
import 'package:covid_19/screens/pages_boy/chapter3.dart';
import 'package:covid_19/screens/profileboy.dart';
import 'package:covid_19/screens/progress_screen.dart';
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

class HomePageBoy extends StatefulWidget {
  static const String screenRoute = 'home_page_boy_screen';

  @override
  _HomePageBoyState createState() => _HomePageBoyState();
}

class _HomePageBoyState extends State<HomePageBoy> {
  final _auth = FirebaseAuth.instance;
  late User signedInUser;
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    setState(() {});
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

  String userName = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          " الصفحة الرئيسية",
          style: TextStyle(fontFamily: 'Cairo'),
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
                    Navigator.pushNamed(context, Story.screenRoute);
                  },
                  title: Text(
                    'القصة',
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
                    print(seasonsKeys);
                    Navigator.pushNamed(context, Chapter1.screenRoute);
                  },
                  title: Text(
                    'الفصل الأول',
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
                color: seasonsKeys[0] ? Color(0xffff6348) : Colors.grey,
                child: ListTile(
                  enabled: seasonsKeys[0],
                  leading: Icon(
                    seasonsKeys[0] ? Icons.key : Icons.key_off,
                    size: 30,
                    color: Colors.white,
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    size: 30,
                    color: Colors.white,
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, Chapter2.screenRoute);
                  },
                  title: Text(
                    'الفصل الثاني',
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
                color: seasonsKeys[1] ? Color(0xffff6348) : Colors.grey,
                child: ListTile(
                  enabled: seasonsKeys[1],
                  leading: Icon(
                    seasonsKeys[1] ? Icons.key : Icons.key_off,
                    size: 30,
                    color: Colors.white,
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    size: 30,
                    color: Colors.white,
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, Chapter3.screenRoute);
                  },
                  title: Text(
                    'الفصل الثالث',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        fontFamily: 'Cairo',
                        color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),

      //

      //
      backgroundColor: Color(0xfff1f2f6),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              padding: EdgeInsets.zero,
              child: Container(
                margin: EdgeInsets.only(bottom: 10),
                height: 70,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 47, 145, 162),
                ),
                child: Stack(
                  children: <Widget>[
                    Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: const EdgeInsets.all(30.0),
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          backgroundImage: AssetImage('images/avatar-boy.png'),
                          radius: 50.0,
                        ),
                      ),
                    ),
                    //
                    FutureBuilder(
                        future: FirebaseFirestore.instance
                            .collection('users')
                            .get(),
                        builder:
                            (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (!snapshot.hasData) {
                            return Center(child: CircularProgressIndicator());
                          } else {
                            snapshot.data!.docs.forEach((element) {
                              if (element.id == UID) {
                                userName = element["User"];
                                print("yes");
                              }
                            });
                            ;
                            return Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(80, 0, 0, 0),
                                child: Text(
                                  "${userName}",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20.0,
                                      fontFamily: 'Cairo'),
                                ),
                              ),
                            );
                          }
                        })
                  ],
                ),
              ),
            ),
           
            ListTile(
              title: Text(
                'الصفحة الشخصية',
                style: TextStyle(fontFamily: 'Cairo'),
              ),
              leading: Icon(Icons.account_box),
              onTap: () {
                Navigator.pushNamed(context, profileboy.screenRoute);
              },
            ),
            SizedBox(
              height: 0.25,
            ),
            ListTile(
              title: Text(
                'التقدم',
                style: TextStyle(fontFamily: 'Cairo'),
              ),
              leading: Icon(Icons.percent),
              onTap: () {
                Navigator.pushNamed(context, ProgressScreen.screenRoute);
              },
            ),
            SizedBox(
              height: 0.25,
            ),
            Center(
              child: Text(errorMessage),
            ),
            ListTile(
              title: Text(
                'تسجيل خروج',
                style: TextStyle(fontFamily: 'Cairo'),
              ),
              leading: Icon(Icons.logout),
              onTap: () async {
                try {
                  await FirebaseAuth.instance.signOut().then((value) {
                    Navigator.pushReplacementNamed(
                        context, SignInScreen.screenRoute);
                  });
                } on FirebaseAuthException catch (e) {
                  errorMessage = e.message!;
                }
                setState(() {});
              },
            )
          ],
        ),
      ),
    );
  }
}
