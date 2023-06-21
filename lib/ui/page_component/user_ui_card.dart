import 'package:flutter/material.dart';
import 'package:journal_app_v1/method/trigger_popup_navigation.dart';
import 'package:journal_app_v1/model/provider.dart';
import 'package:journal_app_v1/page/role_selection.dart';
import 'package:journal_app_v1/ui/palette.dart';

class UserUICard extends StatelessWidget {
  const UserUICard(this.provider, {super.key});
  final MainProvider provider;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Material(
            color: Colors.transparent,
            child: IconButton(
              tooltip: 'Скрыть/развернуть',
              icon: const Icon(Icons.menu, color: Colors.black),
              onPressed: () => provider.toogleDrawer(),
            ),
          ),
        ),
        if (provider.drawerOpen) ...[
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  provider.currentUserName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style:
                      Theme.of(context).textTheme.bodyText1!.copyWith(fontWeight: FontWeight.bold),
                ),
                Row(
                  children: [
                    Text(
                      'Владелец',
                      style: Theme.of(context)
                          .textTheme
                          .bodyText2!
                          .copyWith(color: Pal.defaultGreen, fontSize: 16),
                    ),
                    const SizedBox(width: 8),
                    if (provider.debug)
                      Text(
                        'debug mode',
                        style:
                            Theme.of(context).textTheme.bodyText2!.copyWith(color: Pal.defaultRed),
                      ),
                  ],
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () {},
            tooltip: 'Уведомления',
            icon: const Icon(Icons.notifications_none),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8, right: 16),
            child: PopupMenuButton(
              tooltip: 'Меню',
              itemBuilder: (_) => [
                PopupMenuItem(
                  onTap: () => triggerPopupNavigation(
                    context,
                    () => Navigator.of(context).pushNamedAndRemoveUntil(
                      RoleSelectionPage.route,
                      (route) => false,
                    ),
                  ),
                  child: Row(
                    children: const [
                      Padding(
                        padding: EdgeInsets.only(right: 12.0),
                        child: Icon(Icons.person_pin),
                      ),
                      Text('Сменить роль'),
                    ],
                  ),
                ),
                PopupMenuItem(
                  onTap: () => triggerPopupNavigation(context, () => provider.logout(context)),
                  child: Row(
                    children: const [
                      Padding(
                        padding: EdgeInsets.only(right: 12.0),
                        child: Icon(Icons.logout),
                      ),
                      Text('Выйти'),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ],
    );
  }
}
