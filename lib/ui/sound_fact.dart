import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kaamelott_facts/blocs/fact_cubit.dart';
import 'package:just_audio/just_audio.dart';
import 'package:kaamelott_facts/repository/preference_repository.dart';
import 'package:kaamelott_facts/models/constants.dart' as globals;
import '../models/fact.dart';

class SoundFact extends StatelessWidget {
  const SoundFact({Key? key}) : super(key: key);

  Future<int> playApiSound(String fileName) async{
    AudioPlayer audioPlayer = AudioPlayer();
    await audioPlayer.setUrl("${globals.globalUrl}:10448/api/KaamelottFact/facts/sound/$fileName"); // prepare the player with this audio but do not start playing
    await audioPlayer.play();
    return 1;
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    final String filter = args['filter'];
    final String title = filter != '' ? filter : 'Tous';
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
                      state = state.where((e) => e.character.contains(filter)).toList();
                      return Expanded(
                        child: ListView.separated(
                            itemCount: state.length,
                            itemBuilder: (BuildContext context, int index){
                              Fact fact = state[index];
                              return ListTile(
                                leading: IconButton(
                                  icon: const Icon(Icons.star_border_outlined),
                                  onPressed: () => {
                                    _preferenceRepository.saveNewFavors(fact)
                                  },
                                ),
                                title: Text(fact.title),
                                trailing: IconButton(
                                  icon: const Icon(Icons.play_circle_fill, color: Colors.green),
                                  onPressed: () async => { await playApiSound(fact.file) },
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
              ]
          ),
        )
    );
  }
}
