import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:todo_app/models/todo_model.dart';
import 'package:todo_app/providers/todo_list_manager.dart';

final hiveProvider = FutureProvider<List<TodoModel>>((ref) async {
  await Hive.openBox<TodoModel>('todos');
  var box = Hive.box<TodoModel>('todos');
  List<TodoModel> allTodos = [];

  box.values.forEach((todo) {
    allTodos.add(TodoModel(
        id: todo.id, description: todo.description, completed: todo.completed));
  });

  box.close();
  return allTodos;
});

final todoListProvider =
    StateNotifierProvider<TodoListManager, List<TodoModel>>((ref) {
  var list = ref.watch(hiveProvider).value;

  return TodoListManager(list);
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
