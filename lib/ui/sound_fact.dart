import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kaamelott_facts/blocs/fact_cubit.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:kaamelott_facts/repository/preference_repository.dart';

import '../models/fact.dart';

class SoundFact extends StatelessWidget {
  const SoundFact({Key? key}) : super(key: key);

  Future<AudioPlayer> playLocalAsset(String file) async {
    AudioCache cache = AudioCache();
    //At the next line, DO NOT pass the entire reference such as assets/yes.mp3. This will not work.
    //Just pass the file name only.
    return await cache.play(file);
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    final String filter = args['filter'];
    final String title = filter != '' ? filter : 'Aléatoire';
    final PreferenceRepository _preferenceRepository = PreferenceRepository();
    return Scaffold(
        appBar: AppBar(title: Text(title)),
        body: Padding(
          padding: const EdgeInsets.all(50.0),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                BlocBuilder<FactCubit, List<Fact>>(
                    builder: (context, state){
                      state = state.where((e) => e.character == filter).toList();
                      return Expanded(
                        child: ListView.separated(
                            itemCount: state.length,
                            itemBuilder: (BuildContext context, int index){
                              Fact fact = state[index];
                              return ListTile(
                                leading: IconButton(
                                  icon: const Icon(Icons.star_border_outlined),
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
                ElevatedButton(
                    onPressed: (){
                    },
                    child: const Text('▶')
                ),
                ElevatedButton(
                    onPressed: (){
                    },
                    child: const Text('New')
                ),
                ElevatedButton(
                    onPressed: (){
                    },
                    child: const Text('⭐')
                ),
              ]
          ),
        )
    );
  }
}
