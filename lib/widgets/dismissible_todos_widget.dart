// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/models/todo_model.dart';

import '../providers/all_providers.dart';
import 'todo_list_item_widget.dart';

class DismissibleTodos extends ConsumerWidget {
  late TodoModel todo;
  DismissibleTodos({Key? key, required this.todo}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Dismissible(
      key: ValueKey(todo.id),
      onDismissed: (_) {
        ref.read(todoListProvider.notifier).remove(todo);
      },
      child: ProviderScope(
        //
        // Burada overrides ile ProviderScope içerisindeki child'e provider tanımlandı.
        // overrides içerisinde override edilen provider, all_providers'de return edecek herhangi bir veriye sahip değildi.
        // overrides içerisinde, allTodos[i], currentTodo provider'ine atandı.
        overrides: [
          currentTodoProvider.overrideWithValue(todo),
        ],
        //child: TodoListItemWidget(item: allTodos[i]),
        child: TodoListItemWidget(),
      ),
    );
  }
}
