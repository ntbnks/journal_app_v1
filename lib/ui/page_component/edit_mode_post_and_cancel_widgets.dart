import 'package:flutter/material.dart';
import 'package:journal_app_v1/model/provider.dart';
import 'package:journal_app_v1/ui/page_component/buttons_sized.dart';
import 'package:journal_app_v1/ui/page_component/field_widget.dart';

class EditModePostAndCancelWidgets extends StatelessWidget {
  const EditModePostAndCancelWidgets(
    this.provider, {
    required this.onPost,
    this.onCancel,
    super.key,
  });
  final MainProvider provider;

  final Function() onPost;
  final Function()? onCancel;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Separator(),
        ConstrainedBox(
          constraints: const BoxConstraints(minWidth: 72),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    provider.errorMessage.isNotEmpty
                        ? provider.errorMessage
                        : provider.problems.isEmpty
                            ? 'Заполните поля и нажмите "Добавить запись".'
                            : provider.problems,
                  ),
                ),
                ButtonSized(
                  title: 'Добавить запись',
                  loading: provider.loading,
                  onPressed: onPost,
                  colorBackgroundDisabled: Colors.transparent,
                  showLoadingIndicator: false,
                ),
                const SizedBox(width: 8),
                TextButtonSized(
                  title: 'Отменить изменения',
                  loading: provider.loading,
                  onPressed: onCancel ?? () => provider.toggleEdit(),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
