import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:covid_19/screens/signin_screen.dart';
import 'package:covid_19/widgets/my_button.dart';

class ResetScreen extends StatefulWidget {
  const ResetScreen({Key? key}) : super(key: key);
  static const String screenRoute = 'reset_screen';

  @override
  _ResetScreenState createState() => _ResetScreenState();
}

class _ResetScreenState extends State<ResetScreen> {
  late String email;
  final auth = FirebaseAuth.instance;

  Future<void> resetPassword(String email) async {
    await auth.sendPasswordResetEmail(email: email);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffff6348),
        title: Text(
          'نسيان كلمة السر',
          style: TextStyle(
            fontFamily: 'Cairo',
            fontSize: 18,
            fontWeight: FontWeight.w900,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(28.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                style: TextStyle(fontFamily: 'Cairo', fontSize: 16),
                textAlign: TextAlign.right,
                keyboardType: TextInputType.emailAddress,
                decoration:
                    InputDecoration(hintText: 'فضلاً أدخل البريد الإلكتروني'),
                onChanged: (value) {
                  setState(() {
                    email = value.trim();
                  });
                },
              ),
            ),
            SizedBox(),
            MyButton(
              color: Color(0xffff6348),
              title: 'إرسال طلب ',
              onPressed: () {
                {
                  resetPassword(email);
                  showDialog(
                                              context: context,
                                              builder: (context) => AlertDialog(
                                                    content: Text(
                                                      'تم إرسال رسالة طلب التغيير إلى البريد الإلكتروني ',
                                                      style: TextStyle(
                                                          fontSize: 17,
                                                          color: Colors.red,
                                                          fontFamily: 'Cairo'),
                                                    ),
                                                    actions: [
                                                      TextButton(
                                                          onPressed: () {
                                                            {
                                                              Navigator.of(
                                                                      context)
                                                                  .pushReplacementNamed(
                                                                      SignInScreen
                                                                          .screenRoute);
                                                            }
                                                          },
                                                          child: Text('إغلاق',
                                                              style: TextStyle(
                                                                  fontSize: 16,
                                                                  color:
                                                                      Colors.blue,
                                                                  fontFamily:
                                                                      'Cairo')))
                                                    ],
                                                  ));
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
