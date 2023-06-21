import 'package:flutter/material.dart';
import 'package:journal_app_v1/method/username_selected.dart';
import 'package:journal_app_v1/model/messages.dart';
import 'package:journal_app_v1/model/provider.dart';
import 'package:journal_app_v1/page/health_page/component/health_page_edit_mode.dart';
import 'package:journal_app_v1/ui/page_component/drawer.dart';
import 'package:journal_app_v1/ui/page_component/error_loading_page.dart';
import 'package:journal_app_v1/ui/page_component/table_default.dart';
import 'package:journal_app_v1/ui/page_component/table_main_panel.dart';
import 'package:journal_app_v1/ui/page_component/text_in_table.dart';
import 'package:journal_app_v1/ui/page_component/top_buttons_block.dart';
import 'package:provider/provider.dart';

class PageHealth extends StatelessWidget {
  PageHealth({super.key});
  static const String route = 'healthPage';

  /// This page's title
  static const String title = 'Журнал здоровья';

  final ctrlUserName = TextEditingController();
  final ctrlProf = TextEditingController();
  final ctrlDiagnosis = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final MainProvider provider = Provider.of<MainProvider>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((t) {
      if (provider.healthList.isEmpty && !provider.loading && !provider.pageVisit) {
        provider.pageVisitApprove();
        provider.requestHealthList();
      }
    });
    return Scaffold(
      body: Consumer<MainProvider>(
        builder: (context, provider, _) => Row(
          children: [
            /// Panel on the left
            MainDrawer(provider),
            Expanded(
              child: Column(
                children: [
                  TableMainPanel(
                    title: title,
                    controls: TopButtonsBlock(
                      onAdd: () => provider.toggleEdit(),
                      onRefresh: () => provider.requestHealthList(),
                    ),
                  ),

                  /// CONTENT
                  ///
                  if (provider.editMode)
                    HealthPageEditMode(provider)
                  else
                    provider.errorMessage.isNotEmpty
                        ? ErrorLoadingPageWidget(
                            provider.errorMessage,
                            loading: provider.loading,
                          )
                        : provider.loading
                            ? const Expanded(child: Center(child: CircularProgressIndicator()))
                            : TableDefault(
                                columnWidths: const {
                                  1: FlexColumnWidth(2),
                                  2: FlexColumnWidth(3),
                                  3: FlexColumnWidth(3),
                                  4: FlexColumnWidth(2),
                                  5: FlexColumnWidth(2),
                                  6: FlexColumnWidth(3),
                                  7: FlexColumnWidth(2),
                                  8: FlexColumnWidth(3),
                                  9: FlexColumnWidth(2),
                                },
                                headers: const [
                                  '№ п/п',
                                  'Дата',
                                  'ФИО',
                                  'Профессия',
                                  'Отметка отсутствия ОКЗ у работника в семье',
                                  'Отметка об отсутствии у работника  ангины и гнойничковых заболеваний',
                                  'Контроль за больничными листами по уходу за больничным (диагноз)',
                                  'Допуск к работе',
                                  'Подпись ответственного лица',
                                  'Подпись работника',
                                ],
                                content: [
                                  for (final e in provider.healthList)
                                    TableRow(
                                      children: [
                                        TextInTable(e.id.toString()),
                                        TextInTable(Messages().getDateTimeFromList(e.date)),
                                        TextInTable(genUserNameSelected(provider.userList, e.user)),
                                        TextInTable(
                                          provider.professionList
                                              .firstWhere((element) => element.id == e.proffesion)
                                              .name,
                                        ),
                                        TextInTable(Messages().genBoolString(e.okz)),
                                        TextInTable(Messages().genBoolString(e.anginamark)),
                                        TextInTable(e.diagnos),
                                        TextInTable(Messages().genBoolString(e.passtowork)),
                                        TextInTable(
                                          Messages().genUserName(provider.userList[0]),
                                        ), //incorrect
                                        TextInTable(Messages().genBoolString(e.signWorker)),
                                      ],
                                    )
                                ],
                              ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
