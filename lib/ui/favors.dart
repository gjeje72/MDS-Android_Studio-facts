import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kaamelott_facts/blocs/fact_cubit.dart';
import 'package:kaamelott_facts/repository/preference_repository.dart';

import '../blocs/fact_cubit.dart';
import '../models/fact.dart';

class Favors extends StatefulWidget {
  const Favors({Key? key}) : super(key: key);

  @override
  State<Favors> createState() => _FavorsState();

}

class _FavorsState extends State<Favors> {
  final PreferenceRepository _preferenceRepository = PreferenceRepository();
  late final List<String>? favors;
  @override

  void initState() {
    _preferenceRepository.loadFavorsId().then((value) =>
        setState((){favors = value;}));
    super.initState();
  }

  Future<AudioPlayer> playLocalAsset(String file) async {
    AudioCache cache = AudioCache();
    //At the next line, DO NOT pass the entire reference such as assets/yes.mp3. This will not work.
    //Just pass the file name only.
    return await cache.play(file);
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
                      onPressed: () async => { await playLocalAsset(fact.file) },
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
