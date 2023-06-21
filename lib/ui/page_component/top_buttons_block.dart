import 'package:flutter/material.dart';
import 'package:journal_app_v1/model/provider.dart';
import 'package:journal_app_v1/model/restapi.dart';
import 'package:journal_app_v1/ui/page_component/topbar_button.dart';
import 'package:journal_app_v1/ui/palette.dart';
import 'package:provider/provider.dart';

class TopButtonsBlock extends StatelessWidget {
  const TopButtonsBlock({this.onAdd, this.onRefresh, this.onDelete, super.key});

  final Function()? onAdd;
  final Function()? onRefresh;
  final Function()? onDelete;
  @override
  Widget build(BuildContext context) {
    return Consumer<MainProvider>(
      builder: (context, provider, child) => Expanded(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: provider.editMode
              ? Align(
                  alignment: Alignment.centerRight,
                  child: TopBarButton(
                    tooltip: 'Закрыть и сохранить',
                    onPressed: onAdd ?? () => null,
                    icon: Icons.close,
                    color: PaletteColor.red,
                  ),
                )
              : Row(
                  children: [
                    const Expanded(child: SizedBox()),
                    TopBarButton(
                      tooltip: 'Добавить запись',
                      onPressed: onAdd ?? () => null,
                      icon: Icons.add,
                    ),
                    TopBarButton(
                      tooltip: 'Обновить страницу',
                      onPressed: onRefresh ?? () => null,
                      icon: Icons.refresh,
                      loadingFlag: provider.loading,
                    ),
                    TopBarButton(tooltip: 'Фильтр', onPressed: () {}, icon: Icons.filter_list),
                    TopBarButton(
                      tooltip: 'Очистить локальный список',
                      onPressed: onDelete ?? () => null,
                      icon: Icons.cleaning_services,
                      color: PaletteColor.red,
                    ),
                    if (provider.debug)
                      TopBarButton(
                        tooltip: 'Добавить пользователя',
                        onPressed: () => RestAPI().addUser(1).then((value) => print(value)),
                        icon: Icons.person_add,
                      ),
                  ],
                ),
        ),
      ),
    );
  }
}
