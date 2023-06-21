import 'package:flutter/material.dart';
import 'package:journal_app_v1/model/messages.dart';

class ErrorLoadingPageWidget extends StatelessWidget {
  const ErrorLoadingPageWidget(this.message, {required this.loading, super.key});

  final String message;
  final bool loading;
  @override
  Widget build(BuildContext context) => Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SelectableText(Messages().errorTableHandler(message)),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              loading ? 'Пытаемся загрузить страницу...' : 'Попробуйте перезагрузить страницу.',
            ),
          ),
          if (loading)
            const SizedBox(height: 32, child: CircularProgressIndicator())
          else
            const SizedBox(height: 32)
        ],
      );
}
