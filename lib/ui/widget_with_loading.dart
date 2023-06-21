import 'package:flutter/material.dart';
import 'package:journal_app_v1/model/provider.dart';
import 'package:journal_app_v1/ui/page_component/error_loading_page.dart';

class WidgetWithLoading extends StatelessWidget {
  const WidgetWithLoading({required this.provider, required this.widget, super.key});
  final Widget widget;
  final MainProvider provider;
  @override
  Widget build(BuildContext context) {
    if (provider.errorMessage.isNotEmpty) {
      return ErrorLoadingPageWidget(
        provider.errorMessage,
        loading: provider.loading,
      );
    } else if (provider.loading) {
      return const Expanded(child: Center(child: CircularProgressIndicator()));
    } else {
      return widget;
    }
  }
}
