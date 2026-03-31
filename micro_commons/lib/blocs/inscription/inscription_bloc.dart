import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:micro_commons/blocs/inscription/inscription_event.dart';
import 'package:micro_commons/blocs/inscription/inscription_state.dart';
import 'package:micro_core/services/firebase_service.dart';

class InscriptionBloc extends Bloc<InscriptionEvent, InscriptionState> {
  final FirebaseService firebase;

  InscriptionBloc({required this.firebase}) : super(InscriptionInitial()) {
    on<SendOtpEvent>(_onSendOtp);
    on<VerifyOtpEvent>(_onVerifyOtp);
    on<CompleteProfileEvent>(_onCompleteProfile);
  }

  Future<void> _onSendOtp(SendOtpEvent event, Emitter<InscriptionState> emit) async {
    emit(InscriptionLoading());
    try {
      await firebase.auth.sendOtp(event.phone);  // SMS envoyé
      emit(OtpSent(event.phone));
    } catch (e) {
      emit(InscriptionError('Erreur envoi OTP: $e'));
    }
  }

  Future<void> _onVerifyOtp(VerifyOtpEvent event, Emitter<InscriptionState> emit) async {
    emit(InscriptionLoading());
    try {
      final user = await firebase.auth.verifyOtp(event.otpCode);  // Vérif + login
      emit(OtpVerified(user!.uid));
    } catch (e) {
      emit(InscriptionError('OTP invalide: $e'));
    }
  }

  Future<void> _onCompleteProfile(CompleteProfileEvent event, Emitter<InscriptionState> emit) async {
    emit(InscriptionLoading());
    try {
      final userId = (state as OtpVerified).userId;
      await firebase.firestore.saveUser(userId, {
        'nom': event.nom,
        'prenom': event.prenom,
        'code_secret': event.codeSecret,
        'phone': userId,  // Phone verified
        'created_at': FieldValue.serverTimestamp(),
      });
      emit(ProfileCompleted());
    } catch (e) {
      emit(InscriptionError('Erreur profil: $e'));
    }
  }
}