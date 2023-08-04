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

class MedExaminationJournalPage extends StatelessWidget {
  const MedExaminationJournalPage({super.key});
  static const String route = 'MedExaminationJournalPage';

  /// This page's title
  static const String title = 'Журнал выдачи направлений на медицинский осмотр';

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
                                    1: FlexColumnWidth(4),
                                    2: FlexColumnWidth(2),
                                    3: FlexColumnWidth(2),
                                    4: FlexColumnWidth(2),
                                  },
                                  headers: const [
                                    '№ п/п',
                                    'Ф.И.О.',
                                    'Дата выдачи направления',
                                    'Подпись ответственного лица Ф.И.О',
                                    'Подпись сотрудника',
                                  ],
                                  content: [
                                    for (final e in provider.medExamList)
                                      TableRow(
                                        children: [
                                          TextInTable(e.id.toString()),
                                          TextInTable(
                                            genUserFirstnameSecondnameLastname(
                                              provider.userList.firstWhere(
                                                (x) => x.id == e.userId,
                                              ),
                                            ),
                                          ),
                                          TextInTable(e.referralDate),
                                          TextInTable(
                                            genUserFirstnameSecondnameLastname(
                                              provider.userList.firstWhere(
                                                (x) => x.id == e.userId,
                                              ),
                                            ),
                                          ),
                                          TextInTable(
                                            genUserFirstnameSecondnameLastname(
                                              provider.userList.firstWhere(
                                                (x) => x.id == e.doneById,
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
