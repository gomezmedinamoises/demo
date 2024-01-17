import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../presentation/providers.dart';
import '../../presentation/screens/create_report_screen.dart';
import '../../presentation/screens/custom_profile_screen.dart';
import '../../presentation/screens/custom_sign_in_screen.dart';
import '../../presentation/screens/home_screen.dart';
import 'app_route_enum.dart';
import 'go_router_refresh_stream.dart';
import 'route_paths.dart';

List<RouteBase> routes = [
  GoRoute(
    path: home,
    name: AppRoute.home.name,
    builder: (context, state) => const HomeScreen(),
    routes: [
      GoRoute(
        path: profile,
        name: AppRoute.profile.name,
        builder: (context, state) => const CustomProfileScreen(),
      ),
      GoRoute(
        path: createReport,
        name: AppRoute.createReport.name,
        builder: (context, state) => CreateReportScreen(),
      )
    ],
  ),
  GoRoute(
    path: signIn,
    name: AppRoute.signIn.name,
    builder: (context, state) => const CustomSignInScreen(),
  ),
];

final goRouterProvider = Provider<GoRouter>(
  (ref) {
    final firebaseAuth = ref.watch(firebaseAuthProvider);
    return GoRouter(
      initialLocation: signIn,
      debugLogDiagnostics: true,
      redirect: (context, state) {
        final isLoggedIn = firebaseAuth.currentUser != null;
        if (isLoggedIn) {
          if (state.uri.path == signIn) {
            return home;
          }
        } else {
          if (state.uri.path.startsWith(home)) {
            return signIn;
          }
        }
        return null;
      },
      refreshListenable: GoRouterRefreshStream(firebaseAuth.authStateChanges()),
      routes: routes,
    );
  },
);
