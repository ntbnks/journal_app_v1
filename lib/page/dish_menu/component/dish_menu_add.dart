import 'package:flutter/material.dart';
import 'package:journal_app_v1/model/provider.dart';
import 'package:journal_app_v1/ui/page_component/checkbox_default.dart';
import 'package:journal_app_v1/ui/page_component/edit_mode_post_and_cancel_widgets.dart';
import 'package:journal_app_v1/ui/text_headline.dart';

class EditModeDishCreateEntry extends StatelessWidget {
  const EditModeDishCreateEntry(this.provider, {super.key});
  final MainProvider provider;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 64.0, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const TextHeadline('Добавить новое блюдо'),
                  TextFormField(
                    initialValue: provider.formCreateDish.name,
                    onChanged: (value) => provider.editDishCreateEntry(
                      name: value,
                    ),
                    decoration: const InputDecoration(label: Text('Название блюда')),
                  ),
                  TextFormField(
                    initialValue: provider.formCreateDish.category,
                    onChanged: (value) => provider.editDishCreateEntry(
                      category: value,
                    ),
                    decoration: const InputDecoration(label: Text('Категория блюда')),
                  ),
                  CheckboxDefault(
                    provider.formCreateDish.active,
                    title: 'Поместить в меню на сегодня по добавлению',
                    onChanged: (value) => provider.editDishCreateEntry(active: value),
                  ),
                ],
              ),
            ),
          ),
          EditModePostAndCancelWidgets(
            provider,
            onPost: () {
              if (provider.formCreateDish.name.isEmpty ||
                  provider.formCreateDish.category.isEmpty) {
                provider.problemsList('Одно из полей не заполнено!');
              } else {
                // provider.postHealth(
                //   user: provider.formHealth.user,
                //   prof: provider.formHealth.proffesion,
                //   diagnosis: provider.formHealth.diagnos,
                // );
              }
            },
            onCancel: () => provider.toggleEdit(),
          )
        ],
      ),
    );
  }
}
