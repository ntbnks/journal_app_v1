import 'package:flutter/material.dart';
import 'package:journal_app_v1/model/models.dart';
import 'package:journal_app_v1/ui/page_component/buttons_sized.dart';
import 'package:journal_app_v1/ui/page_component/field_widget.dart';

class DialogGetDishesWidget extends StatefulWidget {
  const DialogGetDishesWidget(this.elements, {required this.onDone, super.key});
  final Iterable<DishEntry> elements;
  final Function(List<DishEntry>) onDone;

  @override
  State<DialogGetDishesWidget> createState() => _DialogGetDishesWidgetState();
}

class _DialogGetDishesWidgetState extends State<DialogGetDishesWidget> {
  late List<DishEntry> generatedList = [];
  final List<DishEntry> searchList = [];
  @override
  void initState() {
    super.initState();
    for (final e in widget.elements) {
      generatedList.add(DishEntry(id: e.id, name: e.name, category: e.category, active: e.active));
    }
    searchList.addAll(generatedList);
  }

  final ctrl = TextEditingController();

  @override
  Widget build(BuildContext context) => AlertDialog(
        content: SizedBox(
          width: 768,
          child: Column(
            children: [
              Text(
                  widget.elements.isEmpty ? 'На найдено элементов' : widget.elements.first.category,
                  style: Theme.of(context).textTheme.headline5),
              if (widget.elements.isEmpty) ...[
                const Text('Для выбранной Вами категории нет элементов.'),
                const Expanded(child: SizedBox())
              ] else ...[
                TextField(
                  decoration: const InputDecoration(label: Text('Поиск в категории')),
                  controller: ctrl,
                  onChanged: (value) {
                    if (value.isNotEmpty) {
                      searchList.clear();
                      for (final e in generatedList) {
                        if (e.name.toLowerCase().contains(value.toLowerCase())) {
                          searchList.add(e);
                        }
                      }
                    } else {
                      searchList.clear();
                      searchList.addAll(generatedList);
                    }
                    setState(() {});
                  },
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        if (searchList.isEmpty)
                          const Text('Список пуст.')
                        else
                          for (var e in searchList)
                            Row(
                              children: [
                                Expanded(
                                  child: CheckboxListTile(
                                    controlAffinity: ListTileControlAffinity.leading,
                                    title: Text(e.name),
                                    value: e.active,
                                    onChanged: (value) {
                                      setState(() => e.active = value!);
                                    },
                                  ),
                                ),
                              ],
                            ),
                      ],
                    ),
                  ),
                ),
                const Separator(),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ButtonSized(
                      title: 'Готово',
                      width: 224,
                      height: 64,
                      scale: 1.5,
                      loading: false,
                      onPressed: () {
                        widget.onDone(generatedList);
                        Navigator.of(context).pop();
                      },
                    ),
                    const SizedBox(width: 32),
                    TextButtonSized(
                      title: 'Отменить',
                      width: 224,
                      height: 64,
                      scale: 1.5,
                      loading: false,
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ],
                ),
              ],
              if (widget.elements.isEmpty)
                TextButtonSized(
                  title: 'Отменить',
                  width: 224,
                  height: 64,
                  scale: 1.5,
                  loading: false,
                  onPressed: () => Navigator.of(context).pop(),
                ),
            ],
          ),
        ),
      );
}
