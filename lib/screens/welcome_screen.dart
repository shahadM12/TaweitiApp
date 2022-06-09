import 'package:covid_19/screens/registration_screen.dart';
import 'package:covid_19/screens/signin_screen.dart';
import 'package:flutter/material.dart';
import 'package:covid_19/widgets/my_button.dart';

class WelcomeScreen extends StatefulWidget {
  static const String screenRoute = 'welcome_screen';
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('images/poster.png'),
              fit: BoxFit.cover,
            ),
          ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(25, 40, 25,170),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
                  Text(
                    'مرحباً بكم!',
                    style: TextStyle(
                      fontFamily: 'Cairo',
                      fontSize: 40,
                      fontWeight: FontWeight.w900,
                      color: Color.fromARGB(255, 0, 0, 0),
                    ),
                  ),
                
              
            SizedBox(height: 30),
              MyButton(
                color:  Color.fromARGB(255, 47, 145, 162),
                title: 'تسجيل الدخول',
                onPressed: () {
                Navigator.push(context
                  , MaterialPageRoute(builder: (ctx)=>SignInScreen()));
                },
              ),
              MyButton(
                color: Color(0xffff6348),
                title: 'تسجيل حساب جديد',
                onPressed: () {
                  Navigator.pushNamed(context, RegistrationScreen.screenRoute);
                },
              )
            ])
          ),
      ),
      
    );
  }
}
