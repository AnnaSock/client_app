import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:micro_core/routes/micro_route.dart';

class WalletTFSRoute implements MicroRoute {
  @override
  Future<void> init() {
    // TODO: implement init
    throw UnimplementedError();
  }

  @override
  String get name => "wallet-tfs";

  @override
  List<RouteBase> get routes => [
  GoRoute(
  path: '/wallet',
  name: 'walletHome',
  builder: (context, state) => const Text("ceci est le home"),
  ),
  GoRoute(
  path: '/wallet/transfer',
  name: 'walletTransfer',
  builder: (context, state) => const Text("ceci est un test"),
  )
  ];


}
