import 'package:flutter/material.dart';
import 'package:journal_app_v1/method/username_selected.dart';
import 'package:journal_app_v1/model/messages.dart';
import 'package:journal_app_v1/model/provider.dart';
import 'package:journal_app_v1/ui/page_component/drawer.dart';
import 'package:journal_app_v1/ui/page_component/table_default.dart';
import 'package:journal_app_v1/ui/page_component/table_main_panel.dart';
import 'package:journal_app_v1/ui/page_component/text_in_table.dart';
import 'package:journal_app_v1/ui/page_component/top_buttons_block.dart';
import 'package:journal_app_v1/ui/widget_with_loading.dart';
import 'package:provider/provider.dart';

class UsersPage extends StatelessWidget {
  const UsersPage({super.key});
  static const String route = 'usersPage';

  /// This page's title
  static const String title = 'Пользователи и пароли';

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
                        onRefresh: () => provider.requestUserList(),
                      ),
                    ),

                    WidgetWithLoading(
                      provider: provider,
                      widget: TableDefault(
                        columnWidths: const {
                          1: FlexColumnWidth(8),
                          2: FlexColumnWidth(2),
                          3: FlexColumnWidth(2),
                          4: FlexColumnWidth(4),
                          // 5: FlexColumnWidth(4),
                        },
                        headers: const [
                          'id',
                          'ФИО',
                          'Роль',
                          'Ограничен',
                          // 'Удален',
                          'Запрос на восстановление пароля',
                        ],
                        content: [
                          for (final e in provider.userList)
                            TableRow(
                              children: [
                                TextInTable(e.id.toString()),
                                TextInTable(genUserFirstnameSecondnameLastname(e)),
                                TextInTable(e.role),
                                TextInTable(Messages().genBoolString(e.banned)),
                                // TextInTable(Messages().genBoolString(e.deleted)),
                                UnconstrainedBox(
                                  child: SizedBox(
                                    width: 60,
                                    height: 24,
                                    child:
                                        ElevatedButton(onPressed: () {}, child: const Text('Ok')),
                                  ),
                                )
                              ],
                            )
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      );
}
