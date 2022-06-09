import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:covid_19/constants.dart';
import 'package:covid_19/screens/signin_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:covid_19/widgets/my_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import 'package:covid_19/screens/home_page_girl.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:google_language_fonts/google_language_fonts.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:get/get.dart';

enum GenderEnum { male, famele }

class RegistrationScreen extends StatefulWidget {
  static const String screenRoute = 'register_screen';

  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

GenderEnum _userGender = GenderEnum.male;

class _RegistrationScreenState extends State<RegistrationScreen> {
  late bool _isHiddenPassword = true;
  final Formkey = GlobalKey<FormState>();

  final _auth = FirebaseAuth.instance;
  late String user;
  late String email;
  late String password;

  late String errorMessage = '';
  late bool showSpinner = false;
  String? _userGender;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "صفحة التسجيل",
          style: TextStyle(fontFamily: 'Cairo'),
        ),
        backgroundColor: Color(0xffff6348),
        centerTitle: true,
      ),
      backgroundColor: Color(0xfff1f2f6),
      body: Form(
        key: Formkey,
        child: ModalProgressHUD(
          inAsyncCall: showSpinner,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Container(
                    margin: new EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 70.0),
                    //  height: 180,
                    //child: Image.asset('images/w.png'),
                  ),

                  SizedBox(height: 30),
                  TextFormField(
                    style: TextStyle(fontFamily: 'Cairo'),
                    textAlign: TextAlign.right,
                    onChanged: (value) {
                      user = value;
                    },
                    validator: (String? value) {
                      if (value!.isNotEmpty && value.length > 3) {
                        return null;
                      } else if (value.length < 4 && value.isNotEmpty) {
                        return "عذرا الإسم قصير جداً!";
                      }
                      return "عذرا هذا الحقل مطلوب!";
                    },
                    decoration: InputDecoration(
                      hintText: 'أدخل إسم المستخدم ',
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 20,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(30),
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xffff6348),
                          width: 1,
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(30),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.blue,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(30),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 8),
                  TextFormField(
                    style: TextStyle(fontFamily: 'Cairo'),
                    textAlign: TextAlign.right,
                    onChanged: (value) {
                      email = value;
                    },
                    validator: (String? value) {
                      if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                              .hasMatch(value!) &&
                          value.isNotEmpty) {
                        return 'عذراً أدخل بريد إلكتروني صالح!';
                      }
                      if (value.isNotEmpty) {
                        return null;
                      }
                      return "عذراً هذا الحقل مطلوب!";
                    },
                    decoration: InputDecoration(
                      hintText: 'أدخل البريد الإلكتروني',
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 20,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(30),
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xffff6348),
                          width: 1,
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(30),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.blue,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(30),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 8),
                  TextFormField(
                    style: TextStyle(fontFamily: 'Cairo'),
                    textAlign: TextAlign.right,
                    onChanged: (value) {
                      password = value;
                    },
                    validator: (String? value) {
                      if (value!.length < 8 && value.isNotEmpty) {
                        return 'عذراً يجب أن تتكون كلمة المرور من 8 أحرف على الأقل!';
                      }
                      if (value.isNotEmpty) {
                        return null;
                      }
                      return 'عذراً هذا الحقل مطلوب!';
                    },
                    obscureText: _isHiddenPassword,
                    decoration: InputDecoration(
                      hintText: 'أدخل كلمة السر',
                      suffixIcon: InkWell(
                          onTap: _togglePasswordView,
                          child: Icon(Icons.visibility)),
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 20,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(30),
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xffff6348),
                          width: 1,
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(30),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.blue,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(30),
                        ),
                      ),
                    ),
                  ),

                  //
                  SizedBox(height: 8),
                  Stack(
                    children: [
                      TextFormField(
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.zero,
                              border: InputBorder.none),
                          validator: (val) {
                            if (_userGender == null) {
                              return "الرجاء تحديد الجنس";
                            }
                          }),
                      Row(children: <Widget>[
                        Radio<String>(
                          value: 'male',
                          groupValue: _userGender,
                          onChanged: (value) {
                            setState(() {
                              _userGender = value!;
                            });
                          },
                        ),
                        Text(
                          "ذكر",
                          style: TextStyle(fontFamily: 'Cairo'),
                        ),
                        Icon(Icons.male),
                        Radio<String>(
                          value: 'female',
                          groupValue: _userGender,
                          onChanged: (value) {
                            setState(() {
                              _userGender = value!;
                            });
                          },
                        ),
                        Text(
                          "أنثى",
                          style: TextStyle(fontFamily: 'Cairo'),
                        ),
                        Icon(Icons.female),
                      ]),
                      //
                    ],
                  ),
                  //
                  SizedBox(width: 30),
                  MyButton(
                    color: Color(0xffff6348),
                    title: 'تسجيل',
                    onPressed: () async {
                      setState(() {
                        showSpinner = true;
                      });
                      try {
                        if (Formkey.currentState!.validate()) {
                          await _auth
                              .createUserWithEmailAndPassword(
                            email: email,
                            password: password,
                          )
                              .then((newUser) {
                            // if (newUser == newUser) {
                            newUser.user!.sendEmailVerification().then((value) {
                              createUser(newUser.user!.uid);
                              UID = newUser.user!.uid;
                            }).then((value) {
                              showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                        content: Text(
                                            'تم إرسال رسالة التحقق إلى البريد الإلكتروني',
                                            style: TextStyle(
                                                fontSize: 17,
                                                color: Colors.red,
                                                fontFamily: 'Cairo')),
                                        actions: [
                                          TextButton(
                                              onPressed: () {
                                                Navigator.of(context)
                                                    .pushReplacementNamed(
                                                        SignInScreen
                                                            .screenRoute);
                                              },
                                              child: Text('إغلاق',
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      color: Colors.blue,
                                                      fontFamily: 'Cairo')))
                                        ],
                                      ));
                            });
                          });
                        }
                      } on FirebaseAuthException catch (error) {
                        if (error.code == 'email-already-in-use') {
                          errorMessage = error.message!;
                          AwesomeDialog(
                              context: context,
                              title: 'Error',
                              body: Text(
                                'عذراً،البريد الإلكتروني مستخدم بالفعل! ',
                                style: TextStyle(
                                  fontFamily: 'Cairo',
                                  color: Colors.black,
                                  fontSize: 15,
                                ),
                              ))
                            ..show();
                        }
                        //
                        if (error.code == 'weak-password') {
                          AwesomeDialog(
                              context: context,
                              title: 'Error',
                              body: Text(
                                'عذراً، كلمة المرور ضعيفه جداً!',
                                style: TextStyle(
                                  fontFamily: 'Cairo',
                                  color: Colors.black,
                                  fontSize: 15,
                                ),
                              ))
                            ..show();
                        }
                        print(error.message);
                      }
                      setState(() {
                        showSpinner = false;
                      });
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  //

  void _togglePasswordView() {
    setState(() {
      _isHiddenPassword = !_isHiddenPassword;
    });
  }

  createUser(String uid) {
    FirebaseFirestore.instance.collection("users").doc(uid).set({
      'User': user,
      'Email': email,
      'Password': password,
      'Gender': _userGender,
    }).then((value) {
      createSeasons(uid);
    });
  }

  createSeasons(String uid) {
    var seasons = FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('seasons');
    setupCollections(seasons, '1');
    setupCollections(seasons, '2');
    setupCollections(seasons, '3');
  }

  setupCollections(seasons, String docNum) {
    seasons.doc(docNum).set({'finishSeason': false});
    var videos = seasons.doc(docNum).collection('videos');
    setupVideos(videos, '1');
    setupVideos(videos, '2');
    setupVideos(videos, '3');
    if (docNum == '2') setupVideos(videos, '4');
  }

  setupVideos(questions, String docNum) {
    questions.doc(docNum).set({'finishVideo': false});
  }
}
