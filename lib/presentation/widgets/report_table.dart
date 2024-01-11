// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:demo/core/style/palette_colors.dart';
import 'package:flutter/material.dart';

class ReportTable extends StatelessWidget {
  const ReportTable({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    //final _data = MyDataTableSource();

    return Container(
      color: Colors.white,
      child: SingleChildScrollView(
        child: Card(
          surfaceTintColor: Colors.white,
          shadowColor: PaletteColors.blue,
          elevation: 5.0,
          child: DataTable(
            columnSpacing: 25.0,
            horizontalMargin: 16.0,
            //border: TableBorder(verticalInside: BorderSide(width: 2.0)),
            columns: columns,
            rows: getRows(),
            //dataRowColor: MaterialStateProperty.all(Colors.white),
          ),
        ),
      ),
    );
  }
}

TextStyle titlesStyle = const TextStyle(
  fontWeight: FontWeight.bold,
  fontSize: 15.0,
  letterSpacing: 1.5,
);

List<DataColumn> columns = [
  DataColumn(
    label: Text(
      'Fecha',
      style: titlesStyle,
    ),
  ),
  DataColumn(
    label: Text(
      'Titulo',
      style: titlesStyle,
    ),
  ),
  DataColumn(
    label: Text(
      'Estado',
      style: titlesStyle,
    ),
  ),
];

List<DataRow> getRows() {
  return rowsData.map(
    (RowData row) {
      return DataRow(
        cells: [
          DataCell(Text(row.date)),
          DataCell(Text(
            row.title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          )),
          DataCell(
            Column(
              children: [
                Text(row.status),
                const SizedBox(width: 5),
                Container(
                  width: 15,
                  height: 15,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: row.color,
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    },
  ).toList();
}

List<RowData> rowsData = [
  RowData(
    date: '88/88/2082',
    title: 'Puede ser que sí o que no',
    status: 'Resuelto',
    color: Colors.green,
  ),
  RowData(
    date: '88/88/2082',
    title: 'También tienen plazos para leasing financiero',
    status: 'Abierto',
    color: Colors.yellow,
  ),
  RowData(
    date: '88/88/2082',
    title: 'También tienen plazos para leasing financiero',
    status: 'Abierto',
    color: Colors.yellow,
  ),
  RowData(
    date: '88/88/2082',
    title: 'También tienen plazos para leasing financiero',
    status: 'Abierto',
    color: Colors.yellow,
  ),
  RowData(
    date: '88/88/2082',
    title: 'También tienen plazos para leasing financiero',
    status: 'Abierto',
    color: Colors.yellow,
  ),
  RowData(
    date: '88/88/2082',
    title: 'También tienen plazos para leasing financiero',
    status: 'Abierto',
    color: Colors.yellow,
  ),
  RowData(
    date: '88/88/2082',
    title: 'También tienen plazos para leasing financiero',
    status: 'Abierto',
    color: Colors.yellow,
  ),
  RowData(
    date: '88/88/2082',
    title: 'También tienen plazos para leasing financiero',
    status: 'Abierto',
    color: Colors.yellow,
  ),
  RowData(
    date: '88/88/2082',
    title: 'También tienen plazos para leasing financiero',
    status: 'Abierto',
    color: Colors.yellow,
  ),
  RowData(
    date: '88/88/2082',
    title: 'También tienen plazos para leasing financiero',
    status: 'Abierto',
    color: Colors.yellow,
  ),
  RowData(
    date: '88/88/2082',
    title: 'También tienen plazos para leasing financiero',
    status: 'Abierto',
    color: Colors.yellow,
  ),
];

class RowData {
  String date;
  String title;
  String status;
  MaterialColor color;
  RowData({
    required this.date,
    required this.title,
    required this.status,
    required this.color,
  });
}
