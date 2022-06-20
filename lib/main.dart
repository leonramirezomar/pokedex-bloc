import 'package:flutter/material.dart';
import 'package:pokedex/model/pokemon_model.dart';
import 'package:pokedex/pages/login_page.dart';
import 'package:pokedex/pages/pokedexPage.dart';
import 'package:pokedex/pages/pokemon_details_page.dart';
import 'package:pokedex/pages/team_selector.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pokedex',
      debugShowCheckedModeBanner: false,
      initialRoute: 'home',
      routes: {
        'home': (_) => LoginPage(),
        'pokedex': (_) => PokedexPage(),
        'selectedTeam': (_) => TeamSelector(),
      },
    );
  }
}
