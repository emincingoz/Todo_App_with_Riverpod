// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:todo_app/models/todo_model.dart';
import 'package:todo_app/widgets/text_field_widget.dart';
import 'package:todo_app/widgets/title_widget.dart';
import 'package:todo_app/widgets/todo_list_item_widget.dart';
import 'package:uuid/uuid.dart';

import 'widgets/toolbar_widget.dart';

class TodoApp extends StatelessWidget {
  TodoApp({Key? key}) : super(key: key);

  List<TodoModel> allTodos = [
    TodoModel(id: const Uuid().v4(), description: 'Spora Git'),
    TodoModel(id: const Uuid().v4(), description: 'Alışverişe yap'),
    TodoModel(id: const Uuid().v4(), description: 'Ders çalış'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.symmetric(
          horizontal: context.mediumValue,
          vertical: context.mediumValue,
        ),
        shrinkWrap: true,
        children: [
          const TitleWidget(),
          TextFieldWidget(),
          SizedBox(height: context.mediumValue),
          const ToolBarWidget(),
          for (var i = 0; i < allTodos.length; i++)
            Dismissible(
                key: ValueKey(allTodos[i].id),
                onDismissed: (_) {},
                child: TodoListItemWidget(todoModel: allTodos[i])),
        ],
      ),
    );
  }
}
