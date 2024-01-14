import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/routing/app_route_enum.dart';
import '../../core/style/palette_colors.dart';
import '../providers.dart';
import '../widgets/newsfeed_section.dart';
import '../widgets/reports_section.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth = ref.read(firebaseAuthProvider);

    return Scaffold(
      backgroundColor: PaletteColors.grey003,
      appBar: AppBar(
        backgroundColor: PaletteColors.blue,
        title: const Text(
          'Gobern App',
          style: TextStyle(color: PaletteColors.white),
        ),
        actions: [
          IconButton(
            onPressed: () {
              FirebaseUIAuth.signOut(auth: auth);
              context.goNamed(AppRoute.signIn.name);
            },
            icon: const Icon(
              Icons.logout,
              color: PaletteColors.white,
            ),
          ),
        ],
      ),
      body: const Padding(
        padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: ReportsSection(),
            ),
            Expanded(
              flex: 1,
              child: NewsfeedSection(),
            ),
          ],
        ),
      ),
    );
  }
}
