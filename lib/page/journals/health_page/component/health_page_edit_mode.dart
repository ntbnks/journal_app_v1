import 'package:flutter/material.dart';
import 'package:journal_app_v1/model/provider.dart';
import 'package:journal_app_v1/ui/page_component/checkbox_default.dart';
import 'package:journal_app_v1/ui/page_component/edit_mode_post_and_cancel_widgets.dart';
import 'package:journal_app_v1/ui/popup_menu_premade.dart';
import 'package:journal_app_v1/ui/text_headline.dart';
import 'package:journal_app_v1/ui/user_list_selectable.dart';

class HealthPageEditMode extends StatelessWidget {
  const HealthPageEditMode(this.provider, {super.key});
  final MainProvider provider;

  @override
  Widget build(BuildContext context) => Expanded(
        child: Column(
          children: [
            Form(
              child: Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 64.0, vertical: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const TextHeadline('Добавить новую запись'),
                        const SizedBox(height: 16),
                        UserListMenu(
                          provider.userList,
                          title: 'Укажите ФИО сотрудника',
                          onTap: (id) => provider.editHealthJournal(user: id),
                          userNameFrom: provider.formHealth.user,
                        ),
                        PopupMenuProfessions(
                          title: 'Профессия',
                          onTap: (entry) => provider.editHealthJournal(
                            proffesion: entry.id,
                          ),
                          entries: provider.professionList,
                          selectedValue: provider.formHealth.proffesion,
                        ),
                        const SizedBox(height: 16),
                        CheckboxDefault(
                          provider.formHealth.okz,
                          title: 'Отметка отсутствия ОКЗ у работника в семье',
                          onChanged: (value) => provider.editHealthJournal(okz: value),
                        ),
                        CheckboxDefault(
                          provider.formHealth.anginamark,
                          title:
                              'Отметка об отсутствии у работника ангины и гнойничковых заболеваний',
                          onChanged: (value) => provider.editHealthJournal(anginamark: value),
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          initialValue: provider.formHealth.diagnos,
                          onChanged: (value) => provider.editHealthJournal(
                            diagnos: value,
                          ),
                          decoration: const InputDecoration(
                            label: Text(
                              'Контроль за больничными листами по уходу за больничным (диагноз)',
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        CheckboxDefault(
                          provider.formHealth.passtowork,
                          title: 'Допуск к работе',
                          onChanged: (value) => provider.editHealthJournal(passtowork: value),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            EditModePostAndCancelWidgets(
              provider,
              onPost: () {
                if (provider.formHealth.user < 0 ||
                    provider.formHealth.proffesion < 0 ||
                    provider.formHealth.diagnos.isEmpty) {
                  provider.problemsList('Одно из полей не заполнено!');
                } else {
                  provider.postHealth(
                    user: provider.formHealth.user,
                    prof: provider.formHealth.proffesion,
                    diagnosis: provider.formHealth.diagnos,
                  );
                }
              },
              onCancel: () => provider.toggleEdit(),
            )
          ],
        ),
      );
}
