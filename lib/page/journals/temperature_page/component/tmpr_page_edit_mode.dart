import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:journal_app_v1/method/username_selected.dart';
import 'package:journal_app_v1/model/provider.dart';
import 'package:journal_app_v1/ui/page_component/checkbox_default.dart';
import 'package:journal_app_v1/ui/popup_menu_premade.dart';

class TmprPageEditModeContent extends StatelessWidget {
  const TmprPageEditModeContent(this.provider, {super.key});

  final MainProvider provider;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            PopupMenuAppliance(
              title: 'Укажите оборудование',
              onTap: (e) => provider.editTemperatureJournal(appliance: e),
              entries: provider.applianceList,
              selectedValue: provider.formTmpr.appliance?.name,
            )
          ],
        ),
        TextFormField(
          initialValue: provider.formTmpr.vlazhn.toString(),
          keyboardType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          onChanged: (value) => provider.editTemperatureJournal(
            vlazhn: value.isEmpty ? -1 : int.tryParse(value),
          ),
          decoration: const InputDecoration(label: Text('Влажность F%')),
        ),
        TextFormField(
          initialValue: provider.formTmpr.temperature.toString(),
          keyboardType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          onChanged: (value) => provider.editTemperatureJournal(
            temperature: value.isEmpty ? -1 : int.tryParse(value),
          ),
          decoration: const InputDecoration(label: Text('Температура')),
        ),
        CheckboxDefault(
          provider.formTmpr.sign,
          title:
              'Внесенные данные подтверждаю - ${genUserFirstnameSecondnameLastname(provider.userList[provider.currentUser])}',
          onChanged: (value) => provider.editTemperatureJournal(signWorker: value),
        ),
      ],
    );
  }
}
