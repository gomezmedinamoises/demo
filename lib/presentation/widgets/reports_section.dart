import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo/presentation/widgets/geolocation_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/routing/app_route_enum.dart';
import '../../core/style/palette_colors.dart';
import '../../data/model/report.dart';
import '../providers.dart';
import 'report_table.dart';

class ReportsSection extends ConsumerWidget {
  const ReportsSection({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUser = ref.read(firebaseAuthProvider).currentUser;
    final reportsQuery = ref
        .watch(reportRepositoryProvider)
        .reportsQuery(currentUser?.uid ?? '');

    return Scaffold(
      backgroundColor: PaletteColors.grey003,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Padding(
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
            child: StreamBuilder<QuerySnapshot<Report>>(
              stream: reportsQuery.snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Ha ocurrido un error'),
                      ],
                    ),
                  );
                }

                if (snapshot.data!.docs.isEmpty) {
                  return const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'No tienes reportes abiertos',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: PaletteColors.grey007),
                        ),
                      ],
                    ),
                  );
                }

                return ReportTable(snapshot: snapshot);
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: PaletteColors.blue,
        onPressed: () {
          context.goNamed(AppRoute.createReport.name);
          /*Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => GeoLocationSection()));*/
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
