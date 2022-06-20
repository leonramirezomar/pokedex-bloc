import 'dart:async';

import 'package:pokedex/model/pokemon_model.dart';
import 'package:pokedex/services/pokemon_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PokemonBloc {
  // Crear una lista de tipo Pokemon (modelo)
  final List<Pokemon> pokemonList = [];
  String name = '';

  PokemonService service = PokemonService();

  final pokemonListStreamController = StreamController<List<Pokemon>>();
  final userStreamController = StreamController<String>();

  fetchPokemon() async {
    try {
      for (int i = 1; i < 151; i++) {
        var result = await service.getPokemon('$i');

        pokemonList.add(result!);
      }
    } catch (e) {
      print(e);
    }
  }

  void dispose() {
    pokemonListStreamController.close();
  }

  getUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    name = 'Bienvenida/o ' + prefs.getString('user').toString();
  }
}
