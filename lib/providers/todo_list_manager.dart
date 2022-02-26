import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:todo_app/models/todo_model.dart';
import 'package:uuid/uuid.dart';

class TodoListManager extends StateNotifier<List<TodoModel>> {
  TodoListManager([List<TodoModel>? initialTodos]) : super(initialTodos ?? []);

  void addTodo(String description) async {
    await Hive.openBox<TodoModel>('todos');
    var box = Hive.box<TodoModel>('todos');
    box.add(TodoModel(id: const Uuid().v4(), description: description));

    box.close();
    //
    // yeni bir state oluşturur.
    //önce var olan liste içerisindeki elemanları yeni listeye ekle sonra yeni TodoModeli listenin sonuna ekle
    state = [
      ...state,
      TodoModel(id: const Uuid().v4(), description: description)
    ];
  }

  void toogle(String id) async {
    await Hive.openBox<TodoModel>('todos');
    var box = Hive.box<TodoModel>('todos');

    box.keys.forEach((element) {
      var todoId = box.values.elementAt(element).id;
      var desc = box.values.elementAt(element).description;
      var comp = !box.values.elementAt(element).completed;

      if (todoId == id) {
        box.put(
            element, TodoModel(id: todoId, description: desc, completed: comp));
      }
    });

    box.close();
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

  void edit({required String id, required String newDescription}) async {
    await Hive.openBox<TodoModel>('todos');
    var box = Hive.box<TodoModel>('todos');

    box.keys.forEach((element) {
      var todoId = box.values.elementAt(element).id;
      var comp = box.values.elementAt(element).completed;

      if (todoId == id) {
        box.put(element,
            TodoModel(id: id, description: newDescription, completed: comp));
      }
    });

    box.close();

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

  void remove(TodoModel todo) async {
    await Hive.openBox<TodoModel>('todos');
    var box = Hive.box<TodoModel>('todos');

    List<TodoModel> todos = [];

    box.values.forEach((element) {
      var todoId = element.id;
      var desc = element.description;
      var comp = element.completed;

      if (todoId != todo.id) {
        todos.add(TodoModel(id: todoId, description: desc, completed: comp));
      }
    });

    await box.clear();
    await box.addAll(todos);

    box.close();
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
