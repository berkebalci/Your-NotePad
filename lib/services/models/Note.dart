class Note {
  String title;
  String content;
  
  Note({required this.title, required this.content,});

  Map<String, dynamic> toJson() {
    return {'title': title, 'content': content,};
  }

  static Note fromJson(Map<String, dynamic>? json) {
    if (json != null) {
      return Note(
        title: json['title'],
        content: json['content'], 
         //TODO: FireStore'a ve uygulamanın geri kalanına bu değişkeni ekle 
      );
    }
    throw Exception("Json is null");
  }
}
