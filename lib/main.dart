import 'package:covid_19/screens/home_page_boy.dart';
import 'package:covid_19/screens/home_page_girl.dart';
import 'package:covid_19/screens/profileboy.dart';
import 'package:covid_19/screens/progress_screen.dart';
import 'package:flutter/material.dart';
import 'package:covid_19/screens/registration_screen.dart';
import 'package:covid_19/screens/signin_screen.dart';
import 'package:covid_19/screens/welcome_screen.dart';
import 'screens/start.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_language_fonts/google_language_fonts.dart';
import 'package:get/get.dart';
import 'package:covid_19/screens/profilegirl.dart';
import 'package:covid_19/screens/reset.dart';
import 'package:covid_19/screens/story.dart';
import 'package:covid_19/screens/pages_boy/chapter1.dart';
import 'package:covid_19/screens/pages_boy/chapter2.dart';
import 'package:covid_19/screens/pages_boy/chapter3.dart';
import 'package:covid_19/screens/pages_boy/chapter1_clips.dart/wash_hands.dart';
import 'package:covid_19/screens/pages_boy/chapter1_clips.dart/bathing.dart';
import 'package:covid_19/screens/pages_boy/chapter1_clips.dart/wash_teeth.dart';
import 'package:covid_19/screens/pages_boy/chapter2_clips.dart/gloves.dart';
import 'package:covid_19/screens/pages_boy/chapter2_clips.dart/mask.dart';
import 'package:covid_19/screens/pages_boy/chapter2_clips.dart/soap.dart';
import 'package:covid_19/screens/pages_boy/chapter2_clips.dart/sterilizer.dart';
import 'package:covid_19/screens/pages_boy/chapter3_clips.dart/spacing.dart';
import 'package:covid_19/screens/pages_boy/chapter3_clips.dart/things.dart';
import 'package:covid_19/screens/pages_boy/chapter3_clips.dart/touch.dart';
import 'package:covid_19/screens/pages_boy/chapter1_clips.dart/quiz_chapter1.dart';
import 'package:covid_19/screens/pages_boy/chapter2_clips.dart/quiz_chapter2.dart';
import 'package:covid_19/screens/pages_boy/chapter3_clips.dart/quiz_chapter3.dart';
//

import 'package:covid_19/screens/pages_girl/chapter1G.dart';
import 'package:covid_19/screens/pages_girl/chapter2G.dart';
import 'package:covid_19/screens/pages_girl/chapter3G.dart';
import 'package:covid_19/screens/pages_girl/chapter1_clipsG.dart/bathingG.dart';
import 'package:covid_19/screens/pages_girl/chapter1_clipsG.dart/washG.dart';
import 'package:covid_19/screens/pages_girl/chapter1_clipsG.dart/teethG.dart';
import 'package:covid_19/screens/pages_girl/chapter2_clipsG.dart/soapG.dart';
import 'package:covid_19/screens/pages_girl/chapter2_clipsG.dart/maskG.dart';
import 'package:covid_19/screens/pages_girl/chapter2_clipsG.dart/glovG.dart';
import 'package:covid_19/screens/pages_girl/chapter2_clipsG.dart/sterilizerG.dart';
import 'package:covid_19/screens/pages_girl/chapter3_clipsG.dart/spacingG.dart';
import 'package:covid_19/screens/pages_girl/chapter3_clipsG.dart/touchG.dart';
import 'package:covid_19/screens/pages_girl/chapter3_clipsG.dart/thingsG.dart';

import 'package:covid_19/screens/pages_girl/chapter1_clipsG.dart/quiz_chapter1G.dart';
import 'package:covid_19/screens/pages_girl/chapter2_clipsG.dart/quiz_chapter2G.dart';
import 'package:covid_19/screens/pages_girl/chapter3_clipsG.dart/quiz_chapter3G.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: [
          Locale('ar', 'AE'),
        ],
        debugShowCheckedModeBanner: false,
        title: 'Corona app',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        //home:
        initialRoute: StartScreen.screenRoute,
        routes: {
          WelcomeScreen.screenRoute: (context) => WelcomeScreen(),
          SignInScreen.screenRoute: (context) => SignInScreen(),
          RegistrationScreen.screenRoute: (context) => RegistrationScreen(),
          StartScreen.screenRoute: (context) => StartScreen(),
          HomePageGirl.screenRoute: (context) => HomePageGirl(),
          HomePageBoy.screenRoute: (context) => HomePageBoy(),
          profilegirl.screenRoute: (context) => profilegirl(),
          profileboy.screenRoute: (context) => profileboy(),
          ResetScreen.screenRoute: (context) => ResetScreen(),
          Story.screenRoute: (context) => Story(),
          Chapter1.screenRoute: (context) => Chapter1(),
          Chapter2.screenRoute: (context) => Chapter2(),
          Chapter3.screenRoute: (context) => Chapter3(),
          Wash_hands.screenRoute: (context) => Wash_hands(),
          bathing.screenRoute: (context) => bathing(),
          wash_teeth.screenRoute: (context) => wash_teeth(),
          gloves.screenRoute: (context) => gloves(),
          mask.screenRoute: (context) => mask(),
          soap.screenRoute: (context) => soap(),
          sterilizer.screenRoute: (context) => sterilizer(),
          touch.screenRoute: (context) => touch(),
          spacing.screenRoute: (context) => spacing(),
          things.screenRoute: (context) => things(),
          quiz_chapter1.screenRoute: (context) => quiz_chapter1(),
          quiz_chapter2.screenRoute: (context) => quiz_chapter2(),
          quiz_chapter3.screenRoute: (context) => quiz_chapter3(),
          Chapter1G.screenRoute: (context) => Chapter1G(),
          Chapter2G.screenRoute: (context) => Chapter2G(),
          Chapter3G.screenRoute: (context) => Chapter3G(),
          ProgressScreen.screenRoute: (context) => ProgressScreen(),
          //
          WashG.screenRoute: (context) => WashG(),
          teethG.screenRoute: (context) => teethG(),
          bathingG.screenRoute: (context) => bathingG(),
          soapG.screenRoute: (context) => soapG(),
          maskG.screenRoute: (context) => maskG(),
          glovG.screenRoute: (context) => glovG(),
          sterilizerG.screenRoute: (context) => sterilizerG(),
          touchG.screenRoute: (context) => touchG(),
          spacingG.screenRoute: (context) => spacingG(),
          thingsG.screenRoute: (context) => thingsG(),

          quiz_chapter1G.screenRoute: (context) => quiz_chapter1G(),
          quiz_chapter2G.screenRoute: (context) => quiz_chapter2G(),
          quiz_chapter3G.screenRoute: (context) => quiz_chapter3G(),

          //    AssetAudio.screenRoute:(context) => AssetAudio(),
        });
  }
}
