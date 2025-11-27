class JoinedCoursesModel {
  final String path;
  final bool active;

  JoinedCoursesModel({
    required this.path,
    required this.active,
  });

  factory JoinedCoursesModel.fromJson(Map<String, dynamic> json) {
    return JoinedCoursesModel(
      path: json['path'] ?? '',
      active: json['active'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'path': path,
      'active': active,
    };
  }
}
