import 'package:flutter/material.dart';

enum CurrentJournal { cert, health, tmpr }

class Journals {
  const Journals(this.title, this.link, {this.icon});
  final String title;
  final String link;
  final IconData? icon;
}

List<Journals> journals = const [
  Journals('Бракеражный журнал', 'certPage'),
  // 'Журнал визуального производственного контроля санитарно-технического состояния и санитарного содержания помещений',
  // 'Журнал входного контроля пищевых продуктов, продовольственного сырья(бракеража продуктов и продовольственного сырья,поступающего на пищеблок)',
  // 'Журнал выдачи направлений на медицинский осмотр',
  Journals('Журнал Здоровья', 'healthPage'),
  Journals('Журнал контроль температуры и влажности помещений', 'tmprPage'),

  // 'Журнал осмотра рук и открытых частей тела на наличие гнойничковых заболеваний и других нарушений целосности кожного покрова',
  // 'Журнал проведения генеральных уборок и санитарных дней',
  // 'Журнал проверки продуктов при получении',
  // 'Журнал регистрации и контроля работы бактерицидной установки',
  // 'Журнал регистрации остатков пищи',
  // 'Журнал скоропортящихся продуктов',
  // 'Журнал учета дезинфекции',
  // 'Журнал учёта получения и расходования дизенфицирующих средств и проведения дезинфекционных работ на объекте',
  // 'Журнал учета температурного режима холодильного оборудования',
];

List<Journals> toolsList = const [
  Journals('Пользователи и пароли', 'usersPage'),
  Journals('Меню на сегодня', 'todaysMenu', icon: Icons.window),
  Journals('Создание и редактирование блюд', 'dishMenu'),
  Journals('Список оборудования', 'appliancePage'),
];
