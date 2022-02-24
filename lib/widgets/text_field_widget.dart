import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/providers/all_providers.dart';

class TextFieldWidget extends StatelessWidget {
  TextFieldWidget({Key? key}) : super(key: key);

  final todoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        return TextField(
          decoration:
              const InputDecoration(labelText: 'Neler yapacaksın bugün ?'),
          controller: todoController,
          onSubmitted: (newTodo) {
            ref.read(todoListProvider.notifier).addTodo(newTodo);
          },
        );
      },
    );
  }
}
