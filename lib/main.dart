import 'package:flutter/material.dart';
import 'package:kaamelott_facts/repository/kaamelott_repository.dart';
import 'package:kaamelott_facts/repository/preference_repository.dart';
import 'package:kaamelott_facts/ui/favors.dart';
import 'package:kaamelott_facts/ui/home.dart';
import 'package:kaamelott_facts/ui/sound_fact.dart';
import 'package:provider/provider.dart';

import 'blocs/fact_cubit.dart';

void main() {
  final PreferenceRepository preferenceRepository = PreferenceRepository();
  final KaamelottRepository kaamelottRepository = KaamelottRepository();
  final FactCubit factCubit = FactCubit(kaamelottRepository);

  factCubit.loadFacts();

  runApp(
      MultiProvider(
        providers: [
          Provider<FactCubit>(create: (_) => factCubit),
          Provider<KaamelottRepository>(create: (_) => kaamelottRepository),
          Provider<PreferenceRepository>(create: (_) => preferenceRepository),
        ],
        child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Kaamelott',
      theme: ThemeData(
        primarySwatch: Colors.brown,
      ),
      routes: {
        '/home': (context) => Home(),
        '/fact': (context) => SoundFact(),
        '/favors': (context) => Favors(),
      },
      home: const Home(),
    );
  }
}
