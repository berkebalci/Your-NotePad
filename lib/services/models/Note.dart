class Note {
  String title;
  String content;
  String noteUID;

  Note({required this.title, required this.content,required this.noteUID});

  Map<String, dynamic> toJson() {
    return {'title': title, 'content': content,'noteUID':noteUID};
  }

  static Note fromJson(Map<String, dynamic>? json) {
    if (json != null) {
      return Note(
        title: json['title'],
        content: json['content'], 
        noteUID: json['noteUID'] //TODO: FireStore'a ve uygulamanın geri kalanına bu değişkeni ekle 
      );
    }
    throw Exception("Json is null");
  }
}
