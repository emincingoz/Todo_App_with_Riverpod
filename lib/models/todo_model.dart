import 'package:hive/hive.dart';
part 'todo_model.g.dart';

@HiveType(typeId: 0)
class TodoModel {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String description;
  @HiveField(2)
  bool completed;

  TodoModel({
    required this.id,
    required this.description,
    // required olduğunda default atama yapılamıyor.
    this.completed = false,
  });
}

enum TodoListFilter { all, active, completed }
