import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/constants/app_colors.dart';
import 'package:todo_app/providers/all_providers.dart';

class TextFieldWidget extends StatelessWidget {
  TextFieldWidget({Key? key}) : super(key: key);

  final todoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        return TextField(
          decoration: InputDecoration(
              labelText: "textfield_text".tr(),
              labelStyle: const TextStyle(color: Colors.black87),
              border: const UnderlineInputBorder(
                  borderSide: BorderSide(color: AppColors.textColor)),
              focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: AppColors.textColor))),
          cursorColor: AppColors.textColor,
          controller: todoController,
          onSubmitted: (newTodo) {
            if (newTodo.length > 3)
              ref.read(todoListProvider.notifier).addTodo(newTodo);
          },
        );
      },
    );
  }
}
