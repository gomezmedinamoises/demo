import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';

import '../../core/routing/app_route_enum.dart';
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
                decoration: const InputDecoration(
                  label: Text(
                    'Título',
                    style: TextStyle(color: PaletteColors.grey008),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: reportDescription,
                decoration: const InputDecoration(
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
                  reportRepository.createReport(
                    uuid.v4(),
                    user!.uid,
                    reportTitle.text,
                    reportDescription.text,
                  );
                  context.goNamed(AppRoute.home.name);
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
