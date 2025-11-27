import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:telead/features/auth/presentation/cubit/auth_state.dart';

import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/i_auth_repository.dart';

class AuthCubit extends Cubit<AuthState> {
  final IAuthRepository repository;
  UserEntity? currentUser;

  AuthCubit(this.repository) : super(AuthInitial());

  Future<void> signIn(String email, String password) async {
    emit(AuthLoading());
    try {
      final user = await repository.signIn(email, password);
      currentUser = user;
      emit(AuthAuthenticated(user, "signIn"));
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  Future<void> signUpWithData({
    required String email,
    required String password,
    required String firstName,
    required String secondName,
    required String phone,
    String? jobTitle,
    String? userImage,
  }) async {
    emit(AuthLoading());
    try {
      final user = await repository.signUpWithData(
        email: email,
        password: password,
        firstName: firstName,
        secondName: secondName,
        phone: phone,
        jobTitle: jobTitle,
        userImage: userImage,
      );
      currentUser = user;
      emit(AuthAuthenticated(user, "signUp"));
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  Future<void> loadCurrentUser() async {
    emit(AuthLoading());
    try {
      final user = await repository.getCurrentUser();
      if (user != null) {
        currentUser = user;
        log("$currentUser");
        emit(AuthAuthenticated(user, "signIn"));
      } else {
        emit(AuthSignedOut());
      }
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  Future<void> signOut() async {
    try {
      await repository.signOut();
      currentUser = null;
      emit(AuthSignedOut());
    } catch (e) {
      emit(AuthFailure("Sign out failed: ${e.toString()}"));
    }
  }
}
