// ignore_for_file: must_be_immutable, type_init_formals

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/models/todo_model.dart';
import 'package:todo_app/providers/all_providers.dart';

class TodoListItemWidget extends ConsumerStatefulWidget {
  TodoModel item;
  TodoListItemWidget({Key? key, required TodoModel this.item})
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
    return Focus(
      onFocusChange: (isFocused) {
        if (!isFocused) {
          setState(() {
            _hasFocus = false;
          });

          ref
              .read(todoListProvider.notifier)
              .edit(id: widget.item.id, newDescription: _textController.text);
        }
      },
      child: ListTile(
        onTap: () {
          setState(() {
            _hasFocus = true;
            _textController.text = widget.item.description;
            _textFocusNode.requestFocus();
          });
        },
        leading: Checkbox(
            //
            // Kurucu method üzerinden ulaşıldığı için widget.item.completed şeklinde güncellendi
            value: widget.item.completed,
            onChanged: (value) {
              ref.read(todoListProvider.notifier).toogle(widget.item.id);
            }),
        title: _hasFocus
            ? TextField(
                controller: _textController,
                focusNode: _textFocusNode,
              )
            : Text(widget.item.description),
      ),
    );
  }
}
