import 'dart:convert';

class Fact {
  String title;
  String character;
  String file;
  int id;

  Fact(this.id, this.title, this.character, this.file);

  String toJson(){
    return jsonEncode({
      'id': id,
      'title': title,
      'character': character,
      'file': file
    });
  }

  factory Fact.fromJson(Map<String, dynamic> map){
    return Fact(
      map['id'],
      map['title'],
      map['character'],
      map['file']
    );
  }
}