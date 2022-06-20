import 'package:pokedex/model/pokemon_model.dart';
import 'package:http/http.dart' as http;

class PokemonService {
  final url = 'https://pokeapi.co/api/v2/pokemon';
  final client = http.Client();
  Future<Pokemon?> getPokemon(String id) async {
    var response = await client.get(Uri.parse('$url/$id'));
    if (response.statusCode == 200) {
      // print(response.body);
      return pokemonFromJson(response.body);
    }
  }
}
