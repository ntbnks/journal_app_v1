import 'package:flutter/material.dart';
import 'package:journal_app_v1/model/lists.dart';
import 'package:journal_app_v1/model/provider.dart';
import 'package:journal_app_v1/page/role_selection.dart';
import 'package:journal_app_v1/ui/page_component/field_widget.dart';
import 'package:journal_app_v1/ui/page_component/user_ui_card.dart';
import 'package:journal_app_v1/ui/palette.dart';
import 'package:journal_app_v1/ui/values.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer(this.provider, {super.key});
  final MainProvider provider;
  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
      alignment: Alignment.centerLeft,
      duration: const Duration(milliseconds: Val.drawerAnimDuration),
      child: SizedBox(
        width: provider.currentDrawerSize,
        height: double.infinity,
        child: Column(
          children: [
            Container(
              height: Val.topPanelHeight,
              color: Pal.lightGreen,
              child: UserUICard(provider),
            ),

            /// List of jounals and forms
            Expanded(
              child: ColoredBox(
                color: Pal.defaultGreen,
                child: Column(
                  children: [
                    if (!provider.drawerOpen)
                      Container() // keeps green bar active when drawer is collapsed
                    else ...[
                      /// Journal LIST
                      DrawerList(
                        provider: provider,
                        title: 'Журналы',
                        list: journals,
                        onTogglePanelVariable: provider.drawerMainListOpen,
                        onTapEntry: (e) => switchPage(context, provider, e.link),
                        onTogglePanel: (value) => provider.toogleDrawerLists(
                          mainListOpen: provider.drawerMainListOpen = value,
                        ),
                      ),

                      /// Forms LIST
                      DrawerList(
                        provider: provider,
                        title: 'Управление',
                        list: toolsList,
                        onTogglePanelVariable: provider.drawerFormsListOpen,
                        onTapEntry: (e) => switchPage(context, provider, e.link),
                        onTogglePanel: (value) => provider.toogleDrawerLists(
                          formsListOpen: provider.drawerFormsListOpen = value,
                        ),
                      )
                    ]
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class DrawerList extends StatelessWidget {
  const DrawerList({
    super.key,
    required this.provider,
    required this.title,
    required this.list,
    required this.onTogglePanel,
    required this.onTogglePanelVariable,
    required this.onTapEntry,
  });

  final String title;
  final List<Journals> list;
  final Function(bool) onTogglePanel;
  final bool onTogglePanelVariable;
  final Function(Journals) onTapEntry;
  final MainProvider provider;

  @override
  Widget build(BuildContext context) {
    hideJournalForRole(GlobalRoleUiName);
    return Material(
      color: Colors.transparent,
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          onExpansionChanged: (value) => onTogglePanel(value),
          initiallyExpanded: onTogglePanelVariable,
          title: Text(title),
          textColor: Colors.white70,
          iconColor: Colors.white70,
          collapsedIconColor: Colors.white,
          collapsedTextColor: Colors.white,
          children: [
            for (final e in list)
              Column(
                children: [
                  ListTile(
                    onTap: provider.loading ? null : () => onTapEntry(e),
                    title: Text(e.title),
                    trailing: e.icon == null ? null : Icon(e.icon, color: Colors.white),
                    textColor: Colors.white,
                  ),
                  const Separator(color: Colors.black12)
                ],
              ),
          ],
        ),
      ),
    );
  }
}

void switchPage(BuildContext context, MainProvider provider, String link) {
  provider.editMode = false;
  provider.pageVisit = false;
  provider.errorMessage = '';

  if (provider.userList.isEmpty) {
    provider.errorMessage = 'Список пользователей пуст!';
  }

  Navigator.of(context).pushNamedAndRemoveUntil(link, (route) => false);
}

void hideJournalForRole(String role) {
  if (role == 'Повар') {
    journals.clear();
    toolsList.clear();
    journals.add(Journals('Бракеражный журнал', 'certPage'));
    toolsList.add(Journals('Создание и редактирование блюд', 'dishMenu'));
    toolsList.add(Journals('Меню на сегодня', 'todaysMenu', icon: Icons.window));
  }
  if (role == 'Кладовщик') {
    journals.clear();
    toolsList.clear();
    journals.add(Journals('Журнал контроль температуры и влажности оборудования', 'tmprPage'));
    toolsList.add(Journals('Список оборудования', 'appliancePage'));
  }
  if (role == 'Заведующий производством') {
  journals.clear();
  toolsList.clear();
  journals.add(Journals('Журнал контроль температуры и влажности оборудования', 'tmprPage'));
  journals.add(Journals('Бракеражный журнал', 'certPage'));
  journals.add(Journals('Журнал Здоровья', 'healthPage'));
  
  }
  if (role == 'Администратор') {
      journals.clear();
      toolsList.clear();
  toolsList.add(Journals('Пользователи и пароли', 'usersPage'));
  }
  else 
  {
    return;
  }
}