class Rating {
  String comment;
  int rate;
  String userName;
  String userImage;

  Rating({
    required this.comment,
    required this.rate,
    required this.userName,
    required this.userImage,
  });

  Map<String, dynamic> toJson() {
    return {
      'comment': comment,
      'rate': rate,
      'userName': userName,
      'userImage': userImage,
    };
  }

  factory Rating.fromJson(Map<String, dynamic> json) {
    return Rating(
      comment: json['comment'] ?? '',
      rate: json['rate'] ?? 0,
      userImage: json['userImage'] ?? '',
      userName: json['userName'] ?? '',
    );
  }
}
