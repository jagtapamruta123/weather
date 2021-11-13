import 'package:flutter/material.dart';

class ReusableTextWidget extends StatelessWidget {
  String? title;
  double? fontSize;
  ReusableTextWidget({Key? key, this.title, this.fontSize}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      title!,
      style: TextStyle(
        color: Colors.white,
        fontSize: fontSize,
        letterSpacing: 1,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}
