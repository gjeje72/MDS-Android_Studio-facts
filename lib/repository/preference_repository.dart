import 'package:shared_preferences/shared_preferences.dart';

import '../models/fact.dart';

class PreferenceRepository {

  Future<void> saveNewFavors(Fact fact) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var facts = await loadFavors();
    facts.add(fact);
    final String encodedData = Fact.encode(facts);
    await prefs.setString('favors', encodedData);
  }

  Future<List<Fact>> loadFavors() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var factsString = prefs.getString('favors');
    if(factsString != null){
      final List<Fact> facts = Fact.decode(factsString);
      return facts;
    }
    return List<Fact>.empty(growable: true);
  }

  Future<void> removeFavors(Fact fact) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var facts = await loadFavors();
    facts.removeWhere((element) => element.title == fact.title);
    final String encodedData = Fact.encode(facts);
    await prefs.setString('favors', encodedData);
  }
}