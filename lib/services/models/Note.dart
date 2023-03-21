class Note {
  String title;
  String content;
  String userUID;
  Note({required this.title, required this.content, required this.userUID});

  Map<String, dynamic> toJson() {
    return {'title': title, 'content': content, 'userUID': userUID};
  }

  static Note fromJson(Map<String, dynamic>? json) {
    if (json != null) {
      return Note(
          title: json['title'],
          content: json['content'],
          userUID: json['userUID']);
    }
    throw Exception("Json is null");
  }
}
