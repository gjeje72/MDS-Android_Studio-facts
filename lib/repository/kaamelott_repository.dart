import 'dart:convert';
import 'package:http/http.dart';

import '../models/fact.dart';

class KaamelottRepository {
 KaamelottRepository();

 Future<List<Fact>> fetchFact(String query) async {
   Response response;
   if (query == '') {
     response = await get(
         Uri.parse('http://172.20.10.11:10448/api/KaamelottFact'));
   }
   else {
     response = await get(
         Uri.parse('http://172.20.10.11:10448/api/KaamelottFact/facts/$query'));
   }

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
