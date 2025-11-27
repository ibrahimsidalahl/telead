import '../entities/user_entity.dart';

abstract class IAuthRepository {
  Future<UserEntity> signIn(String email, String password);
  Future<UserEntity> signUp(String email, String password);

  Future<UserEntity> signUpWithData({
    required String email,
    required String password,
    required String firstName,
    required String secondName,
    required String phone,
    String? jobTitle,
    String? userImage,
  });

  Future<UserEntity?> getCurrentUser();
  Future<void> signOut();
}
