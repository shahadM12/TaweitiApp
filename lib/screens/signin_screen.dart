import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:covid_19/constants.dart';
import 'package:covid_19/main.dart';
import 'package:covid_19/screens/home_page_boy.dart';
import 'package:covid_19/screens/home_page_girl.dart';

//import 'package:covid_19/screens/home_page_girl.dart';
import 'package:flutter/material.dart';
import 'package:covid_19/widgets/my_button.dart';
import 'package:covid_19/screens/reset.dart';

//import 'package:covid_19/screens/home_page_girl.dart';
//import 'package:covid_19/screens/home_page_boy.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:flutter/services.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:get/get.dart';

class SignInScreen extends StatefulWidget {
  static const String screenRoute = 'signin_screen';

  SignInScreen({Key? key}) : super(key: key);

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _Formkey = GlobalKey<FormState>();
  late String email;
  late String password;

  late bool _isHiddenPassword = true;
  late bool showSpinner = false;
  late String errorMessage = '';

  late var userData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "صفحة تسجيل الدخول",
            style: TextStyle(fontFamily: 'Cairo'),
          ),
          backgroundColor: Color(0xffff6348),
          centerTitle: true,
        ),
        backgroundColor: Color(0xfff1f2f6),
        body: FutureBuilder(
            future: FirebaseFirestore.instance.collection('users').get(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return Form(
                    key: _Formkey,
                    child: ModalProgressHUD(
                      inAsyncCall: showSpinner,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Container(
                                margin: new EdgeInsets.symmetric(
                                    horizontal: 10.0, vertical: 70),
                                //  height: 180,
                                //child: Image.asset('images/w.png'),
                              ),
                              SizedBox(height: 50),
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
                                  return "عذرا هذا الحقل مطلوب!";
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
                                  if (value!.isNotEmpty) {
                                    return null;
                                  }
                                  return "عذرا هذا الحقل مطلوب!";
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
                                      color: Color.fromARGB(255, 153, 156, 158),
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(30),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 10),
                              MyButton(
                                  color: Color(0xffff6348),
                                  title: 'تسجيل الدخول',
                                  onPressed: () async {
                                    //setState(() {
                                    //showSpinner = true;
                                    //});
                                    try {
                                      if (_Formkey.currentState!.validate()) {
                                        await _auth
                                            .signInWithEmailAndPassword(
                                          email: email,
                                          password: password,
                                        )
                                            .then((newUser) async {
                                          UID = newUser.user!.uid;
                                          print(UID);
                                          userData = await FirebaseFirestore
                                              .instance
                                              .collection("users")
                                              .doc(UID)
                                              .get();
                                          print(userData["Gender"]);
                                          /*  userData = await FirebaseFirestore
                                                 .instance
                                                 .collection('user')
                                                 .doc(UID)
                                                 .get();*/
                                          var seasons = FirebaseFirestore
                                              .instance
                                              .collection('users')
                                              .doc(newUser.user!.uid)
                                              .collection('seasons');

                                          getBoolValues(seasons).then((val) {
                                          //  if (newUser != null) {
                                              print(seasonsKeys);
                                           //       if (newUser.user!.emailVerified) {
                                              if (userData["Gender"] ==
                                                  'male') {
                                                print('hi ');
                                                Navigator.of(context)
                                                    .pushReplacementNamed(
                                                        HomePageBoy
                                                            .screenRoute);
                                              } else if (userData["Gender"] ==
                                                  'female') {
                                                print('hi ');

                                                Navigator.of(context)
                                                    .pushReplacementNamed(
                                                        HomePageGirl
                                                            .screenRoute);
                                              } else {
                                                showDialog(
                                                    context: context,
                                                    builder:
                                                        (context) =>
                                                            AlertDialog(
                                                              content: Text(
                                                                'لم يتم التحقق من بريدك الإلكتروني بعد ، إذهب وتحقق.. ',
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        17,
                                                                    color: Colors
                                                                        .red,
                                                                    fontFamily:
                                                                        'Cairo'),
                                                              ),
                                                              actions: [
                                                                TextButton(
                                                                    onPressed:
                                                                        () {
                                                                      {
                                                                        Navigator.of(context)
                                                                            .pop();
                                                                      }
                                                                    },
                                                                    child: Text(
                                                                        'إغلاق',
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                16,
                                                                            color:
                                                                                Colors.blue,
                                                                            fontFamily: 'Cairo')))
                                                              ],
                                                            ));
                                              }
                                            //   }
                                           // }
                                          });
                                        });
                                      }
                                    } on FirebaseAuthException catch (error) {
                                      errorMessage = error.message!;
                                      if (error.code == 'wrong-password') {
                                        AwesomeDialog(
                                            context: context,
                                            title: 'Erorr',
                                            body: Text(
                                                'عذراً، كلمة المرور غير صحيحة !',
                                                style: TextStyle(
                                                  fontFamily: 'Cairo',
                                                  color: Colors.black,
                                                  fontSize: 20,
                                                )))
                                          ..show();
                                        //
                                      } else if (error.code ==
                                          'user-not-found') {
                                        AwesomeDialog(
                                            context: context,
                                            title: 'Erorr',
                                            body: Text(
                                              'عذراً، لايوجد بريد إلكتروني بهذا العنوان !',
                                              style: TextStyle(
                                                fontFamily: 'Cairo',
                                                color: Colors.black,
                                                fontSize: 20,
                                              ),
                                            ))
                                          ..show();

                                        //
                                      } else if (error.code ==
                                          'too-many-requests') {
                                        AwesomeDialog(
                                            context: context,
                                            title: 'Erorr',
                                            body: Text(
                                              'عذراً، حدث خطأ اعد المحاولة لاحقا ..',
                                              style: TextStyle(
                                                fontFamily: 'Cairo',
                                                color: Colors.black,
                                                fontSize: 20,
                                              ),
                                            ))
                                          ..show();
                                      }
                                      print(error.message);

                                      //errorMessage;

                                      //  setState(() {
                                      //  showSpinner = false;
                                      //  });
                                    }
                                  }),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  TextButton(
                                    child: Text(
                                      'هل نسيت كلمة السر؟',
                                      style: TextStyle(
                                          fontFamily: 'Cairo', fontSize: 16),
                                    ),
                                    onPressed: () => Navigator.of(context)
                                        .push(MaterialPageRoute(
                                      builder: (context) => ResetScreen(),
                                    )),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ));
              }
            }));
  }

  void _togglePasswordView() {
    setState(() {
      _isHiddenPassword = !_isHiddenPassword;
    });
  }

  Future getBoolValues(seasons) async {
    var s1 = await seasons.doc('1').get();
    print(s1.data());
    var s2 = await seasons.doc('2').get();
    print(s2.data());
    var s3 = await seasons.doc('3').get();
    print(s3.data());
    var v11 = await seasons.doc('1').collection('videos').doc('1').get();
    var v12 = await seasons.doc('1').collection('videos').doc('2').get();
    var v13 = await seasons.doc('1').collection('videos').doc('3').get();
    var v21 = await seasons.doc('2').collection('videos').doc('1').get();
    var v22 = await seasons.doc('2').collection('videos').doc('2').get();
    var v23 = await seasons.doc('2').collection('videos').doc('3').get();
    var v24 = await seasons.doc('2').collection('videos').doc('4').get();
    var v31 = await seasons.doc('3').collection('videos').doc('1').get();
    var v32 = await seasons.doc('3').collection('videos').doc('2').get();
    var v33 = await seasons.doc('3').collection('videos').doc('3').get();
    setState(() {
      seasonsKeys[0] = s1.data()['finishSeason'];
      seasonsKeys[1] = s2.data()['finishSeason'];
      seasonsKeys[2] = s3.data()['finishSeason'];

      videosInSeasons[0][0] = v11.data()['finishVideo'];
      videosInSeasons[0][1] = v12.data()['finishVideo'];
      videosInSeasons[0][2] = v13.data()['finishVideo'];
      videosInSeasons[1][0] = v21.data()['finishVideo'];
      videosInSeasons[1][1] = v22.data()['finishVideo'];
      videosInSeasons[1][2] = v23.data()['finishVideo'];
      videosInSeasons[1][3] = v24.data()['finishVideo'];
      videosInSeasons[2][0] = v31.data()['finishVideo'];
      videosInSeasons[2][1] = v32.data()['finishVideo'];
      videosInSeasons[2][2] = v33.data()['finishVideo'];
    });
  }
}
