import 'package:flutter/material.dart';
import 'package:journal_app_v1/page/role_selection.dart';

class RoleSelectionButton extends StatelessWidget {
  const RoleSelectionButton(this.role, {super.key});
  static const double buttonPadding = 32;
  final UserRole role;

  UserRoleValues get r => UserRoleValues.getRoleValues(role);
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(fixedSize: const Size(224, 288)),
      onPressed: () => Navigator.of(context).pushNamedAndRemoveUntil(r.route, (route) => false),
      child: Column(
        children: [
          const SizedBox(height: buttonPadding),
          Expanded(child: Icon(r.uiIcon, size: 128)),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: buttonPadding,
              horizontal: buttonPadding - 16,
            ),
            child: SizedBox(
              height: 72,
              child: Center(
                child: Text(
                  r.uiName,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headline6!.copyWith(color: Colors.white),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
