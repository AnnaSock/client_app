import 'package:go_router/go_router.dart';
import 'package:micro_core/routes/micro_route.dart';
import 'package:wallet_tfs_app/views/pages/wallet_tfs_page.dart';

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
  builder: (context, state) => WalletTfsPage(),
  ),

  ];


}
