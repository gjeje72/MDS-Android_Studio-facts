import 'dart:convert';
import 'package:http/http.dart';
import 'package:kaamelott_facts/models/constants.dart' as globals;

import '../models/fact.dart';

class KaamelottRepository {

 KaamelottRepository();

 Future<String> getSound(String query) async {
   Response response;
   response = await get(
       Uri.parse('${globals.globalUrl}/api/KaamelottFact/facts/sound/$query'));
   if (response.statusCode == 200) {
     return response.body;
   }
   else{
     return "";
   }
 }
 Future<List<Fact>> fetchFact() async {
   Response response = await get(
         Uri.parse('${globals.globalUrl}/api/KaamelottFact/facts/all'));

   if (response.statusCode == 200) {
     List<Fact> facts = [];
     Iterable json = jsonDecode(response.body);
     List<Fact> jsonFacts = List<Fact>.from(json.map((model) => Fact.fromJson(model)));
     jsonFacts.forEach((fact) {
        facts.add(fact);
        });
     return facts;
   } else {
     throw Exception('Failed to load facts');
   }
 }
}
