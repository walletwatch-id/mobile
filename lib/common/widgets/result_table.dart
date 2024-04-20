import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:wallet_watch/common/theme/app_font_style.dart';

class ResultTable extends StatefulWidget {
  final String title;
  final List<String> columns;
  final List<DataRow> rows;
  const ResultTable({super.key, required this.title, required this.columns, required this.rows});

  @override
  State<ResultTable> createState() => _ResultTableState();
}

class _ResultTableState extends State<ResultTable> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            margin: const EdgeInsets.only(
              left: 16,
              top: 16,
              bottom: 8,
            ),
            child: Text(
              widget.title,
              style: AppFontStyle.homeListHeaderText.copyWith(fontSize: 19),
            )),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: DataTable(
                border: TableBorder.all(),
                dataRowMinHeight: 20,
                dataRowMaxHeight: 30,
                columnSpacing: 22,
                horizontalMargin: 12,
                dividerThickness: 2,
                headingRowHeight: 70,
                showBottomBorder: true,
                columns: widget.columns
                    .map((String column) => DataColumn2(
                        label: Text(
                          column,
                          softWrap: true,
                          textAlign: TextAlign.center,
                          maxLines: 3,
                        ),
                        numeric: true))
                    .toList(),
                rows: widget.rows),
          ),
        ),
      ],
    );
  }
}
