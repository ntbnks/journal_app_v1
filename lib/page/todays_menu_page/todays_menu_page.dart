import 'package:flutter/material.dart';
import 'package:journal_app_v1/model/provider.dart';
import 'package:journal_app_v1/page/cert_page/cert_page.dart';
import 'package:journal_app_v1/page/todays_menu_page/component/dialog_get_dishes.dart';
import 'package:journal_app_v1/ui/big_button_widget.dart';
import 'package:journal_app_v1/ui/page_component/buttons_sized.dart';
import 'package:journal_app_v1/ui/page_component/drawer.dart';
import 'package:journal_app_v1/ui/page_component/table_main_panel.dart';
import 'package:journal_app_v1/ui/text_headline.dart';
import 'package:provider/provider.dart';

class TodaysMenuPage extends StatelessWidget {
  const TodaysMenuPage({super.key});
  static const String route = 'todaysMenu';

  /// This page's title
  static const String title = 'Меню на сегодня';

  @override
  Widget build(BuildContext context) {
    /// build list Гарниры
    final dGarn = Provider.of<MainProvider>(context, listen: false)
        .dishList
        .where((element) => element.category == 'Гарниры');

    /// build list Выпечка
    final dBakery = Provider.of<MainProvider>(context, listen: false)
        .dishList
        .where((element) => element.category == 'Выпечка');

    /// build list Салаты
    final dSalad = Provider.of<MainProvider>(context, listen: false)
        .dishList
        .where((element) => element.category == 'Салаты');

    /// build list Напитки
    final dDrinks = Provider.of<MainProvider>(context, listen: false)
        .dishList
        .where((element) => element.category == 'Напитки');
    return Scaffold(
      body: Consumer<MainProvider>(
        builder: (context, provider, _) {
          /// build list Гарниры with active only length
          final dGarnLength = dGarn.where((element) => element.active).length;
          final dBakeryLength = dBakery.where((element) => element.active).length;
          final dSaladLength = dSalad.where((element) => element.active).length;
          final dDrinksLength = dDrinks.where((element) => element.active).length;
          return Row(
            children: [
              MainDrawer(provider),
              Expanded(
                child: Column(
                  children: [
                    /// Header and controls
                    const TableMainPanel(title: title),

                    Expanded(
                      flex: 3,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            const SizedBox(height: 16),
                            const TextHeadline('Создание меню на сегодня'),
                            const Text(
                              'Заполните категории и нажмите "Завершить редактирование".\n\rНекоторые категории могут быть оставлены пустыми.',
                            ),
                            const SizedBox(height: 32),
                            Wrap(
                              children: [
                                BigButtonWidget(
                                  icon: Icons.dinner_dining,
                                  checkboxValue: dGarnLength != 0,
                                  counter: dGarnLength,
                                  title: 'Гарниры',
                                  onPressed: () => showDialog(
                                    context: context,
                                    builder: (context) => DialogGetDishesWidget(
                                      dGarn,
                                      onDone: (list) => provider.editDishActiveUpdateCategory(
                                        list,
                                        'Гарниры',
                                      ),
                                    ),
                                  ),
                                ),
                                BigButtonWidget(
                                  icon: Icons.bakery_dining,
                                  checkboxValue: dBakeryLength != 0,
                                  counter: dBakeryLength,
                                  title: 'Выпечка',
                                  onPressed: () => showDialog(
                                    context: context,
                                    builder: (context) => DialogGetDishesWidget(
                                      dBakery,
                                      onDone: (list) => provider.editDishActiveUpdateCategory(
                                        list,
                                        'Выпечка',
                                      ),
                                    ),
                                  ),
                                ),
                                BigButtonWidget(
                                  icon: Icons.grass,
                                  checkboxValue: dSaladLength != 0,
                                  counter: dSaladLength,
                                  title: 'Салаты',
                                  onPressed: () => showDialog(
                                    context: context,
                                    builder: (context) => DialogGetDishesWidget(
                                      dSalad,
                                      onDone: (list) => provider.editDishActiveUpdateCategory(
                                        list,
                                        'Салаты',
                                      ),
                                    ),
                                  ),
                                ),
                                BigButtonWidget(
                                  icon: Icons.coffee,
                                  checkboxValue: dDrinksLength != 0,
                                  counter: dDrinksLength,
                                  title: 'Напитки',
                                  onPressed: () => showDialog(
                                    context: context,
                                    builder: (context) => DialogGetDishesWidget(
                                      dDrinks,
                                      onDone: (list) => provider.editDishActiveUpdateCategory(
                                        list,
                                        'Напитки',
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 72),
                            ButtonSized(
                              title: 'Завершить и перейти к бракержному журналу',
                              disabled:
                                  provider.dishList.where((element) => element.active).isEmpty,
                              scale: 1.5,
                              height: 72,
                              icon: Icons.check_circle_outline,
                              loading: provider.loading,
                              onPressed: () {
                                Navigator.of(context).pushNamedAndRemoveUntil(
                                  PageFoodCertification.route,
                                  (route) => false,
                                );
                                provider.toggleEdit(value: true);
                              },
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
