// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo/core/utils/status_report.dart';
import 'package:flutter/material.dart';

import '../../core/style/palette_colors.dart';
import '../../data/model/report.dart';

class ReportTable extends StatelessWidget {
  const ReportTable({
    super.key,
    required this.snapshot,
  });

  final AsyncSnapshot<QuerySnapshot<Report>> snapshot;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Container(
        color: PaletteColors.grey003,
        child: SingleChildScrollView(
          child: Card(
            surfaceTintColor: PaletteColors.white,
            shadowColor: PaletteColors.blue,
            elevation: 5.0,
            child: DataTable(
              columnSpacing: 10.0,
              horizontalMargin: 16.0,
              //border: TableBorder(verticalInside: BorderSide(width: 2.0)),
              columns: columns,
              rows: snapshot.data!.docs.map(
                (DocumentSnapshot<Report> document) {
                  Report report = document.data()!;
                  final year = report.createdAt?.year;
                  final month = report.createdAt?.month;
                  final day = report.createdAt?.day;
                  return DataRow(
                    cells: [
                      DataCell(
                        SizedBox(
                          width: 100,
                          child: Text(
                            '$day/$month/$year',
                            style: dataTextStyles,
                          ),
                        ),
                      ),
                      DataCell(
                        Text(
                          report.title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: dataTextStyles,
                        ),
                      ),
                      DataCell(
                        Column(
                          children: [
                            Text(
                              report.status,
                              style: dataTextStyles,
                            ),
                            const SizedBox(width: 5),
                            Container(
                              width: 15,
                              height: 15,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: getColorForStatusReport(report.status),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ).toList(),
            ),
          ),
        ),
      ),
    );

    // Don't remove this code
    /*return StreamBuilder<QuerySnapshot<Report>>(
      stream: reportsQuery.snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return const Text('Ha ocurrido un error');
        }

        if (!snapshot.hasData) {
          return const Text('No tienes reportes abiertos');
        }

        return Container(
          color: PaletteColors.grey001,
          child: SingleChildScrollView(
            child: Card(
              surfaceTintColor: Colors.white,
              shadowColor: PaletteColors.blue,
              elevation: 5.0,
              child: DataTable(
                columnSpacing: 10.0,
                horizontalMargin: 16.0,
                //border: TableBorder(verticalInside: BorderSide(width: 2.0)),
                columns: columns,
                rows: snapshot.data!.docs.map(
                  (DocumentSnapshot<Report> document) {
                    Report report = document.data()!;
                    final year = report.createdAt?.year;
                    final month = report.createdAt?.month;
                    final day = report.createdAt?.day;
                    return DataRow(
                      cells: [
                        DataCell(
                          SizedBox(
                            width: 100,
                            child: Text(
                              '$day/$month/$year',
                              style: dataTextStyles,
                            ),
                          ),
                        ),
                        DataCell(
                          Text(
                            report.title,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: dataTextStyles,
                          ),
                        ),
                        DataCell(
                          Column(
                            children: [
                              Text(
                                report.status,
                                style: dataTextStyles,
                              ),
                              const SizedBox(width: 5),
                              Container(
                                width: 15,
                                height: 15,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.yellow,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                ).toList(),
                //rows: getRows(),
                //dataRowColor: MaterialStateProperty.all(Colors.white),
              ),
            ),
          ),
        );
      },
    );*/
  }
}

TextStyle titlesStyle = const TextStyle(
  color: PaletteColors.grey008,
  fontWeight: FontWeight.bold,
  fontSize: 15.0,
  letterSpacing: 1.5,
);

TextStyle dataTextStyles = const TextStyle(color: PaletteColors.grey009);

List<DataColumn> columns = [
  DataColumn(
    label: SizedBox(
      //width: 10,
      child: Text(
        'Fecha',
        style: titlesStyle,
      ),
    ),
  ),
  DataColumn(
    label: Text(
      'Título',
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

Color getColorForStatusReport(String status) {
  switch (status) {
    case StatusReport.open:
      return Colors.yellow;
    case StatusReport.closed:
      return Colors.green;
    default:
      return Colors.yellow;
  }
}

 // Don't remove this code
/*List<DataRow> getRows() {
  return rowsData.map(
    (RowData row) {
      return DataRow(
        cells: [
          DataCell(Text(
            row.date,
            style: dataTextStyles,
          )),
          DataCell(Text(
            row.title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: dataTextStyles,
          )),
          DataCell(
            Column(
              children: [
                Text(
                  row.status,
                  style: dataTextStyles,
                ),
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
}*/
