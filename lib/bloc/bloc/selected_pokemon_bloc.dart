import 'dart:async';

import 'package:pokedex/model/pokemon_model.dart';

class SelectedPokemonBloc {
  bool selected = false;
  List<Pokemon> listPokemon = [];
  List<List<Pokemon>> listTeam = [];
  int counter = 0;

  final selectedStreamController = StreamController<bool>();

  change() {
    if (selected) {
      selected = false;
    } else {
      selected = true;
    }
  }

  addPokemon(Pokemon pokemon) {
    int index =
        listPokemon.indexWhere((pokemonList) => pokemonList.id == pokemon.id);
    if (index == -1) {
      if (listPokemon.length <= 6) {
        listPokemon.add(pokemon);
        counter = listPokemon.length;
      } else {
        listTeam.add(listPokemon);
        counter = listPokemon.length;
      }
    }
  }

  removePokemon(Pokemon pokemon) {
    listPokemon.removeWhere((pokemonList) => pokemonList.id == pokemon.id);

    counter = listPokemon.length;
  }
}
