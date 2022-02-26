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

final unCompletedTodoCount = Provider<int>((ref) {
  final allTodo = ref.watch(todoListProvider);
  final count = allTodo.where((element) => element.completed == false).length;

  return count;
});

final currentTodoProvider = Provider<TodoModel>((ref) {
  //
  // Burada provider'in ne döndüreceği bilinmiyor.
  // döndüreceği değer TodoApp widgeti içerisinde override edilerek yazıldı.
  throw UnimplementedError();
});

final todoListFilter =
    StateProvider<TodoListFilter>((ref) => TodoListFilter.all);

final filteredTodoList = Provider<List<TodoModel>>((ref) {
  final filter = ref.watch(todoListFilter);
  final todoList = ref.watch(todoListProvider);

  switch (filter) {
    case TodoListFilter.all:
      return todoList;
    case TodoListFilter.completed:
      return todoList.where((element) => element.completed == true).toList();
    case TodoListFilter.active:
      return todoList.where((element) => element.completed == false).toList();
  }
});
