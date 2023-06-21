import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:journal_app_v1/model/provider.dart';
import 'package:journal_app_v1/ui/page_component/checkbox_default.dart';
import 'package:journal_app_v1/ui/page_component/edit_mode_post_and_cancel_widgets.dart';
import 'package:journal_app_v1/ui/popup_menu_premade.dart';
import 'package:journal_app_v1/ui/text_headline.dart';

class TmprPageEditMode extends StatelessWidget {
  const TmprPageEditMode(this.provider, {super.key});

  final MainProvider provider;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Form(
            child: Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 64.0, vertical: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const TextHeadline('Добавить новую запись'),
                      Row(
                        children: [
                          PopupMenuAppliance(
                            title: 'Укажите оборудование',
                            onTap: (e) => provider.editTemperatureJournal(appliance: e.name),
                            entries: provider.applianceList,
                            selectedValue: provider.formTmpr.appliance,
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
                        title: 'Внесенные данные подтверждаю - Капусткин Иван Петрович',
                        onChanged: (value) => provider.editTemperatureJournal(signWorker: value),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          EditModePostAndCancelWidgets(
            provider,
            onPost: () {
              if (provider.formTmpr.appliance.isEmpty ||
                  provider.formTmpr.vlazhn < 0 ||
                  provider.formTmpr.temperature < 0 ||
                  !provider.formTmpr.sign) {
                provider.problemsList('Одно из полей не заполнено!');
              } else {
                provider.postTmpr(
                  warehouse: provider.formTmpr.warehouse,
                  vlazhn: provider.formTmpr.vlazhn,
                  temperature: provider.formTmpr.temperature,
                  signature: provider.formTmpr.sign,
                );
              }
            },
            onCancel: () => provider.toggleEdit(),
          ),
        ],
      ),
    );
  }
}
