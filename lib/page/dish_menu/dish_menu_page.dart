import 'package:flutter/material.dart';
import 'package:journal_app_v1/model/messages.dart';
import 'package:journal_app_v1/model/provider.dart';
import 'package:journal_app_v1/page/dish_menu/component/dish_menu_add.dart';
import 'package:journal_app_v1/ui/page_component/drawer.dart';
import 'package:journal_app_v1/ui/page_component/error_loading_page.dart';
import 'package:journal_app_v1/ui/page_component/table_default.dart';
import 'package:journal_app_v1/ui/page_component/table_main_panel.dart';
import 'package:journal_app_v1/ui/page_component/text_in_table.dart';
import 'package:journal_app_v1/ui/page_component/top_buttons_block.dart';
import 'package:journal_app_v1/ui/widget_with_loading.dart';
import 'package:provider/provider.dart';

class DishMenuPage extends StatelessWidget {
  const DishMenuPage({super.key});
  static const String route = 'dishMenu';

  /// This page's title
  static const String title = 'Редактирование меню';

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
                      EditModeDishCreateEntry(provider)
                    else
                      provider.errorMessage.isNotEmpty
                          ? ErrorLoadingPageWidget(
                              provider.errorMessage,
                              loading: provider.loading,
                            )
                          : WidgetWithLoading(
                              provider: provider,
                              widget: TableDefault(
                                columnWidths: const {
                                  1: FlexColumnWidth(12),
                                  2: FlexColumnWidth(3),
                                  3: FlexColumnWidth(3),
                                },
                                headers: [
                                  'id',
                                  'Название блюда',
                                  'Категория',
                                  Row(
                                    children: [
                                      const SizedBox(width: 72),
                                      const Expanded(child: TextInTable('В меню')),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 24,
                                          vertical: 8.0,
                                        ),
                                        child: PopupMenuButton(
                                          tooltip: '',
                                          itemBuilder: (context) => [
                                            PopupMenuItem(
                                              onTap: () => provider.editDishActiveChangeAll(true),
                                              child: const Text('Выбрать все'),
                                            ),
                                            PopupMenuItem(
                                              onTap: () => provider.editDishActiveChangeAll(false),
                                              child: const Text('Отменить все'),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                                content: [
                                  /// using this will point to the element in dishList, eliminating the need for dishList.firstWhere
                                  for (int i = 0; i < provider.dishList.length; i++)
                                    TableRow(
                                      children: [
                                        TextInTable(provider.dishList[i].id.toString()),
                                        TextInTable(provider.dishList[i].name),
                                        TextInTable(provider.dishList[i].category),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: CheckboxListTile(
                                                controlAffinity: ListTileControlAffinity.leading,
                                                title: Text(
                                                  Messages()
                                                      .genBoolString(provider.dishList[i].active),
                                                ),
                                                value: provider.dishList[i].active,
                                                onChanged: (value) => provider.editDishActive(
                                                  provider.dishList[i],
                                                  value!,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    )
                                ],
                              ),
                            ),
                  ],
                ),
              )
            ],
          ),
        ),
      );
}
