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

  static Map<String, dynamic> toMap(Fact fact) => {
    'id': fact.id,
    'title': fact.title,
    'character': fact.character,
    'file': fact.file
  };

  static String encode(List<Fact> facts) => json.encode(
    facts
        .map<Map<String, dynamic>>((fact) => Fact.toMap(fact))
        .toList(),
  );

  static List<Fact> decode(String facts) =>
      (json.decode(facts) as List<dynamic>)
          .map<Fact>((item) => Fact.fromJson(item))
          .toList();
}