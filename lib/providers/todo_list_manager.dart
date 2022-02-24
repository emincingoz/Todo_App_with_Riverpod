import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/models/todo_model.dart';
import 'package:uuid/uuid.dart';

class TodoListManager extends StateNotifier<List<TodoModel>> {
  TodoListManager([List<TodoModel>? initialTodos]) : super(initialTodos ?? []);

  void addTodo(String description) {
    //
    // yeni bir state oluşturur.
    //önce var olan liste içerisindeki elemanları yeni listeye ekle sonra yeni TodoModeli listenin sonuna ekle
    state = [
      ...state,
      TodoModel(id: const Uuid().v4(), description: description)
    ];
  }

  void toogle(String id) {
    //
    // yeni bir state oluşturuldu.
    // state, List<TodoModel> yapısını tutmktadır.
    state = [
      // collectional for loop
      // state: List<TodoModel>
      for (var todo in state)
        // parametre olarak gelen id değerinde bir Todo var ise todonun completed bilgisini değiştir.
        // id bilgisi uymuyorsa yeni listeye olduğu gibi aktar.
        if (todo.id == id)
          TodoModel(
              id: todo.id,
              description: todo.description,
              completed: !todo.completed)
        else
          todo
    ];
  }

  void edit({required String id, required String newDescription}) {
    state = [
      for (var todo in state)
        if (todo.id == id)
          TodoModel(
              id: todo.id,
              description: newDescription,
              completed: todo.completed)
        else
          todo
    ];
  }

  void remove(TodoModel todo) {
    //
    // .toList() methodu yeni bir liste verir.
    // state yeniden oluşturulmuş olur.
    // state'de todo ile id'si örtüşmeyen veriler alınır, parametre todo silinmiş olur.
    state = state.where((element) => element.id != todo.id).toList();
  }

  int onCompletedTodoCount() {
    return state.where((element) => element.completed == false).length;
  }
}
