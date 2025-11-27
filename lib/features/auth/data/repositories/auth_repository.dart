import '../../domain/repositories/i_auth_repository.dart';
import '../../domain/entities/user_entity.dart';
import '../data_sources/firebase_auth_service.dart';
import '../models/user_model.dart';

class AuthRepository implements IAuthRepository {
  final FirebaseAuthService _service;
  AuthRepository(this._service);

  @override
  Future<UserEntity> signIn(String email, String password) async {
    final user = await _service.signIn(email: email, password: password);
    return user; // UserModel extends UserEntity
  }

  @override
  Future<UserEntity> signUp(String email, String password) async {
    throw UnimplementedError(
        "Use the overloaded method with extra fields for signup.");
  }

  Future<UserEntity> signUpWithData({
    required String email,
    required String password,
    required String firstName,
    required String secondName,
    required String phone,
    String? jobTitle,
    String? userImage,
  }) async {
    final user = await _service.signUp(
      email: email,
      password: password,
      firstName: firstName,
      secondName: secondName,
      phone: phone,
      jobTitle: jobTitle,
      userImage: userImage,
    );
    return user;
  }
  @override
  Future<UserEntity?> getCurrentUser() async {
    final user = await _service.getCurrentUser();
    return user;
  }
  @override
  Future<void> signOut() async => await _service.signOut();
}
