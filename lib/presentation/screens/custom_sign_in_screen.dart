import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers.dart';

class CustomSignInScreen extends ConsumerWidget {
  const CustomSignInScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authProviders = ref.watch(authProvidersProvider);
    return Scaffold(
      body: SignInScreen(
        showPasswordVisibilityToggle: true,
        styles: const {
          EmailFormStyle(
            signInButtonVariant: ButtonVariant.filled,
          ),
        },
        headerBuilder: (context, constraints, _) {
          return Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: CircleAvatar(
              backgroundColor: Colors.transparent,
              radius: 100,
              child: Container(
                width: 150.0,
                height: 150.0,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage('assets/images/gobernapp-logo.png'),
                  ),
                ),
              ),
            ),
          );
        },
        providers: authProviders,
      ),
    );
  }
}
