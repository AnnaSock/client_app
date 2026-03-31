import 'package:bceao_pi/views/pages/home_pi.dart';
import 'package:go_router/go_router.dart';
import 'package:micro_core/routes/micro_route.dart';

class BCEAOPiRoute implements MicroRoute {
  @override
  Future<void> init() {
    // TODO: implement init
    throw UnimplementedError();
  }

  @override
  String get name => "bceao-pi";

  @override
  List<RouteBase> get routes => [
    GoRoute(
      path: '/home',
      name: 'piHome',
      builder: (context, state) => HomePi(),
    ),

  ];


}
