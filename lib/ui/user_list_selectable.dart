import 'package:flutter/material.dart';
import 'package:journal_app_v1/method/username_selected.dart';
import 'package:journal_app_v1/model/models.dart';

class UserListMenu extends StatelessWidget {
  const UserListMenu(
    this.userList, {
    required this.title,
    required this.onTap,
    required this.userNameFrom,
    super.key,
  });
  final List<User> userList;
  final String title;
  final int userNameFrom;
  final Function(int) onTap;
  @override
  Widget build(BuildContext context) => userList.isEmpty
      ? const Text('Список пользователй пуст или произошла ошибка.')
      : Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title),
            SizedBox(
              height: 56,
              child: PopupMenuButton(
                tooltip: '',
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.expand_circle_down_outlined),
                      const SizedBox(width: 8),
                      Text(genUserNameSelected(userList, userNameFrom)),
                    ],
                  ),
                ),
                itemBuilder: (context) {
                  final List<PopupMenuItem> menuList = [];
                  for (final e in userList) {
                    menuList.add(
                      PopupMenuItem(
                        onTap: () => onTap(e.id),
                        child: Text('${e.fam} ${e.name}'),
                      ),
                    );
                  }

                  return menuList;
                },
              ),
            ),
            const SizedBox(height: 32)
          ],
        );
}
