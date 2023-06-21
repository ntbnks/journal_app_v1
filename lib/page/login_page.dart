import 'package:flutter/material.dart';
import 'package:journal_app_v1/model/provider.dart';
import 'package:journal_app_v1/page/home_page.dart';
import 'package:journal_app_v1/ui/page_component/buttons_sized.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  static const String route = 'loginPage';

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  void initState() {
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
            child: SizedBox(
              width: 400,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Система ведения журналов общепита',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  const SizedBox(height: 32),
                  const TextField(
                    decoration: InputDecoration(label: Text('Имя пользователя')),
                  ),
                  const TextField(
                    decoration: InputDecoration(label: Text('Пароль')),
                  ),
                  const SizedBox(height: 32),
                  ButtonSized(
                    title: 'Войти',
                    width: double.infinity,
                    height: 64,
                    loading: provider.loading,
                    onPressed: () {
                      provider.currentUser = 1;
                      Navigator.of(context)
                          .pushNamedAndRemoveUntil(HomePage.route, (route) => false);
                    },
                  ),
                  const SizedBox(height: 16),
                  TextButtonSized(
                    width: double.infinity,
                    height: 64,
                    title: 'Восстановить пароль',
                    loading: provider.loading,
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
