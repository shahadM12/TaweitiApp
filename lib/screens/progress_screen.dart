import 'package:covid_19/constants.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class ProgressScreen extends StatefulWidget {
  static const String screenRoute = 'progress_screen';
  const ProgressScreen({Key? key}) : super(key: key);

  @override
  State<ProgressScreen> createState() => _ProgressScreenState();
}

class _ProgressScreenState extends State<ProgressScreen> {
  double percent = 0.0;
  String text = '0/10';
  setPercent(){
    if(seasonsKeys[0]){
      percent += 0.3;
      text = "3/10";
    }
    if(seasonsKeys[1]){
      percent += 0.4;
      text = "7/10";

    }
    if(seasonsKeys[2]){
      percent += 0.3;
      text = "10/10";
    }
  }

  @override
  void initState() {
    super.initState();
    setPercent();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      title: Text(
      "التقدم",
      style: TextStyle(fontFamily: 'Cairo'),
    ),
    backgroundColor: Color.fromARGB(255, 47, 145, 162),
    centerTitle: true,
    ),//Color.fromARGB(255, 47, 145, 162),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularPercentIndicator(
              radius: 120.0,
              lineWidth: 13.0,
              animation: true,
              percent: percent,
              center:  Text(
                text,
                style:
                 TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
              ),
              footer:  Text(
                "التقدم الحالي",
                style:
                new TextStyle(fontWeight: FontWeight.bold, fontSize: 17.0,
                fontFamily: 'Cairo'),
              ),
              circularStrokeCap: CircularStrokeCap.round,
              progressColor: Color(0xffff6348),
            ),
          ],
        ),
      ),
    );
  }
}
