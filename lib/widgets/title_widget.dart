import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:todo_app/constants/app_colors.dart';

class TitleWidget extends StatelessWidget {
  const TitleWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          top: context.mediumValue + (context.lowValue / 2),
          bottom: context.mediumValue),
      child: Text(
        'todo app',
        textAlign: TextAlign.center,
        style: TextStyle(
            color: AppColors.textColor,
            fontSize: context.highValue,
            fontWeight: FontWeight.w300),
      ),
    );
  }
}
