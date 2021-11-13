import 'package:flutter/material.dart';
import 'package:weather/view/componants/reusable_text_widget.dart';

class MainDataWidget extends StatelessWidget {
  String value;
  String heading;
  MainDataWidget({
    required this.heading,
    required this.value,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ReusableTextWidget(
          fontSize: 14,
          title: value,
        ),
        SizedBox(
          height: 5,
        ),
        ReusableTextWidget(
          fontSize: 16,
          title: heading,
        ),
      ],
    );
  }
}
