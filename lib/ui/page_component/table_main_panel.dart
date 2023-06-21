import 'package:flutter/material.dart';
import 'package:journal_app_v1/ui/palette.dart';
import 'package:journal_app_v1/ui/values.dart';

class TableMainPanel extends StatelessWidget {
  const TableMainPanel({
    super.key,
    required this.title,
    this.controls,
  });

  final String title;
  final Widget? controls;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: Val.topPanelHeight,
      color: Pal.lightestGreen,
      child: Row(
        children: [
          /// Page's title
          Expanded(
            child: Container(
              alignment: Alignment.centerLeft,
              height: double.infinity,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  title, // use variable at the top to never lurk for this line specifically.
                  style: Theme.of(context)
                      .textTheme
                      .headline4!
                      .copyWith(overflow: TextOverflow.ellipsis),
                ),
              ),
            ),
          ),
          if (controls != null) controls!
        ],
      ),
    );
  }
}
