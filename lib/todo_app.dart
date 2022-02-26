// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kartal/kartal.dart';
import 'package:todo_app/constants/app_colors.dart';
import 'package:todo_app/providers/all_providers.dart';
import 'package:todo_app/widgets/dismissible_todos_widget.dart';
import 'package:todo_app/widgets/text_field_widget.dart';
import 'package:todo_app/widgets/title_widget.dart';
import 'package:todo_app/widgets/todo_list_item_widget.dart';

import 'widgets/toolbar_widget.dart';

class TodoApp extends ConsumerWidget {
  const TodoApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var allTodos = ref.watch(filteredTodoList);
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
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
          ToolBarWidget(),
          allTodos.isEmpty
              ? const Center(
                  child: Text('Bu koşullarda herhangi bir görev yok'))
              : const SizedBox(),
          for (var i = 0; i < allTodos.length; i++)
            DismissibleTodos(todo: allTodos[i])
        ],
      ),
    );
  }
}
