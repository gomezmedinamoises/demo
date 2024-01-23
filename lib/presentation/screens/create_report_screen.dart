import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';

import '../../core/routing/app_route_enum.dart';
import '../../core/style/palette_colors.dart';
import '../providers.dart';
import '../widgets/load_photos_section.dart';

// ignore: must_be_immutable
class CreateReportScreen extends ConsumerWidget {
  CreateReportScreen({
    super.key,
  });

  final TextEditingController reportTitle = TextEditingController();
  final TextEditingController reportDescription = TextEditingController();

  bool isSendingReport = false;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final reportRepository = ref.watch(reportRepositoryProvider);
    final user = ref.read(firebaseAuthProvider).currentUser;
    final images = ref.watch(imagePickerProvider);
    final imageUrls =
        ref.read(imageRepositoryProvider).uploadImages(images, user!.uid);

    final geolocationRepository = ref.read(geolocationProvider);

    return Scaffold(
      backgroundColor: PaletteColors.grey003,
      appBar: AppBar(
        backgroundColor: PaletteColors.blue,
        iconTheme: const IconThemeData(color: PaletteColors.grey003),
        title: const Text(
          'Crea tu reporte',
          style: TextStyle(color: PaletteColors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Card(
          surfaceTintColor: PaletteColors.white,
          shadowColor: PaletteColors.blue,
          elevation: 5.0,
          child: SingleChildScrollView(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Escribir reporte',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: reportTitle,
                      decoration: const InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(12.0),
                          ),
                          borderSide:
                              BorderSide(color: PaletteColors.blue, width: 1),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(12.0),
                          ),
                          borderSide:
                              BorderSide(color: PaletteColors.blue, width: 1),
                        ),
                        label: Text(
                          'Título',
                          style: TextStyle(color: PaletteColors.grey008),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: reportDescription,
                      decoration: const InputDecoration(
                        alignLabelWithHint: true,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(12.0),
                          ),
                          borderSide:
                              BorderSide(color: PaletteColors.blue, width: 1),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(12.0),
                          ),
                          borderSide:
                              BorderSide(color: PaletteColors.blue, width: 1),
                        ),
                        label: Text(
                          'Descripción',
                          style: TextStyle(color: PaletteColors.grey008),
                        ),
                      ),
                      keyboardType: TextInputType.multiline,
                      maxLines: 8,
                    ),
                    const SizedBox(height: 20),
                    const Divider(thickness: 1.0),
                    const SizedBox(height: 8),

                    // Load photo section
                    const LoadPhotosSection(),

                    const SizedBox(height: 8),

                    //GeoLocationSection(),
                    const Divider(thickness: 1.0),
                    const SizedBox(height: 8),

                    const Text(
                      'Agregar localización',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'LAT: ',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: PaletteColors.grey007),
                                  ),
                                  Expanded(
                                      child: Text(
                                    '',
                                    softWrap: true,
                                  ))
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'LON: ',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: PaletteColors.grey007),
                                  ),
                                  Expanded(
                                      child: Text(
                                    '',
                                    softWrap: true,
                                  ))
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'DIR: ',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: PaletteColors.grey007),
                                  ),
                                  Expanded(
                                    child: Text(
                                      '',
                                      softWrap: true,
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20.0,
                                  vertical: 10.0), // Aumenta el padding
                              textStyle: const TextStyle(fontSize: 18.0),
                            ).copyWith(alignment: Alignment.center),
                            onPressed: () async {
                              final currentPosition =
                                  await geolocationRepository
                                      .getCurrentLocation(context);

                              geolocationRepository
                                  .getAddressFromCoordinates(currentPosition);
                            },
                            child: const Text(
                              'Obtener localización',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 18.0),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 40),

                    ElevatedButton(
                      onPressed: () async {
                        try {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return const Center(
                                child: CircularProgressIndicator(
                                  backgroundColor: PaletteColors.grey003,
                                  color: PaletteColors.blue,
                                ),
                              );
                            },
                          );
                          var uuid = const Uuid();
                          reportRepository.createReport(
                            uuid.v4(),
                            user.uid,
                            reportTitle.text,
                            reportDescription.text,
                            await imageUrls,
                          );
                          ref.read(imagePickerProvider.notifier).clearImages();
                          Navigator.of(context).pop();
                          context.goNamed(AppRoute.home.name);
                        } catch (error) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                  'Se ha producido un error al enviar los datos: $error'),
                            ),
                          );
                        }
                      },
                      child: const Text(
                        'Enviar reporte',
                        style: TextStyle(fontSize: 18.0),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
