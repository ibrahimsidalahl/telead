class LessonsModel {
  String title;
  String video_url;
  String pdf_url;

  LessonsModel({
    required this.title,
    required this.video_url,
    required this.pdf_url,
  });

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'video_url': video_url,
      'pdf_url': pdf_url,
    };
  }

  factory LessonsModel.fromJson(Map<String, dynamic> json) {
    return LessonsModel(
      title: json['title'] ?? '',
      video_url: json['video_url'] ?? '',
      pdf_url: json['pdf_url'] ?? '',
    );
  }
}
