import 'package:flutter/material.dart';
import 'package:journal_app_v1/model/messages.dart';
import 'package:journal_app_v1/model/provider.dart';
import 'package:journal_app_v1/page/edit_mode_generic.dart';
import 'package:journal_app_v1/page/journals/temperature_page/component/tmpr_page_edit_mode.dart';
import 'package:journal_app_v1/ui/page_component/drawer.dart';
import 'package:journal_app_v1/ui/page_component/error_loading_page.dart';
import 'package:journal_app_v1/ui/page_component/table_default.dart';
import 'package:journal_app_v1/ui/page_component/table_main_panel.dart';
import 'package:journal_app_v1/ui/page_component/text_in_table.dart';
import 'package:journal_app_v1/ui/page_component/top_buttons_block.dart';
import 'package:provider/provider.dart';

class PageTemperature extends StatelessWidget {
  PageTemperature({super.key});
  static const String route = 'tmprPage';

  /// This page's title
  static const String title = 'Журнал контроль температуры и влажности помещений';

  final ctrlWarehouse = TextEditingController();
  final ctrlMoisture = TextEditingController();
  final ctrlTmpr = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final MainProvider provider = Provider.of<MainProvider>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((t) {
      if (provider.tmprList.isEmpty && !provider.loading && !provider.pageVisit) {
        provider.pageVisitApprove();
        provider.requestTmprList();
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
                      onRefresh: () => provider.requestTmprList(),
                    ),
                  ),

                  /// CONTENT
                  ///
                  if (provider.editMode)
                    EditModeGeneric(
                      provider,
                      content: TmprPageEditModeContent(provider),
                      onPost: provider.postTmpr,
                    )
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
                                  1: FlexColumnWidth(8),
                                  2: FlexColumnWidth(2),
                                  3: FlexColumnWidth(2),
                                  4: FlexColumnWidth(2),
                                  5: FlexColumnWidth(2),
                                  6: FlexColumnWidth(4),
                                },
                                headers: const [
                                  '№ п/п',
                                  'Наименование складского помещения',
                                  'Дата',
                                  'Время',
                                  'Температура',
                                  'Влажность F%',
                                  'Подпись Ф.И.О.',
                                ],
                                content: [
                                  for (final e in provider.tmprList)
                                    TableRow(
                                      children: [
                                        TextInTable(e.id.toString()),
                                        TextInTable('${e.appliance}, ${e.warehouse}'),
                                        TextInTable(Messages().getDateTimeFromList(e.date)),
                                        TextInTable(
                                          Messages().getDateTimeFromList(e.time, separator: ':'),
                                        ),
                                        TextInTable('${e.temperature}C'),
                                        TextInTable('${e.vlazhn}C'),
                                        TextInTable(Messages().genBoolString(e.sign)),
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
