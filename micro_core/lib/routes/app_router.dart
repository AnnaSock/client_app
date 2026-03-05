library micro_core;

import 'package:base_app/presentation/pages/otp_page.dart';
import 'package:go_router/go_router.dart';
import 'package:base_app/presentation/pages/home_page.dart';
import 'package:base_app/presentation/pages/inscription_page_1.dart';
import 'package:base_app/presentation/pages/cgu_page.dart';

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






