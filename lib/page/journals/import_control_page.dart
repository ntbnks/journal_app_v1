import 'package:flutter/material.dart';
import 'package:journal_app_v1/model/messages.dart';
import 'package:journal_app_v1/model/provider.dart';
import 'package:journal_app_v1/page/edit_mode_generic.dart';
import 'package:journal_app_v1/ui/page_component/drawer.dart';
import 'package:journal_app_v1/ui/page_component/error_loading_page.dart';
import 'package:journal_app_v1/ui/page_component/table_default.dart';
import 'package:journal_app_v1/ui/page_component/table_main_panel.dart';
import 'package:journal_app_v1/ui/page_component/text_in_table.dart';
import 'package:journal_app_v1/ui/page_component/top_buttons_block.dart';
import 'package:provider/provider.dart';

class ImportControlJournalPage extends StatelessWidget {
  const ImportControlJournalPage({super.key});
  static const String route = 'importControlPage';

  /// This page's title
  static const String title = 'Журнал входного контроля пищевых продуктов';

  @override
  Widget build(BuildContext context) {
    final MainProvider provider = Provider.of<MainProvider>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((t) {
      if (provider.tmprList.isEmpty && !provider.loading && !provider.pageVisit) {
        provider.pageVisitApprove();
        provider.requestImportControlData();
      }
    });
    return Scaffold(
      body: Consumer<MainProvider>(
        builder: (context, provider, _) {
          return Row(
            children: [
              MainDrawer(provider),
              Expanded(
                child: Column(
                  children: [
                    TableMainPanel(
                      title: title,
                      controls: TopButtonsBlock(
                        onAdd: () => provider.toggleEdit(),
                        onRefresh: () => provider.requestImportControlData(),
                      ),
                    ),

                    /// CONTENT
                    ///
                    if (provider.editMode)
                      EditModeGeneric(
                        provider,
                        content: const Text('nothing yet'),
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
                                    0: FlexColumnWidth(2),
                                    1: FlexColumnWidth(2),
                                    2: FlexColumnWidth(2),
                                    3: FlexColumnWidth(2),
                                    4: FlexColumnWidth(2),
                                    5: FlexColumnWidth(2),
                                    6: FlexColumnWidth(2),
                                    7: FlexColumnWidth(2),
                                  },
                                  headers: const [
                                    'Дата и время поступления товара, продукции',
                                    'Наименование продукта с указанием изготовителя, поставщика, No партии и других реквизитов',
                                    'Условия транспортировки',
                                    'Соответствие упаковки, маркировки, гигиенические требования, наличие и правильность оформления товарно-сопроводительной документации',
                                    'Результат органолептической оценки доброкачественности',
                                    'Конечный срок реализации продовольственного сырья и пищевых продуктов',
                                    'Дата и час фактической реализации продовольственного сырья и пищевых продуктов по дням',
                                    'Примечание',
                                  ],
                                  content: [
                                    for (final e in provider.importControlList)
                                      TableRow(
                                        children: [
                                          TextInTable(e.supplyOfFoodDate),
                                          TextInTable(
                                            '${e.nameOfProduct}, ${e.manufactureOfProduct}, ${e.supplierOfProduct}, ${e.numberOfBatch}',
                                          ),
                                          TextInTable(e.transportConditions),
                                          TextInTable(
                                            Messages().genBoolString(e.complianceOfRequirements),
                                          ),
                                          TextInTable(e.resultOfOrganolepticAssessment),
                                          TextInTable(e.expiryDate),
                                          TextInTable(e.actualSaleDate),
                                          TextInTable(e.note),
                                        ],
                                      )
                                  ],
                                ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
