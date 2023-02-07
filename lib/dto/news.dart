class News {
  final int userId;
  final int id;
  final String title;
  final String body;

  News(this.userId, this.id, this.title, this.body);

  factory News.fromJson(Map<String, dynamic> json) {
    return News(
      json['userId'],
      json['id'],
      json['title'],
      json['body'],
    );
  }
}