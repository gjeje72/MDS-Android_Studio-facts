import 'package:shared_preferences/shared_preferences.dart';

class PreferenceRepository {
  Future<void> saveFavorsId(int favorId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var favorsId = await loadFavorsId() ?? List<String>.empty();
    favorsId.add(favorId.toString());
    prefs.setStringList('favors', favorsId);
  }

  Future<List<String>?> loadFavorsId() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getStringList('favors');
  }
}