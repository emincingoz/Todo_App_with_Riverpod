// ignore_for_file: must_be_immutable, type_init_formals

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/constants/app_colors.dart';
import 'package:todo_app/providers/all_providers.dart';

class TodoListItemWidget extends ConsumerStatefulWidget {
  //
  // Buradaki item'dan ve constructor ile verilmesinden daha efektik bir yol olarak yeni bir provider oluşturuldu
  //
  //TodoModel item;
  TodoListItemWidget({Key? key
      /*required TodoModel this.item*/
      })
      : super(key: key);
  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _TodoListItemWidgetState();
}

class _TodoListItemWidgetState extends ConsumerState<TodoListItemWidget> {
  late FocusNode _textFocusNode;
  late TextEditingController _textController;
  bool _hasFocus = false;

  @override
  void initState() {
    super.initState();

    _textFocusNode = FocusNode();
    _textController = TextEditingController();
  }

  @override
  void dispose() {
    // to avoid memory leak
    _textFocusNode.dispose();
    _textController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentTodoItem = ref.watch(currentTodoProvider);

    return Focus(
      onFocusChange: (isFocused) {
        if (!isFocused) {
          setState(() {
            _hasFocus = false;
          });

          ref.read(todoListProvider.notifier).edit(
              id: currentTodoItem.id, newDescription: _textController.text);
        }
      },
      child: ListTile(
        onTap: () {
          setState(() {
            _hasFocus = true;
            _textController.text = currentTodoItem.description;
            _textFocusNode.requestFocus();
          });
        },
        leading: Checkbox(
            value: currentTodoItem.completed,
            onChanged: (value) {
              ref.read(todoListProvider.notifier).toogle(currentTodoItem.id);
            }),
        title: _hasFocus
            ? TextField(
                controller: _textController,
                focusNode: _textFocusNode,
                decoration: const InputDecoration(
                    border: UnderlineInputBorder(
                        borderSide: BorderSide(color: AppColors.textColor)),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: AppColors.textColor))),
                cursorColor: AppColors.textColor,
              )
            : Text(currentTodoItem.description),
      ),
    );
  }
}
