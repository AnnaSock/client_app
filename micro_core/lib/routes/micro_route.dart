

import 'package:go_router/go_router.dart';

/// Contrat que chaque micro-app doit implémenter

abstract class MicroRoute {
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
