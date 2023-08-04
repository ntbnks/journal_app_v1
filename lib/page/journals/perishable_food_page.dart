import 'package:flutter/material.dart';
import 'package:journal_app_v1/method/username_selected.dart';
import 'package:journal_app_v1/model/provider.dart';
import 'package:journal_app_v1/page/edit_mode_generic.dart';
import 'package:journal_app_v1/ui/page_component/drawer.dart';
import 'package:journal_app_v1/ui/page_component/error_loading_page.dart';
import 'package:journal_app_v1/ui/page_component/table_default.dart';
import 'package:journal_app_v1/ui/page_component/table_main_panel.dart';
import 'package:journal_app_v1/ui/page_component/text_in_table.dart';
import 'package:journal_app_v1/ui/page_component/top_buttons_block.dart';
import 'package:provider/provider.dart';

class PerishableFoodJournalPage extends StatelessWidget {
  const PerishableFoodJournalPage({super.key});
  static const String route = 'PerishableFoodJournalPage';

  /// This page's title
  static const String title = 'Журнал скоропортящихся продуктов';

  @override
  Widget build(BuildContext context) {
    final MainProvider provider = Provider.of<MainProvider>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((t) {
      if (provider.tmprList.isEmpty && !provider.loading && !provider.pageVisit) {
        provider.pageVisitApprove();
        provider.requestPerishableFoodData();
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
                        onRefresh: () => provider.requestPerishableFoodData(),
                      ),
                    ),

                    /// CONTENT
                    ///
                    if (provider.editMode)
                      EditModeGeneric(
                        provider,
                        content: const Text('nothing yet'), // TODO
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
                                    1: FlexColumnWidth(3),
                                    2: FlexColumnWidth(2),
                                    3: FlexColumnWidth(4),
                                    4: FlexColumnWidth(4),
                                    5: FlexColumnWidth(4),
                                  },
                                  headers: const [
                                    'Дата открытие (вскрытие) продуктов, скоропортящихся продуктов',
                                    'Наименование продукта',
                                    'Дата, время изготовления',
                                    'Конечный срок реализации на упаковке',
                                    'Дата, срок реализации продуктов после вскрытия (приготовления)',
                                    'Подпись ответственного лица',
                                  ],
                                  content: [
                                    for (final e in provider.perishableFoodList)
                                      TableRow(
                                        children: [
                                          TextInTable(e.openingDate),
                                          TextInTable(e.name),
                                          TextInTable(e.manufactureDateTime),
                                          TextInTable(
                                            e.expiryDate,
                                          ),
                                          TextInTable(e.periodOfSaleDate),
                                          TextInTable(
                                            genUserFirstnameSecondnameLastname(
                                              provider.userList.firstWhere(
                                                (x) => x.id == e.userLink,
                                              ),
                                            ),
                                          ),
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
