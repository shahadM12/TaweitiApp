import 'package:flutter/material.dart';
import 'package:covid_19/widgets/my_button.dart';
import 'package:covid_19/screens/welcome_screen.dart';

class StartScreen extends StatelessWidget {
  static const String screenRoute = 'start_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/poster.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 30),
              MyButton(
                color: Color(0xffff6348),
                title: 'هيا معاً لنبدأ', 
                onPressed: () {
                  Navigator.pushNamed(context, WelcomeScreen.screenRoute);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
