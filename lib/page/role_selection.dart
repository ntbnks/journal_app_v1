import 'dart:math';
import 'package:flutter/material.dart';
import 'package:journal_app_v1/model/provider.dart';
import 'package:journal_app_v1/page/journals/cert_page/cert_page.dart';
import 'package:journal_app_v1/page/journals/temperature_page/tmpr_page.dart';
import 'package:journal_app_v1/page/users_page.dart';
import 'package:journal_app_v1/ui/role_selection_button.dart';
import 'package:provider/provider.dart';
import 'journals/health_page/health_page.dart';

int curInt = Random().nextInt(4) + 1;

class RoleSelectionPage extends StatefulWidget {
  const RoleSelectionPage({super.key});
  static const String route = 'roleSelection';

  @override
  State<RoleSelectionPage> createState() => _RoleSelectionPageState();
}

class _RoleSelectionPageState extends State<RoleSelectionPage> {
  bool introEffect = true;
  static const animDur = 100;
  static const curveDefault = Curves.easeIn;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() => introEffect = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          AnimatedOpacity(
            duration: const Duration(milliseconds: animDur),
            opacity: introEffect ? 0 : 1,
            curve: curveDefault,
            child: Container(height: double.infinity, color: Colors.black45),
          ),
          Center(
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: animDur),
              opacity: introEffect ? 0 : 1,
              curve: curveDefault,
              child: AnimatedScale(
                scale: introEffect ? 0.75 : 1,
                curve: curveDefault,
                duration: const Duration(milliseconds: animDur),
                child: IntrinsicHeight(
                  child: IntrinsicWidth(
                    child: DecoratedBox(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        boxShadow: [
                          BoxShadow(
                            offset: Offset(0, 8),
                            spreadRadius: 2,
                            blurRadius: 8,
                            color: Colors.black26,
                          )
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(32.0),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 16.0),
                              child: Center(
                                child: Text(
                                  'Выберите роль',
                                  style: Theme.of(context).textTheme.headline5,
                                ),
                              ),
                            ),
                            const SizedBox(height: 24),
                            Consumer<MainProvider>(
                              builder: (__, provider, _) => Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const [
                                      RoleSelectionButton(UserRole.admin),
                                      SizedBox(width: 8),
                                      RoleSelectionButton(UserRole.manager),
                                      SizedBox(width: 8),
                                      RoleSelectionButton(UserRole.cook),
                                      SizedBox(width: 8),
                                      RoleSelectionButton(UserRole.keeper),
                                      SizedBox(width: 8),
                                    ],
                                  ),
                                  const SizedBox(height: 32),
                                  const Text('Нажмите на роль для выбора.'),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const [
                                      Text('Для того, чтобы изменить роль в будущем, нажмите'),
                                      SizedBox(width: 8),
                                      Icon(Icons.more_vert),
                                      SizedBox(width: 8),
                                      Text('рядом с Вашим именен.'),
                                    ],
                                  ),
                                  const SizedBox(height: 32),
                                  SizedBox(
                                    height: 48,
                                    child: ElevatedButton(
                                      onPressed: () => provider.logout(context),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: const [
                                          Icon(Icons.logout),
                                          SizedBox(width: 8),
                                          Text('Выйти из учетной записи'),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

enum UserRole { admin, manager, cook, washer, cashier, keeper, accountant }

String GlobalRoleUiName = "NaN";

class UserRoleValues {
  UserRoleValues({this.uiName = 'role', this.uiIcon = Icons.abc, this.route = ''});
  final String uiName;
  final IconData uiIcon;
  final String route;
  factory UserRoleValues.getRoleValues(UserRole role) {
    switch (role) {
      case UserRole.manager:
        GlobalRoleUiName = 'Заведующий производством';
        return UserRoleValues(
          uiName: 'Заведующий производством',
          uiIcon: Icons.food_bank,
          route: PageHealth.route,
        );
      case UserRole.cook:
        GlobalRoleUiName = 'Повар';
        return UserRoleValues(
          uiName: 'Повар',
          uiIcon: Icons.restaurant_menu,
          route: PageFoodCertification.route,
        );
      case UserRole.washer:
        GlobalRoleUiName = 'Мойщик';
        return UserRoleValues(
          uiName: 'Мойщик',
          uiIcon: Icons.clean_hands,
          route: PageFoodCertification.route,
        );
      case UserRole.cashier:
        GlobalRoleUiName = 'Продавец';
        return UserRoleValues(
          uiName: 'Продавец',
          uiIcon: Icons.attach_money,
          route: PageFoodCertification.route,
        );
      case UserRole.keeper:
        GlobalRoleUiName = 'Кладовщик';
        return UserRoleValues(
          uiName: 'Кладовщик',
          uiIcon: Icons.warehouse,
          route: PageTemperature.route,
        );
      case UserRole.accountant:
        GlobalRoleUiName = 'Калькулятор';
        return UserRoleValues(
          uiName: 'Калькулятор',
          uiIcon: Icons.calculate,
          route: PageFoodCertification.route,
        );
      default:
        GlobalRoleUiName = 'Администратор';
        return UserRoleValues(
          uiName: 'Администратор',
          uiIcon: Icons.manage_accounts,
          route: UsersPage.route,
        );
    }
  }
}
