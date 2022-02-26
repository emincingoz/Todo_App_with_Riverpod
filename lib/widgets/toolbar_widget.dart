import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/providers/all_providers.dart';

class ToolBarWidget extends ConsumerWidget {
  const ToolBarWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //
    // ref.watch(todoListProvider.notifier).onCompletedTodoCount() methodunda değişiklik algılanamadığı için oluşturuldu
    /*int onCompletedTodoCount = ref
        .watch(todoListProvider)
        .where((element) => element.completed == false)
        .length;*/
    final onCompletedTodoCount = ref.watch(unCompletedTodoCount);

    return Row(
      //
      // children içerisinde kullanılacak olan widgetlara alanı eşit şekilde bölüştürür.
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          // todoListProvider ile listenin eleman sayısı alındı
          child: Text(
            // Alttaki gibi texte verildiğinde aslında providerın notifierine yani TodoListManager'a ulaşıldığı için
            // gerçekleşen değişiklik algılanamaz.
            // Bu yüzden .onCompletedCount() methodunda yapılan işlem burada benzer şekilde yapılıp Text widgetına verilir.
            //ref.watch(todoListProvider.notifier).onCompletedTodoCount().toString()
            onCompletedTodoCount.toString() + ' görev tamamlanmadı',
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Tooltip(
          message: 'Only Uncompleted Todos',
          child: TextButton(onPressed: () {}, child: const Text('Active')),
        ),
        Tooltip(
          message: 'Only Completed Todos',
          child: TextButton(onPressed: () {}, child: const Text('Completed')),
        ),
      ],
    );
  }
}
