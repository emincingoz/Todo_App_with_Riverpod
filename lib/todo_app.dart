// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kartal/kartal.dart';
import 'package:todo_app/providers/all_providers.dart';
import 'package:todo_app/widgets/text_field_widget.dart';
import 'package:todo_app/widgets/title_widget.dart';
import 'package:todo_app/widgets/todo_list_item_widget.dart';

import 'widgets/toolbar_widget.dart';

class TodoApp extends ConsumerWidget {
  const TodoApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var allTodos = ref.watch(todoListProvider);
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
                onDismissed: (_) {
                  ref.read(todoListProvider.notifier).remove(allTodos[i]);
                },
                child: TodoListItemWidget(item: allTodos[i])),
        ],
      ),
    );
  }
}
