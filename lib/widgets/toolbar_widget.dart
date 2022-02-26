import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/constants/app_colors.dart';
import 'package:todo_app/models/todo_model.dart';
import 'package:todo_app/providers/all_providers.dart';

class ToolBarWidget extends ConsumerWidget {
  ToolBarWidget({Key? key}) : super(key: key);

  var _currentFilter = TodoListFilter.all;
  Color changeTextColor(TodoListFilter filt) {
    return _currentFilter == filt ? AppColors.textColor : Colors.black;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //
    // ref.watch(todoListProvider.notifier).onCompletedTodoCount() methodunda değişiklik algılanamadığı için oluşturuldu
    /*int onCompletedTodoCount = ref
        .watch(todoListProvider)
        .where((element) => element.completed == false)
        .length;*/
    final onCompletedTodoCount = ref.watch(unCompletedTodoCount);
    _currentFilter = ref.watch(todoListFilter);

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
            onCompletedTodoCount == 0
                ? 'toolbar_no_todo'.tr()
                : onCompletedTodoCount.toString() +
                    'toolbar_remaining_todos'.tr(),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Tooltip(
          message: 'All Todos',
          child: TextButton(
              style: TextButton.styleFrom(
                  primary: changeTextColor(TodoListFilter.all)),
              onPressed: () {
                ref.read(todoListFilter.notifier).state = TodoListFilter.all;
              },
              child: const Text('toolbar_all_todos').tr()),
        ),
        Tooltip(
          message: 'Only Uncompleted Todos',
          child: TextButton(
              style: TextButton.styleFrom(
                  primary: changeTextColor(TodoListFilter.active)),
              onPressed: () {
                ref.read(todoListFilter.notifier).state = TodoListFilter.active;
              },
              child: const Text('toolbar_active_todos').tr()),
        ),
        Tooltip(
          message: 'Only Completed Todos',
          child: TextButton(
              style: TextButton.styleFrom(
                  primary: changeTextColor(TodoListFilter.completed)),
              onPressed: () {
                ref.read(todoListFilter.notifier).state =
                    TodoListFilter.completed;
              },
              child: const Text('toolbar_completed_todos').tr()),
        ),
      ],
    );
  }
}
