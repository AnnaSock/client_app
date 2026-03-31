import 'package:equatable/equatable.dart';

abstract class InscriptionEvent extends Equatable {
  const InscriptionEvent();
  @override
  List<Object?> get props => [];
}

class SendOtpEvent extends InscriptionEvent {
  final String phone;
  const SendOtpEvent(this.phone);
  @override
  List<Object?> get props => [phone];
}

class VerifyOtpEvent extends InscriptionEvent {
  final String otpCode;
  const VerifyOtpEvent(this.otpCode);
  @override
  List<Object?> get props => [otpCode];
}

class CompleteProfileEvent extends InscriptionEvent {
  final String nom;
  final String prenom;
  final String codeSecret;
  const CompleteProfileEvent(this.nom, this.prenom, this.codeSecret);
  @override
  List<Object?> get props => [nom, prenom, codeSecret];
}