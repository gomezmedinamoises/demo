import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

import '../../core/style/palette_colors.dart';
import '../providers.dart';

class CreateReportScreen extends ConsumerWidget {
  const CreateReportScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final reportRepository = ref.watch(reportRepositoryProvider);
    final user = ref.read(firebaseAuthProvider).currentUser;

    final TextEditingController reportTitle = TextEditingController();
    final TextEditingController reportDescription = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: PaletteColors.blue,
        iconTheme: const IconThemeData(color: PaletteColors.grey003),
        title: const Text(
          'Crea tu reporte',
          style: TextStyle(color: PaletteColors.white),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: reportTitle,
                decoration: InputDecoration(
                  label: Text(
                    'Título',
                    style: TextStyle(color: PaletteColors.grey008),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: reportDescription,
                decoration: InputDecoration(
                  label: Text(
                    'Descripción',
                    style: TextStyle(color: PaletteColors.grey008),
                  ),
                ),
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {
                  var uuid = const Uuid();
                  var date = getDateInLocalFormat(context);
                  reportRepository.createReport(
                    uuid.v4(),
                    user!.uid,
                    reportTitle.text,
                    reportDescription.text,
                    date,
                  );
                },
                child: const Text('Enviar reporte'),
              )
            ],
          ),
        ),
      ),
    );
  }
}

String getDateInLocalFormat(BuildContext context) {
  Locale locale = Localizations.localeOf(context);
  final languageCode = locale.languageCode;
  initializeDateFormatting(languageCode, null);

  DateFormat dateFormat = DateFormat('M/d/y', languageCode);
  DateTime now = DateTime.now();

  final currentDate = dateFormat.format(now);

  return currentDate;
}
