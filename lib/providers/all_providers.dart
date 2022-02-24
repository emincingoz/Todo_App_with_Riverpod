import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/models/todo_model.dart';
import 'package:todo_app/providers/todo_list_manager.dart';
import 'package:uuid/uuid.dart';

final todoListProvider =
    StateNotifierProvider<TodoListManager, List<TodoModel>>((ref) {
  // Boş bir liste ile başlamak için boş verilebilir.
  //return TodoListManager();
  return TodoListManager([
    TodoModel(id: const Uuid().v4(), description: 'Spora git'),
    TodoModel(id: const Uuid().v4(), description: 'Ders çalış'),
    TodoModel(id: const Uuid().v4(), description: 'Alışveriş yap'),
    TodoModel(id: const Uuid().v4(), description: 'Film izle'),
  ]);
});
