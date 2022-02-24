// ignore_for_file: must_be_immutable, type_init_formals

import 'package:flutter/material.dart';
import 'package:todo_app/models/todo_model.dart';

class TodoListItemWidget extends StatelessWidget {
  TodoModel todoModel;
  TodoListItemWidget({Key? key, required TodoModel this.todoModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Checkbox(
          value: true,
          onChanged: (value) {
            debugPrint(value.toString());
          }),
      title: Text(todoModel.description),
    );
  }
}
