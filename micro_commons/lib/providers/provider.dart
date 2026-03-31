import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:micro_commons/blocs/inscription/inscription_bloc.dart';
import 'package:micro_core/services/firebase_service.dart';

final futureFirebaseProvider = FutureProvider<FirebaseService>((ref) async {
  await FirebaseService.instance.init();
  return FirebaseService.instance;
});

final inscriptionBlocProvider = Provider<InscriptionBloc>((ref) {
  return InscriptionBloc(firebase: FirebaseService.instance);
});
