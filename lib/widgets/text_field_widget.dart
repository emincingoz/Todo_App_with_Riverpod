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
          decoration: const InputDecoration(
              labelText: 'Neler yapacaksın bugün ?',
              labelStyle: TextStyle(color: Colors.black87),
              border: UnderlineInputBorder(
                  borderSide: BorderSide(color: AppColors.textColor)),
              focusedBorder: UnderlineInputBorder(
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
