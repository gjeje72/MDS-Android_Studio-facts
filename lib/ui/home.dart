import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Kaamelott Facts')),
      body: Padding(
        padding: const EdgeInsets.all(50.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children:[
              ElevatedButton(
                  onPressed: (){
                    Navigator.of(context).pushNamed(
                        '/fact',
                        arguments:{
                          'filter':'Arthur',
                        });
                  },
                  child: const Text('Arthur')
              ),
           ElevatedButton(
               onPressed: (){
                 Navigator.of(context).pushNamed(
                     '/fact',
                     arguments:{
                       'filter':'Merlin',
                     });
               },
                  child: const Text('Merlin')
              ),
            ElevatedButton(
                onPressed: (){
                  Navigator.of(context).pushNamed(
                      '/fact',
                      arguments:{
                        'filter':'Léodagan',
                      });
                },
                  child: const Text('Léodagan')
              ),
            ElevatedButton(
                onPressed: (){
                  Navigator.of(context).pushNamed(
                      '/fact',
                      arguments:{
                        'filter':'',
                      });
                },
                  child: const Text('Aléatoire')
              ),
            ElevatedButton(
                  onPressed: (){
                    Navigator.of(context).pushNamed('/favors');
                  },
                  child: const Text('Favoris')
              ),
          ]
        ),
      )
    );
  }
}
