import 'package:flutter/material.dart';
import 'package:journal_app_v1/model/messages.dart';
import 'package:journal_app_v1/model/models.dart';

class PopupMenuPremade extends StatelessWidget {
  const PopupMenuPremade({
    required this.title,
    required this.onTap,
    required this.entries,
    required this.selectedValue,
    super.key,
  });
  final String title;
  final List<int> entries;
  final int selectedValue;
  final Function(int) onTap;
  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title),
          SizedBox(
            height: 56,
            child: PopupMenuButton(
              tooltip: '',
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.expand_circle_down_outlined),
                    const SizedBox(width: 8),
                    Text(Messages().genRatingFromInt(selectedValue))
                  ],
                ),
              ),
              itemBuilder: (context) {
                final List<PopupMenuItem> menuList = [];
                for (final e in entries) {
                  menuList.add(
                    PopupMenuItem(
                      onTap: () => onTap(e),
                      child: Text(Messages().genRatingFromInt(e)),
                    ),
                  );
                }

                return menuList;
              },
            ),
          ),
          const SizedBox(height: 32)
        ],
      );
}

class PopupMenuProfessions extends StatelessWidget {
  const PopupMenuProfessions({
    required this.title,
    required this.onTap,
    required this.entries,
    required this.selectedValue,
    super.key,
  });
  final String title;
  final List<ProfessionEntry> entries;
  final int selectedValue;
  final Function(ProfessionEntry) onTap;
  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 56,
                child: PopupMenuButton(
                  tooltip: '',
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      children: [
                        const Icon(Icons.expand_circle_down_outlined),
                        const SizedBox(width: 8),
                        Text(
                          selectedValue < 0
                              ? 'Выберите профессию'
                              : entries.firstWhere((element) => element.id == selectedValue).name,
                        )
                      ],
                    ),
                  ),
                  itemBuilder: (context) {
                    final List<PopupMenuItem> menuList = [];
                    for (final e in entries) {
                      menuList.add(
                        PopupMenuItem(
                          onTap: () => onTap(e),
                          child: Text(e.name),
                        ),
                      );
                    }

                    return menuList;
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 32)
        ],
      );
}

class PopupMenuDishes extends StatelessWidget {
  const PopupMenuDishes({
    required this.title,
    required this.onTap,
    required this.entries,
    required this.selectedEntry,
    super.key,
  });
  final String title;
  final List<DishEntry> entries;
  final String selectedEntry;
  final Function(DishEntry) onTap;
  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title),
          Row(
            children: [
              PopupMenuButton(
                icon: const Icon(Icons.expand_circle_down_outlined),
                itemBuilder: (context) {
                  final List<PopupMenuItem> menuList = [];
                  for (final e in entries.where((element) => element.active)) {
                    menuList.add(
                      PopupMenuItem(
                        onTap: () => onTap(e),
                        child: Text(e.name),
                      ),
                    );
                  }

                  return menuList;
                },
              ),
              Text(selectedEntry)
            ],
          ),
          const SizedBox(height: 32)
        ],
      );
}

class PopupMenuAppliance extends StatelessWidget {
  const PopupMenuAppliance({
    required this.title,
    required this.onTap,
    required this.entries,
    required this.selectedValue,
    super.key,
  });
  final String title;
  final List<Appliance> entries;
  final String selectedValue;
  final Function(Appliance) onTap;
  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 56,
                child: PopupMenuButton(
                  tooltip: '',
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      children: [
                        const Icon(Icons.expand_circle_down_outlined),
                        const SizedBox(width: 8),
                        Text(
                          selectedValue == '' ? 'Открыть список оборудования' : selectedValue,
                        )
                      ],
                    ),
                  ),
                  itemBuilder: (context) {
                    final List<PopupMenuItem> menuList = [];
                    for (final e in entries) {
                      menuList.add(
                        PopupMenuItem(
                          onTap: () => onTap(e),
                          child: Text(e.name),
                        ),
                      );
                    }

                    return menuList;
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 32)
        ],
      );
}
