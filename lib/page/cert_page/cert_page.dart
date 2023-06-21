import 'package:flutter/material.dart';
import 'package:journal_app_v1/method/username_selected.dart';
import 'package:journal_app_v1/model/messages.dart';
import 'package:journal_app_v1/model/models.dart';
import 'package:journal_app_v1/model/provider.dart';
import 'package:journal_app_v1/page/cert_page/component/cert_page_edit_mode.dart';
import 'package:journal_app_v1/ui/page_component/drawer.dart';
import 'package:journal_app_v1/ui/page_component/error_loading_page.dart';
import 'package:journal_app_v1/ui/page_component/table_default.dart';
import 'package:journal_app_v1/ui/page_component/table_main_panel.dart';
import 'package:journal_app_v1/ui/page_component/text_in_table.dart';
import 'package:journal_app_v1/ui/page_component/top_buttons_block.dart';
import 'package:provider/provider.dart';

class PageFoodCertification extends StatefulWidget {
  const PageFoodCertification({super.key});
  static const String route = 'certPage';

  /// This page's title
  static const String title = 'Бракеражный журнал';

  @override
  State<PageFoodCertification> createState() => _PageFoodCertificationState();
}

class _PageFoodCertificationState extends State<PageFoodCertification> {
  List<JournalFoodCert> sortedList = [];
  @override
  void initState() {
    super.initState();
    final MainProvider provider = Provider.of<MainProvider>(context, listen: false);

    if (provider.certList.isNotEmpty) {
      fillList(provider.certList);
    }

    WidgetsBinding.instance.addPostFrameCallback((t) {
      if (provider.certList.isEmpty && !provider.loading && !provider.pageVisit) {
        provider.pageVisitApprove();
        provider.requestCertList().then((value) {
          for (final e in value!) {
            sortedList.add(
              JournalFoodCert(
                date: e.date,
                dish: e.dish,
                timespend: e.timespend,
                rating: e.rating,
                serveTime: e.serveTime,
                user: e.user,
                userdone: e.userdone,
                note: e.note,
              ),
            );
          }
        });
      }
    });
  }

  void fillList(List<JournalFoodCert> list) {
    sortedList.clear();
    for (final e in list) {
      sortedList.add(
        JournalFoodCert(
          date: e.date,
          dish: e.dish,
          timespend: e.timespend,
          rating: e.rating,
          serveTime: e.serveTime,
          user: e.user,
          userdone: e.userdone,
          note: e.note,
        ),
      );
    }
  }

  void sortList(String field) {
    sortedList.sort((a, b) {
      switch (field) {
        case 'Наименование':
          return a.dish;
        case 'Часы':
          return a.serveTime;
        case 'Ответственный':
          return a.user.compareTo(b.user);
        case 'Время приготовления':
          return a.timespend;
        case 'Результат':
          return a.rating;
        default:
          return a.serveTime.compareTo(b.serveTime);
      }
    });
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<MainProvider>(
        builder: (context, provider, _) => Row(
          children: [
            /// Panel on the left
            MainDrawer(provider),
            Expanded(
              child: Column(
                children: [
                  /// Header and controls
                  TableMainPanel(
                    title: PageFoodCertification.title,
                    controls: TopButtonsBlock(
                      onAdd: () => provider.toggleEdit(),
                      onRefresh: () =>
                          provider.requestCertList().then((value) => fillList(provider.certList)),
                      onDelete: () => provider.clearList(provider.certList),
                    ),
                  ),

                  /// CONTENT
                  ///
                  if (provider.editMode)
                    CertPageEditMode(
                      provider,
                      onPostSuccessful: () => fillList(provider.certList),
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
                                  2: FlexColumnWidth(3),
                                  5: FlexColumnWidth(3),
                                  6: FlexColumnWidth(3),
                                },
                                headers: const [
                                  'Дата',
                                  'Время приготовления',
                                  'Наименование',
                                  'Результат',
                                  'Часы',
                                  'Ответственный',
                                  'ФИО проводившего бракераж',
                                  'Примечание',
                                ],
                                onPressHeader: (header) => sortList(header),
                                content: [
                                  for (final e in provider.certList)
                                    TableRow(
                                      children: [
                                        TextInTable(Messages().getDateTimeFromList(e.date)),
                                        TextInTable(Messages().calculateTimeSpent(e.timespend)),
                                        TextInTable(
                                          provider.dishList
                                              .firstWhere((element) => element.id == e.dish)
                                              .name,
                                        ),
                                        TextInTable(
                                          Messages().genRatingFromInt(e.rating, shortened: true),
                                        ),
                                        TextInTable(e.serveTime.toString()),
                                        TextInTable(genUserNameSelected(provider.userList, e.user)),
                                        TextInTable(
                                          genUserNameSelected(provider.userList, e.userdone),
                                        ),
                                        TextInTable(e.note),
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
