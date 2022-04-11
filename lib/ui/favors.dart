import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:kaamelott_facts/blocs/fact_cubit.dart';
import 'package:kaamelott_facts/repository/preference_repository.dart';
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
  late List<String>? favors;

  @override
  void initState() {
    super.initState();
    _preferenceRepository.loadFavorsId().whenComplete(() =>
        setState((){}));
  }

  Future<void> initializePreference() async{
    var prefs = await SharedPreferences.getInstance();
  }

  Future<int> playApiSound(String fileName) async{
    AudioPlayer audioPlayer = AudioPlayer();
    await audioPlayer.setUrl("http://192.168.1.20:10448/api/KaamelottFact/facts/sound/$fileName"); // prepare the player with this audio but do not start playing
    await audioPlayer.play();
    return 1;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<FactCubit, List<Fact>>(
          builder: (context, state){
            state = state.where((e) => favors?.contains(e.id.toString()) ?? false).toList();
            return Expanded(
              child: ListView.separated(
                itemCount: state.length,
                itemBuilder: (BuildContext context, int index){
                  Fact fact = state[index];
                  return ListTile(
                    leading: IconButton(
                      icon: const Icon(Icons.star),
                      onPressed: () => {
                        _preferenceRepository.saveFavorsId(fact.id)
                      },
                    ),
                    title: Text(fact.title),
                    trailing: IconButton(
                      icon: const Icon(Icons.play_circle_fill, color: Colors.green),
                      onPressed: () async => { await playApiSound(fact.title) },
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index){
                  return const Divider(
                    height: 0,
                  );
                },
              ),
            );
          }),
    );
  }
}
