import 'package:flutter/material.dart';
import 'package:journal_app_v1/model/messages.dart';
import 'package:journal_app_v1/model/models.dart';
import 'package:journal_app_v1/model/provider.dart';
import 'package:journal_app_v1/model/restapi.dart';
import 'package:journal_app_v1/page/role_selection.dart';
import 'package:journal_app_v1/ui/page_component/topbar_button.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  static const String route = 'homePage';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    fetchUserInfo(context, Provider.of<MainProvider>(context, listen: false));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    /// Go to next page immediately.
    // Timer(
    //     const Duration(milliseconds: 400),
    //     () => Navigator.of(context)
    //         .pushNamedAndRemoveUntil(PageFoodCertification.route, (route) => false));
    return Scaffold(
      body: Consumer<MainProvider>(
        builder: (context, provider, _) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  provider.statusMsg.isNotEmpty
                      ? provider.errorMessage.isNotEmpty
                          ? provider.errorMessage
                          : provider.statusMsg
                      : 'Инициализация...',
                ),
                const SizedBox(height: 16),
                if (provider.errorMessage.isNotEmpty) ...[
                  TopBarButton(
                    onPressed: () {
                      provider.errorCall('');
                      fetchUserInfo(context, provider);
                    },
                    icon: Icons.refresh,
                    loadingFlag: provider.loading,
                  ),
                  const Text('Обновить страницу')
                ] else
                  const CircularProgressIndicator(),
              ],
            ),
          );
        },
      ),
    );
  }
}

void fetchUserInfo(BuildContext context, MainProvider provider) {
  provider.statusMsg = 'Получение информации о пользователях';

  RestAPI().fetch('usersGet').then((value) {
    provider.userList.clear();
    if (value is List<dynamic>) {
      for (final e in value) {
        provider.userList.add(
          User(
            (e as Map)['id'] as int,
            name: e['name'] as String,
            fam: e['surname'] as String,
            otch: e['otch'] as String,
            // role: e['role'] as String,
            role: 'role',

            banned: e['banned'] as bool,
            deleted: e['deleted'] as bool,
          ),
        );
      }
      provider.genCurrentUserName();
      fetchDishInfo(context, provider);
    }
  }).catchError((onError) {
    provider.errorCall(
      'Ошибка при получении списка пользователей:\n\r ${Messages().errorTableHandler(onError.toString())}',
    );
  });
}

void fetchDishInfo(BuildContext context, MainProvider provider) {
  provider.newStatus('Получение информации о блюдах');
  RestAPI().fetch('dishesGet').then((value) {
    provider.dishList.clear();
    if (value is List<dynamic>) {
      for (final e in value) {
        provider.dishList.add(
          DishEntry(
            id: (e as Map)['id'] as int,
            name: e['dish'] as String,
            // category: e['category'] as String,
            category: 'Гарниры',

            // active: e['active'] as bool,
            active: false,
          ),
        );
      }
      print(value);
      for (final e in provider.dishList) {
        print('${e.id}: ${e.name}, active: ${e.active}.');
      }
      fetchApplianceInfo(context, provider);
    }
  }).catchError((onError) {
    provider.errorCall(
      'Ошибка при получении списка блюд:\n\r ${Messages().errorTableHandler(onError.toString())}',
    );
  });
}

void fetchApplianceInfo(BuildContext context, MainProvider provider) {
  provider.newStatus('Получение информации об устройствах');
  RestAPI().fetch('appliancesGet').then((value) {
    provider.applianceList.clear();
    if (value is List<dynamic>) {
      for (final e in value) {
        provider.applianceList.add(
          Appliance(
            id: (e as Map)['id'] as int,
            name: e['name'] as String,
            normalPoint: e['normalpoint'] as String,
            startNormalPoint: e['startnormalpoint'] as int,
            endNormalPoint: e['endnormalpoint'] as int,
          ),
        );
      }
      print(value);
      for (final e in provider.applianceList) {
        print('${e.id}: ${e.name}');
      }
      fetchProffesionInfo(context, provider);
    }
  }).catchError((onError) {
    provider.errorCall(
      'Ошибка при получении списка устройств:\n\r ${Messages().errorTableHandler(onError.toString())}',
    );
  });
}

void fetchProffesionInfo(BuildContext context, MainProvider provider) {
  provider.newStatus('Получение информации о профессиях');
  RestAPI().fetch('professionsGet').then((value) {
    print(value);
    provider.professionList.clear();
    if (value is List<dynamic>) {
      for (final e in value) {
        provider.professionList.add(
          ProfessionEntry(
            id: (e as Map)['id'] as int,
            name: e['name'] as String,
          ),
        );
      }
      print(value);
      for (final e in provider.professionList) {
        print(' ${e.id}: ${e.name}');
      }
      Navigator.of(context).pushNamedAndRemoveUntil(RoleSelectionPage.route, (route) => false);
    }
  }).catchError((onError) {
    provider.errorCall(
      'Ошибка при получении списка профессий:\n\r ${Messages().errorTableHandler(onError.toString())}',
    );
  });
}
