import 'package:flutter/material.dart';
import 'package:journal_app_v1/model/provider.dart';
import 'package:journal_app_v1/page/cert_page/cert_page.dart';
import 'package:journal_app_v1/ui/role_selection_button.dart';
import 'package:provider/provider.dart';

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
                                      RoleSelectionButton(UserRole.washer),
                                      SizedBox(width: 8),
                                      RoleSelectionButton(UserRole.cashier),
                                      SizedBox(width: 8),
                                      RoleSelectionButton(UserRole.keeper),
                                      SizedBox(width: 8),
                                      RoleSelectionButton(UserRole.accountant),
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

class UserRoleValues {
  UserRoleValues({this.uiName = 'role', this.uiIcon = Icons.abc, this.route = ''});
  final String uiName;
  final IconData uiIcon;
  final String route;

  factory UserRoleValues.getRoleValues(UserRole role) {
    switch (role) {
      case UserRole.manager:
        return UserRoleValues(
          uiName: 'Менеджер столовой',
          uiIcon: Icons.food_bank,
          route: PageFoodCertification.route,
        );
      case UserRole.cook:
        return UserRoleValues(
          uiName: 'Повар',
          uiIcon: Icons.restaurant_menu,
          route: PageFoodCertification.route,
        );

      case UserRole.washer:
        return UserRoleValues(
          uiName: 'Мойщик',
          uiIcon: Icons.clean_hands,
          route: PageFoodCertification.route,
        );
      case UserRole.cashier:
        return UserRoleValues(
          uiName: 'Продавец',
          uiIcon: Icons.attach_money,
          route: PageFoodCertification.route,
        );
      case UserRole.keeper:
        return UserRoleValues(
          uiName: 'Кладовщик',
          uiIcon: Icons.warehouse,
          route: PageFoodCertification.route,
        );
      case UserRole.accountant:
        return UserRoleValues(
          uiName: 'Калькулятор',
          uiIcon: Icons.calculate,
          route: PageFoodCertification.route,
        );
      default:
        return UserRoleValues(
          uiName: 'Владелец',
          uiIcon: Icons.manage_accounts,
          route: PageFoodCertification.route,
        );
    }
  }
}
