import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:kaamelott_facts/repository/preference_repository.dart';
import 'package:kaamelott_facts/models/constants.dart' as globals;
import 'package:provider/provider.dart';
import '../models/fact.dart';

class Favors extends StatefulWidget {
  const Favors({Key? key}) : super(key: key);

  @override
  State<Favors> createState() => _FavorsState();
}

class _FavorsState extends State<Favors> {
  int isPlaying =  -1;
  List<Fact> favors = List<Fact>.empty();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Provider.of<PreferenceRepository>(context, listen: false).loadFavors().then((value) {
      favors = value;
      setState((){});
    });
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[300],
      appBar: AppBar(title: const Text('favoris')),
      body: favors.isNotEmpty
          ? Padding(
            padding: const EdgeInsets.all(50.0),
            child: ListView.builder(
                itemCount: favors.length,
                itemBuilder: (BuildContext context, int index){
                  return ListTile(
                      leading: IconButton(
                          icon: const Icon(Icons.star),
                          color: Colors.yellow,
                          onPressed: () async {
                            await Provider.of<PreferenceRepository>(context, listen: false).removeFavors(favors[index]);
                            favors.removeWhere((element) => element.title == favors[index].title);
                            setState(() { });
                            },
                          ),
                      title: Text(favors[index].title),
                      trailing: IconButton(
                          icon: isPlaying == index
                              ? Icon(Icons.pause_circle_filled , color: Colors.green.shade300)
                              : Icon(Icons.play_circle_fill, color: Colors.green.shade300),
                        onPressed: () async {
                          setState(() {
                            playApiSound(favors[index].file);
                            isPlaying = isPlaying == index ? -1 : index;
                          });
                        },
                      )
                    );
                }
              ),
          )
          : const Padding(
            padding: EdgeInsets.all(20),
            child: Text("No favors yet."),
          ),
    );
  }
}


