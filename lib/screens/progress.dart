import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class PrograssPage extends StatefulWidget {
  const PrograssPage({Key? key}) : super(key: key);

  @override
  State<PrograssPage> createState() => _PrograssPageState();
}

class _PrograssPageState extends State<PrograssPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'التقدم',
        ),
        centerTitle: true,
      ),
      body: Center(child: CircularPercentIndicator(
                  radius: 60.0,
                  lineWidth: 5.0,
                  percent: 1.0,
                  center: new Text("100%"),
                  progressColor: Colors.green,
                )),
    );
  }
}
