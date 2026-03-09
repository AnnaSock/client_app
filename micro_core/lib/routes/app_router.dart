library micro_core;

import 'package:micro_core/routes/app_registry.dart';

import 'import_route.dart';
import 'package:go_router/go_router.dart';

final _router = GoRouter(
  initialLocation: '/home',
  routes: [
    GoRoute(
      path: '/home',
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      path: '/inscription',
      builder: (context, state) => const InscriptionPage1(),
    ),
    GoRoute(
      path: '/otp',
      builder: (context, state) => const OtpPage(),
    ),
    GoRoute(
      path: '/cgu',
      builder: (context, state) => const CguPage(),
    ),
    GoRoute(
      path: '/code-secret',
      builder: (context, state) => const CodeSecretPage(),
    ),
    
    ...AppRegistry.microApps.expand((m) => m.routes)
  ],
  redirect: (context, state) {
    // TODO: Redirection basée sur état auth
    return null;
  },
);

class AppRouter {
  static GoRouter get router => _router;
}






