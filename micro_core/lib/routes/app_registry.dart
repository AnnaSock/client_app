import 'package:bceao_pi/views/routes/router.dart';
import 'package:micro_core/routes/micro_route.dart';
import 'package:wallet_tfs_app/views/routes/router.dart';

class AppRegistry  {

  static final List<MicroRoute> microApps = [
    WalletTFSRoute(),
    BCEAOPiRoute()
  ];

}
