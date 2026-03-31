import 'package:equatable/equatable.dart';

abstract class InscriptionState extends Equatable {
  const InscriptionState();
  @override
  List<Object?> get props => [];
}

class InscriptionInitial extends InscriptionState {}

class InscriptionLoading extends InscriptionState {}

class OtpSent extends InscriptionState {
  final String phone;
  const OtpSent(this.phone);
  @override
  List<Object?> get props => [phone];
}

class OtpVerified extends InscriptionState {
  final String userId;
  const OtpVerified(this.userId);
  @override
  List<Object?> get props => [userId];
}

class ProfileCompleted extends InscriptionState {}

class InscriptionError extends InscriptionState {
  final String message;
  const InscriptionError(this.message);
  @override
  List<Object?> get props => [message];
}