import 'package:flutter/material.dart';
import 'package:journal_app_v1/ui/page_component/text_in_table.dart';
import 'package:journal_app_v1/ui/palette.dart';

class TableDefault extends StatelessWidget {
  TableDefault({
    required this.headers,
    this.onPressHeader,
    required this.content,
    this.columnWidths,
    this.width,
    super.key,
  });

  final List<Object> headers;
  final Function(String)? onPressHeader;
  final List<TableRow> content;
  final Map<int, TableColumnWidth>? columnWidths;
  final double? width;

  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) => Expanded(
        child: SizedBox(
          width: width,
          child: Column(
            children: [
              Table(
                columnWidths: columnWidths,
                defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                border: TableBorder.all(color: Colors.black12),
                children: [
                  TableRow(
                    decoration: const BoxDecoration(color: Pal.lightGreen),
                    children: [
                      for (final e in headers)
                        if (e is String)
                          GestureDetector(
                            onTap: onPressHeader != null ? () => onPressHeader!(e) : null,
                            child: TextInTable(e),
                          )
                        else if (e is Widget)
                          e
                        else
                          const SizedBox.shrink(),
                    ],
                  ),
                ],
              ),
              Expanded(
                child: RawScrollbar(
                  thumbColor: Pal.lightGreen,
                  trackVisibility: true,
                  thumbVisibility: true,
                  thickness: 12,
                  controller: _scrollController,
                  child: ScrollConfiguration(
                    behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
                    child: ListView(
                      controller: _scrollController,
                      children: [
                        Table(
                          columnWidths: columnWidths,
                          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                          border: TableBorder.all(color: Colors.black12),
                          children: [
                            ...content,
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      );
}
