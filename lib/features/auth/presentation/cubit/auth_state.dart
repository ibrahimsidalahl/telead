import '../../domain/entities/user_entity.dart';

abstract class AuthState {}

class AuthInitial extends AuthState {}
class AuthLoading extends AuthState {}
class AuthAuthenticated extends AuthState {
  final UserEntity user;
  final String source; // "signIn" أو "signUp"

  AuthAuthenticated(this.user , this.source);
}
class AuthSignedOut extends AuthState {}
class AuthFailure extends AuthState {
  final String message;
  AuthFailure(this.message);
}
