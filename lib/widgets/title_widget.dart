import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

class TitleWidget extends StatelessWidget {
  const TitleWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      'todo app',
      textAlign: TextAlign.center,
      style: TextStyle(
          color: Colors.orange,
          fontSize: context.highValue,
          fontWeight: FontWeight.w100),
    );
  }
}
