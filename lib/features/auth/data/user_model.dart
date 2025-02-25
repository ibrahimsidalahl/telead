class UserModel {
  List<String>? created_courses;
  List<String>? enrolled_courses;
  String first_name;
  String? user_image;
  String phone;
  String role;
  String? job_title;
  String second_name;
  String email;

  UserModel({
    required this.email,
    this.created_courses, // Nullable
    this.enrolled_courses,
     this.job_title,// Nullable
    required this.first_name,
   required this.user_image, // Nullable
    required this.phone,
    required this.role,
    required this.second_name,
  });

  // Factory constructor to create a UserModel from a Map
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      created_courses: List<String>.from(json['created_courses'] ?? []),
      enrolled_courses: List<String>.from(json['enrolled_courses'] ?? []),
      first_name: json['frist_name'] as String, // correct the field name if needed
      email: json['email'] as String, // correct the field name if needed
      user_image: json['user_image'] as String?, // Handle nullable image_url
      phone: json['phone'] as String,
      job_title:json['job_title'] as String,
      role: json['role'] as String,
      second_name: json['second_name'] as String,
    );
  }

  // Method to convert UserModel to a Map
  Map<String, dynamic> toJson() {
    return {
      'created_courses': created_courses ?? [], // Default empty list if null
      'enrolled_courses': enrolled_courses ?? [], // Default empty list if null
      'frist_name': first_name,
      'user_image': user_image,
      'phone': phone,
      'role': role,
      'email': email,
      'job_title':job_title,
      'second_name': second_name,
    };
  }
}
