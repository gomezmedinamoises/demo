import 'package:demo/core/routing/app_route_enum.dart';
import 'package:demo/core/style/palette_colors.dart';
import 'package:demo/presentation/widgets/report_table.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ReportsSection extends StatelessWidget {
  const ReportsSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PaletteColors.grey001,
      body: const Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 12.0),
            child: Text(
              'Mis reportes',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: ReportTable(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: PaletteColors.blue,
        onPressed: () {
          // Create a new report
          context.goNamed(AppRoute.createReport.name);
        },
        child: const Icon(
          Icons.add,
          color: PaletteColors.white,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
    );
  }
}
