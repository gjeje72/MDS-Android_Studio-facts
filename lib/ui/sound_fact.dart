import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kaamelott_facts/blocs/fact_cubit.dart';
import 'package:just_audio/just_audio.dart';
import 'package:kaamelott_facts/repository/preference_repository.dart';
import 'package:kaamelott_facts/models/constants.dart' as globals;
import 'package:provider/provider.dart';
import '../models/fact.dart';

class SoundFact extends StatefulWidget {
  const SoundFact({Key? key}) : super(key: key);

  @override
  State<SoundFact> createState() => _SoundFactState();
}

class _SoundFactState extends State<SoundFact> {
  int isPlaying =  -1;
  List<Fact> favors = List<Fact>.empty();

  @override
  void initState() {
    super.initState();
    Provider.of<PreferenceRepository>(context, listen: false).loadFavors().then((value) {
      favors = value;
      setState((){});
    });
  }

  Widget build(BuildContext context) {
    final Map<String, dynamic> args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    final String filter = args['filter'];
    final String title = filter != '' ? filter : 'Tous';
    return Scaffold(
        backgroundColor: Colors.brown[300],
        appBar: AppBar(title: Text(title), backgroundColor: Colors.brown),
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
                                textColor: Colors.brown.shade50,
                                leading:
                                favors.any((e) => fact.title == e.title)
                                    ? IconButton(
                                      onPressed: () async {
                                        await Provider.of<PreferenceRepository>(context, listen: false).removeFavors(fact);
                                        favors.removeWhere((element) => element.title == fact.title);
                                        setState(() { });
                                      },
                                      color: Colors.yellow.shade300,
                                      icon: const Icon(Icons.star))
                                    : IconButton(
                                      color: Colors.yellow.shade300,
                                      icon: const Icon(Icons.star_border_outlined),
                                      onPressed: () async {
                                        await Provider.of<PreferenceRepository>(context, listen: false).saveNewFavors(fact);
                                        setState(() {
                                          favors.add(fact);
                                        });
                                      },
                                    ),
                                title: Text(fact.title),
                                trailing: IconButton(
                                  icon: isPlaying == index
                                      ? Icon(Icons.pause_circle_filled , color: Colors.green.shade100)
                                      : Icon(Icons.play_circle_fill, color: Colors.green.shade300),
                                  onPressed: () async {
                                    setState(() {
                                      playApiSound(fact.file);
                                      isPlaying = isPlaying == index ? -1 : index;
                                    });
                                  },
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

  Future<int> playApiSound(String fileName) async{
    AudioPlayer audioPlayer = AudioPlayer();
    await audioPlayer.setUrl("${globals.globalUrl}/api/KaamelottFact/facts/sound/$fileName"); // prepare the player with this audio but do not start playing
    await audioPlayer.play();
    setState(() {
      isPlaying = -1;
    });
    return 1;
  }
}
