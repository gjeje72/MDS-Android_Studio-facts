import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:kaamelott_facts/repository/preference_repository.dart';
import 'package:kaamelott_facts/models/constants.dart' as globals;
import 'package:shared_preferences/shared_preferences.dart';

import '../blocs/fact_cubit.dart';
import '../models/fact.dart';

class Favors extends StatefulWidget {
  const Favors({Key? key}) : super(key: key);

  @override
  State<Favors> createState() => _FavorsState();
}

class _FavorsState extends State<Favors> {
  final PreferenceRepository _preferenceRepository = PreferenceRepository();
  List<Fact> favors = List<Fact>.empty();

  @override
  void initState() {
    super.initState();
    }

  Future<void> getPrefs() async {
    _preferenceRepository.loadFavors().then((value) {
      favors = value;
      setState((){});
    });
  }

  Future<void> initializePreference() async{
    var prefs = await SharedPreferences.getInstance();
  }

  Future<int> playApiSound(String fileName) async{
    AudioPlayer audioPlayer = AudioPlayer();
    await audioPlayer.setUrl("${globals.globalUrl}:10448/api/KaamelottFact/facts/sound/$fileName"); // prepare the player with this audio but do not start playing
    await audioPlayer.play();
    return 1;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('favoris')),
      body: favors.isNotEmpty
          ? ListView.builder(
              itemCount: favors.length,
              itemBuilder: (BuildContext context, int index){
                return ListTile(
                    leading: IconButton(
                        icon: const Icon(Icons.star),
                        onPressed: () => {
                          _preferenceRepository.saveNewFavors(favors[index])
                          },
                        ),
                    title: Text(favors[index].title),
                    trailing: IconButton(
                        icon: const Icon(Icons.play_circle_fill, color: Colors.green),
                        onPressed: () async => { await playApiSound(favors[index].file) },
                    )
                  );
              }
            )
          : FloatingActionButton(onPressed: () async => await getPrefs()),
    );
  }
}


