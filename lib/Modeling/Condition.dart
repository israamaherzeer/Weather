class Condition {
  String ConitionText;
  String img;
  Condition({
    required this.ConitionText,
    required this.img,
  });
  factory Condition.fromJson(dynamic json) {
    return Condition(
      ConitionText: json['text'],
      img: json['icon'],
    );
  }

}