import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  MyButton(
      {required this.color,
      required this.title,
      required this.onPressed,
        this.enable = true
     });

  late final Color color;
  late final String title;
  late final VoidCallback onPressed;
  bool enable ;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Material(
        elevation: 5,
        color: color,
        borderRadius: BorderRadius.circular(30),
        child: MaterialButton(

          onPressed: enable ? onPressed : null,
          minWidth: 50,
          height: 42,
          child: Text(
            title,
            style: TextStyle(
                color: Colors.white, fontSize: 18, fontFamily: 'Cairo'),
          ),
        ),
      ),
    );
  }
}
