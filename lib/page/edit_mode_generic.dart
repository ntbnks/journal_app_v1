import 'package:flutter/material.dart';
import 'package:journal_app_v1/model/provider.dart';
import 'package:journal_app_v1/ui/page_component/edit_mode_post_and_cancel_widgets.dart';
import 'package:journal_app_v1/ui/text_headline.dart';

class EditModeGeneric extends StatelessWidget {
  const EditModeGeneric(
    this.provider, {
    required this.content,
    required this.onPost,
    super.key,
  });

  final MainProvider provider;
  final Widget content;
  final VoidCallback onPost;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Expanded(
            child: SizedBox(
              width: double.infinity,
              child: Form(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 64.0, vertical: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [const TextHeadline('Добавить новую запись'), content],
                    ),
                  ),
                ),
              ),
            ),
          ),
          EditModePostAndCancelWidgets(
            provider,
            onPost: onPost,
            onCancel: () => provider.toggleEdit(),
          ),
        ],
      ),
    );
  }
}
