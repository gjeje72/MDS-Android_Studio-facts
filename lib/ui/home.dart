import 'package:flutter/material.dart';

import 'custom_button.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[300],
      appBar: AppBar(title: const Text('Kaamelott Facts')),
      body: Padding(
        padding: const EdgeInsets.all(50.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children:[
            CustomButton('/fact', 'Arthur', 'arthur.webp', Colors.black54),
            CustomButton('/fact', 'Merlin', 'merlin.webp', Colors.yellow.shade700),
            CustomButton('/fact', 'Léodagan', 'leodagan.webp', Colors.green.shade300),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)
                ),
              ),
              onPressed: (){
                Navigator.of(context).pushNamed('/fact',
                      arguments: { 'filter':'', }
                      );
              },
              child: const Text('Tous')
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)
                  ),
                ),
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
