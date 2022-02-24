// ignore_for_file: must_be_immutable, type_init_formals

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/models/todo_model.dart';
import 'package:todo_app/providers/all_providers.dart';

class TodoListItemWidget extends ConsumerWidget {
  TodoModel item;
  TodoListItemWidget({Key? key, required TodoModel this.item})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListTile(
      leading: Checkbox(
          value: item.completed,
          onChanged: (value) {
            ref.read(todoListProvider.notifier).toogle(item.id);
          }),
      title: Text(item.description),
    );
  }
}
