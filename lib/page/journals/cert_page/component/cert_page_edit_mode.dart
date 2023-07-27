import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:journal_app_v1/model/provider.dart';
import 'package:journal_app_v1/ui/page_component/dialog_select_one.dart';
import 'package:journal_app_v1/ui/page_component/edit_mode_post_and_cancel_widgets.dart';
import 'package:journal_app_v1/ui/popup_menu_premade.dart';
import 'package:journal_app_v1/ui/user_list_selectable.dart';

class CertPageEditMode extends StatelessWidget {
  const CertPageEditMode(this.provider, {required this.onPostSuccessful, super.key});

  final MainProvider provider;
  final VoidCallback onPostSuccessful;

  @override
  Widget build(BuildContext context) {
    return Expanded(
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
                      Text('Добавить новую запись', style: Theme.of(context).textTheme.headline5),
                      TextFormField(
                        initialValue: provider.formCert.timespend.toString(),
                        keyboardType: TextInputType.number,
                        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                        onChanged: (value) => provider.editFormCert(
                          timespend: value.isEmpty ? -1 : int.tryParse(value),
                        ),
                        decoration:
                            const InputDecoration(label: Text('Время приготовления (в минутах)')),
                      ),
                      const SizedBox(height: 24),
                      const Text('Наименование'),
                      ListTile(
                        title: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.menu_open, color: Colors.black),
                            const SizedBox(width: 16),
                            Text(
                              provider.formCert.dish < 0
                                  ? 'Открыть список блюд'
                                  : provider.dishList
                                      .firstWhere((element) => element.id == provider.formCert.dish)
                                      .name,
                            ),
                          ],
                        ),
                        onTap: () => showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            content: DialogSelectOne(
                              provider.dishList.where((element) => element.active),
                              onDone: (value) => provider.editFormCert(dish: value.id),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      PopupMenuPremade(
                        title: 'Результат',
                        onTap: (value) => provider.editFormCert(rating: value),
                        entries: const [3, 2, 1],
                        selectedValue: provider.formCert.rating,
                      ),
                      TextFormField(
                        initialValue: provider.formCert.serveTime.toString(),
                        keyboardType: TextInputType.number,
                        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                        onChanged: (value) => provider.editFormCert(
                          serveTime: value.isEmpty ? -1 : int.tryParse(value),
                        ),
                        decoration: const InputDecoration(label: Text('Часы на реализацию')),
                      ),
                      const SizedBox(height: 24),
                      UserListMenu(
                        provider.userList,
                        title: 'ФИО ответственного',
                        userNameFrom: provider.formCert.user,
                        onTap: (id) => provider.editFormCert(user: id),
                      ),
                      UserListMenu(
                        provider.userList,
                        title: 'ФИО проводившего бракераж',
                        userNameFrom: provider.formCert.userdone,
                        onTap: (id) => provider.editFormCert(userdone: id),
                      ),
                      TextFormField(
                        initialValue: provider.formCert.note,
                        onChanged: (value) => provider.editFormCert(note: value),
                        decoration: const InputDecoration(label: Text('Примечание')),
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
              if (provider.formCert.dish < 0 ||
                  provider.formCert.rating < 1 ||
                  provider.formCert.rating > 3 ||
                  provider.formCert.timespend < 1 ||
                  provider.formCert.serveTime < 1) {
                provider.problemsList('Одно из полей не заполнено!');
              } else {
                provider.postBrack(
                  name: provider.formCert.dish,
                  time: provider.formCert.timespend,
                  rating: provider.formCert.rating,
                  serveTime: provider.formCert.serveTime,
                  note: provider.formCert.note,
                  userID: provider.formCert.user,
                  supervisorID: provider.formCert.userdone,
                );
                onPostSuccessful();
              }
            },
            onCancel: () => provider.toggleEdit(),
          ),
        ],
      ),
    );
  }
}
