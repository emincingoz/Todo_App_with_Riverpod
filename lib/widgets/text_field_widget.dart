import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  TextFieldWidget({Key? key}) : super(key: key);

  final todoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: const InputDecoration(labelText: 'Neler yapacaksın bugün ?'),
      controller: todoController,
      onSubmitted: (newTodo) {
        debugPrint('şunu ekle $newTodo');
      },
    );
  }
}
