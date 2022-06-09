import 'dart:io';
import 'package:covid_19/constants.dart';
import 'package:covid_19/screens/signin_screen.dart';
import 'package:flutter/material.dart';
import 'package:covid_19/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:covid_19/widgets/my_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:covid_19/screens/home_page_girl.dart';

class profilegirl extends StatefulWidget {
  static const String screenRoute = 'profile_girl_screen';

  const profilegirl({Key? key}) : super(key: key);

  @override
  State<profilegirl> createState() => _profilegirlState();
}

class _profilegirlState extends State<profilegirl> {
  final _auth = FirebaseAuth.instance;
  String name = "";
  String email = "";
  String sex = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "الملف الشخصي",
          style: TextStyle(fontFamily: 'Cairo'),
        ),
        backgroundColor: Color.fromARGB(255, 47, 145, 162),
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/profile.gif'),
            fit: BoxFit.cover,
          ),
        ),
        child: FutureBuilder(
            future: FirebaseFirestore.instance.collection('users').get(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return Center(child: CircularProgressIndicator());
              } else {
                snapshot.data!.docs.forEach((element) {
                  if (element.id == UID) {
                    name = element["User"];
                    email = element["Email"];
                    sex = element["Gender"];
                  }
                });

                return Column(children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 60, 0, 50),
                    child: Stack(
                      children: <Widget>[
                        CircleAvatar(
                          radius: 75,
                          child: CircleAvatar(
                            backgroundColor: Color(0xffff6348),
                            child: ClipOval(
                                child: Image.asset(
                              'images/girlprof.png',
                              width: 140,
                              height: 140,
                              fit: BoxFit.cover,
                            )),
                            radius: 90,
                          ), //CircleAvatar
                        ), //CircleAvatar
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 10, 20, 4),
                    child: Container(
                      height: 60,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                          border: Border.all(
                            width: 3.0,
                            color: Colors.deepOrange,
                          )),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'إسم المستخدم :  ${name}',
                            style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'Cairo',
                                fontSize: 17,
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.right,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 5, 20, 4),
                    child: Container(
                      height: 60,
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('البريد الإلكتروني :  ${email}',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'Cairo',
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold)),
                        ),
                      ),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                          border:
                              Border.all(width: 3.0, color: Colors.deepOrange)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 5, 20, 4),
                    child: Container(
                      height: 60,
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'الجنس :  ${sex}',
                            style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'Cairo',
                                fontSize: 17,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        border:
                            Border.all(width: 3.0, color: Colors.deepOrange),
                      ),
                    ),
                  ),
                ]);
              }
            }),
      ),
    );
  }
}
