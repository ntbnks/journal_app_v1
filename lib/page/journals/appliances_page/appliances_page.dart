import 'package:flutter/material.dart';
import 'package:journal_app_v1/model/provider.dart';
import 'package:journal_app_v1/ui/page_component/drawer.dart';
import 'package:journal_app_v1/ui/page_component/edit_mode_post_and_cancel_widgets.dart';
import 'package:journal_app_v1/ui/page_component/table_default.dart';
import 'package:journal_app_v1/ui/page_component/table_main_panel.dart';
import 'package:journal_app_v1/ui/page_component/text_in_table.dart';
import 'package:journal_app_v1/ui/page_component/top_buttons_block.dart';
import 'package:journal_app_v1/ui/popup_menu_premade.dart';
import 'package:provider/provider.dart';

class AppliancesPage extends StatelessWidget {
  const AppliancesPage({super.key});
  static const String route = 'appliancePage';

  /// This page's title
  /// THIS PAGE IS AVAILABLE ONLY FOR SUPER ADMIN
  static const String title = 'Список оборудования';

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Consumer<MainProvider>(
          builder: (context, provider, _) => Row(
            children: [
              MainDrawer(provider),
              Expanded(
                child: Column(
                  children: [
                    /// Header and controls
                    TableMainPanel(
                      title: title,
                      controls: TopButtonsBlock(
                        onAdd: () => provider.toggleEdit(),
                        onRefresh: () => provider.requestDishList(),
                      ),
                    ),

                    /// CONTENT
                    ///
                    if (provider.editMode)
                      Expanded(
                        child: Column(
                          children: [
                            Expanded(
                              child: SingleChildScrollView(
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 64.0, vertical: 16),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      TextFormField(
                                        initialValue: 'provider.formCert.note',
                                        onChanged: (value) {},
                                        decoration:
                                            const InputDecoration(label: Text('Имя устройства')),
                                      ),
                                      const SizedBox(height: 16),
                                      PopupMenuPremade(
                                        title: 'Помещение',
                                        onTap: (value) {},
                                        entries: const [3, 2, 1],
                                        selectedValue: 1,
                                      ),
                                      PopupMenuPremade(
                                        title: 'Цех',
                                        onTap: (value) {},
                                        entries: const [3, 2, 1],
                                        selectedValue: 1,
                                      ),
                                      TextFormField(
                                        initialValue: 'Температура',
                                        onChanged: (value) {},
                                        decoration:
                                            const InputDecoration(label: Text('Норма измерения')),
                                      ),
                                      TextFormField(
                                        initialValue: '25',
                                        onChanged: (value) {},
                                        decoration: const InputDecoration(
                                            label: Text('Минимальное значение')),
                                      ),
                                      TextFormField(
                                        initialValue: '50',
                                        onChanged: (value) {},
                                        decoration: const InputDecoration(
                                          label: Text('Максимальное значение'),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            EditModePostAndCancelWidgets(provider, onPost: () {})
                          ],
                        ),
                      )
                    else
                      TableDefault(
                        headers: const [
                          'Имя',
                          'Наименование помещения',
                          'Измерение',
                          'Минимальная точка',
                          'Максимальная точка'
                        ],
                        content: [
                          for (final e in provider.applianceList)
                            TableRow(
                              children: [
                                TextInTable(e.name),
                                const TextInTable(
                                    "ул. Либерти 255, Плейсхолдер склад, горячий цех"),
                                TextInTable(e.normalPoint),
                                TextInTable(e.startNormalPoint.toString()),
                                TextInTable(e.endNormalPoint.toString()),
                              ],
                            )
                        ],
                      )
                  ],
                ),
              )
            ],
          ),
        ),
      );
}
