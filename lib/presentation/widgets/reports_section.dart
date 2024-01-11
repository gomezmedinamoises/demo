import 'package:demo/presentation/widgets/report_table.dart';
import 'package:flutter/material.dart';

class ReportsSection extends StatelessWidget {
  const ReportsSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('Mis reportes'),
          Expanded(
            child: ReportTable(),
          ),
          ElevatedButton(
            onPressed: () {},
            child: Text('Nuevo reporte'),
          ),
        ],
      ),
    );
  }
}
