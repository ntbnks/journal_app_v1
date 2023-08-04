import 'package:flutter/material.dart';
import 'package:journal_app_v1/model/provider.dart';
import 'package:journal_app_v1/page/journals/appliances_page/appliances_page.dart';
import 'package:journal_app_v1/page/journals/cert_page/cert_page.dart';
import 'package:journal_app_v1/page/journals/dish_menu/dish_menu_page.dart';
import 'package:journal_app_v1/page/journals/health_page/health_page.dart';
import 'package:journal_app_v1/page/home_page.dart';
import 'package:journal_app_v1/page/journals/import_control_page.dart';
import 'package:journal_app_v1/page/journals/medical_examination_page.dart';
import 'package:journal_app_v1/page/journals/perishable_food_page.dart';
import 'package:journal_app_v1/page/login_page.dart';
import 'package:journal_app_v1/page/role_selection.dart';
import 'package:journal_app_v1/page/journals/temperature_page/tmpr_page.dart';
import 'package:journal_app_v1/page/todays_menu_page/todays_menu_page.dart';
import 'package:journal_app_v1/page/users_page.dart';
import 'package:journal_app_v1/ui/palette.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MainProvider(),
      builder: (context, child) => MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          textTheme: Theme.of(context).textTheme.apply(fontSizeFactor: 1.4),
          checkboxTheme: CheckboxThemeData(fillColor: MaterialStateProperty.all(Pal.defaultGreen)),
          colorScheme: ColorScheme(
            brightness: Brightness.light,
            primary: Pal.defaultGreen,
            onPrimary: Colors.white,
            secondary: Pal.defaultGreen,
            onSecondary: Colors.white,
            error: Colors.red,
            onError: Colors.red[400]!,
            background: Colors.white,
            onBackground: Colors.grey[100]!,
            surface: Pal.lightGreen,
            onSurface: Pal.lightestGreen,
          ),
          tooltipTheme: const TooltipThemeData(
            textStyle: TextStyle(
              fontSize: 18,
              color: Colors.white,
            ),
          ),
          pageTransitionsTheme: PageTransitionsTheme(
            builders: {
              // No animations for every OS
              for (final platform in TargetPlatform.values) platform: const NoTransitionsBuilder(),
            },
          ),
        ),
        routes: routes,
        onGenerateRoute: (settings) {
          return PageRouteBuilder(
            transitionDuration: Duration.zero,
            reverseTransitionDuration: Duration.zero,
            settings: settings,
            pageBuilder: (context, __, ___) {
              return routes[settings.name]!(context);
            },
          );
        },
        home: const LoginPage(),
      ),
    );
  }
}

Map<String, WidgetBuilder> routes = {
  LoginPage.route: (_) => const LoginPage(),
  HomePage.route: (_) => const HomePage(),
  PageFoodCertification.route: (_) => const PageFoodCertification(),
  PageHealth.route: (_) => PageHealth(),
  PageTemperature.route: (_) => PageTemperature(),
  UsersPage.route: (_) => const UsersPage(),
  RoleSelectionPage.route: (_) => const RoleSelectionPage(),
  DishMenuPage.route: (_) => const DishMenuPage(),
  TodaysMenuPage.route: (_) => const TodaysMenuPage(),
  AppliancesPage.route: (_) => const AppliancesPage(),
  ImportControlJournalPage.route: (_) => const ImportControlJournalPage(),
  PerishableFoodJournalPage.route: (_) => const PerishableFoodJournalPage(),
  MedExaminationJournalPage.route: (_) => const MedExaminationJournalPage(),
};

class NoTransitionsBuilder extends PageTransitionsBuilder {
  const NoTransitionsBuilder();

  @override
  Widget buildTransitions<T>(
    PageRoute<T>? route,
    BuildContext? context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget? child,
  ) {
    // only return the child without warping it with animations
    return child!;
  }
}

class JournalPageArguments {
// Jour
}
