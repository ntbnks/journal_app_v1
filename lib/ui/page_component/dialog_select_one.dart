import 'package:flutter/material.dart';
import 'package:journal_app_v1/model/models.dart';
import 'package:journal_app_v1/page/todays_menu_page/todays_menu_page.dart';
import 'package:journal_app_v1/ui/page_component/field_widget.dart';
import 'package:journal_app_v1/ui/page_component/topbar_button.dart';
import 'package:journal_app_v1/ui/palette.dart';

class DialogSelectOne extends StatefulWidget {
  const DialogSelectOne(this.elements, {required this.onDone, super.key});
  final Iterable<DishEntry> elements;
  final Function(DishEntry) onDone;

  @override
  State<DialogSelectOne> createState() => _DialogSelectOneState();
}

class _DialogSelectOneState extends State<DialogSelectOne> {
  late List<DishEntry> generatedList = [];
  final List<DishEntry> searchList = [];
  final ctrl = TextEditingController();
  String message = '';

  @override
  void initState() {
    super.initState();
    for (final e in widget.elements) {
      generatedList.add(DishEntry(id: e.id, name: e.name, category: e.category, active: e.active));
    }

    /// if generatedList is empty don't add to searchList and inform user.
    if (generatedList.isEmpty) {
      message = 'В списке меню на сегодня нет ни одного блюда.';
    } else {
      searchList.addAll(generatedList);
    }
  }

  /// Disable search if generatedList is empty.
  bool get inactive => generatedList.isEmpty;

  String selectedCategory = '';

  @override
  Widget build(BuildContext context) => SizedBox(
        width: 768,
        child: Column(
          children: [
            Text('Выберите наименование блюда', style: Theme.of(context).textTheme.headline5),
            const SizedBox(height: 16),
            IgnorePointer(
              ignoring: inactive,
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: const InputDecoration(label: Text('Поиск в списке')),
                      controller: ctrl,
                      onChanged: (_) => _searchCall(),
                    ),
                  ),
                  PopupMenuButton(
                    tooltip: '',
                    child: SizedBox(
                      width: 224,
                      height: 56,
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(selectedCategory.isEmpty ? 'Все категории' : selectedCategory),
                            const SizedBox(width: 12),
                            const Icon(Icons.expand_circle_down_outlined),
                          ],
                        ),
                      ),
                    ),
                    itemBuilder: (context) {
                      final categories = ['Гарниры', 'Напитки', 'Выпечка', 'Салаты'];
                      final List<PopupMenuItem> menuList = [];
                      menuList.add(
                        PopupMenuItem(
                          onTap: () {
                            selectedCategory = '';
                            _searchCall();
                          },
                          child: const Text('Все'),
                        ),
                      );
                      for (final e in categories) {
                        menuList.add(
                          PopupMenuItem(
                            onTap: () {
                              selectedCategory = e;
                              _searchCall();
                            },
                            child: Text(e),
                          ),
                        );
                      }

                      return menuList;
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: SingleChildScrollView(
                child: Material(
                  color: Colors.transparent,
                  child: Column(
                    children: [
                      if (message.isNotEmpty) Text(message, textAlign: TextAlign.center),
                      if (generatedList.isEmpty)
                        GestureDetector(
                          onTap: () => Navigator.of(context)
                              .pushNamedAndRemoveUntil(TodaysMenuPage.route, (route) => false),
                          child: const MouseRegion(
                            cursor: SystemMouseCursors.click,
                            child: Text(
                              'Добавьте блюда в список',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Pal.defaultGreen,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        )
                      else
                        for (var e in searchList)
                          Row(
                            children: [
                              Expanded(
                                child: ListTile(
                                  title: Text(e.name),
                                  onTap: () {
                                    widget.onDone(e);
                                    Navigator.of(context).pop();
                                  },
                                  subtitle: Text(e.category),
                                ),
                              ),
                            ],
                          ),
                    ],
                  ),
                ),
              ),
            ),
            const Separator(color: Pal.defaultGreenHighlight),
            const SizedBox(height: 16),
            SizedBox(
              width: 64,
              height: 64,
              child: TopBarButton(
                tooltip: 'Закрыть',
                onPressed: () => Navigator.of(context).pop(),
                icon: Icons.close,
              ),
            )
          ],
        ),
      );

  void _searchCall() {
    if (ctrl.text.isEmpty && selectedCategory.isEmpty) {
      searchList.clear();
      searchList.addAll(generatedList);
    } else {
      searchList.clear();

      for (final e in generatedList) {
        if (e.name.toLowerCase().contains(ctrl.text.toLowerCase()) &&
            (selectedCategory.isEmpty || e.category == selectedCategory)) {
          searchList.add(e);
        }
      }
    }
    if (searchList.isEmpty) {
      message = 'На найдено ни одного блюда.';
    } else {
      message = '';
    }

    setState(() {});
  }
}
