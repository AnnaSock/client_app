library micro_core;

import 'package:base_app/presentation/pages/otp_page.dart';
import 'package:go_router/go_router.dart';
import 'package:base_app/presentation/pages/home_page.dart';
import 'package:base_app/presentation/pages/inscription_page_1.dart';

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
    )
  ],
  redirect: (context, state) {
    // TODO: Redirection basée sur état auth
    return null;
  },
);

class AppRouter {
  static GoRouter get router => _router;
}






/// Contrat que chaque micro-app doit implémenter
abstract class AppModule {
  /// Nom unique du module (utile pour debug, logs, analytics)
  String get name;

  /// Routes exposées par le module
  /// On utilise RouteBase pour supporter :
  /// - GoRoute
  /// - ShellRoute
  /// - StatefulShellRoute
  List<RouteBase> get routes;

  /// Méthode optionnelle d'initialisation
  /// (ex: injection dépendances, config, SDK, etc.)
  Future<void> init() async {}
}
