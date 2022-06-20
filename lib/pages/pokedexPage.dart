import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pokedex/bloc/bloc/pokemon_bloc.dart';
import 'package:pokedex/model/pokemon_model.dart';
import 'package:pokedex/pages/pokemon_details_page.dart';
import 'package:pokedex/pages/team_selector.dart';
import 'package:pokedex/utilities/colors.dart';
import 'package:pokedex/utilities/responsive.dart';

class PokedexPage extends StatefulWidget {
  @override
  State<PokedexPage> createState() => _PokedexPageState();
}

class _PokedexPageState extends State<PokedexPage> {
  final PokemonBloc pokemonBloc = PokemonBloc();

  @override
  void dispose() {
    // TODO: implement dispose
    pokemonBloc.dispose();
    super.dispose();
  }

  void traerPokemon() async {
    await pokemonBloc.fetchPokemon();
    pokemonBloc.pokemonListStreamController.sink.add(pokemonBloc.pokemonList);
    await pokemonBloc.getUser();
    pokemonBloc.userStreamController.sink.add(pokemonBloc.name);
  }

  @override
  void initState() {
    traerPokemon();

    super.initState();
  }

  // void dispose() {
  @override
  Widget build(BuildContext context) {
    Responsive responsive = Responsive.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[50],
        elevation: 0,
        title: Container(
          alignment: Alignment.topLeft,
          child: StreamBuilder(
            stream: pokemonBloc.userStreamController.stream,
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              return Text(
                ' ${pokemonBloc.name}',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: responsive.diagonalPercentage(1.8),
                ),
              );
            },
          ),
        ),
        actions: [
          Image.asset(
            'assets/pokeball.png',
            // 'assets/icon-pokeball.png',
          ),
        ],
      ),
      floatingActionButton: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TeamSelector(
                listPokemon: pokemonBloc.pokemonList,
              ),
            ),
          );
        },
        child: CircleAvatar(
          backgroundColor: Colors.orange,
          radius: responsive.diagonalPercentage(5),
          child: Container(
            padding: EdgeInsets.all(
              responsive.diagonalPercentage(1),
            ),
            child: Image.asset('assets/backpack.png'),
          ),
        ),
      ),
      backgroundColor: Colors.grey[50],
      body: StreamBuilder(
        stream: pokemonBloc.pokemonListStreamController.stream,
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (!snapshot.hasData) {
            return Center(child: LoadingWidget(responsive: responsive));
          } else {
            return _listOfPokemon(context, snapshot.data);
          }
        },
      ),
    );
  }

  Widget _listOfPokemon(context, List<Pokemon> pokemonList) {
    Responsive responsive = Responsive.of(context);
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: responsive.widthPercentage(3),
        vertical: responsive.heightPercentage(2),
      ),
      width: double.infinity,
      height: double.infinity,
      child: Container(
        // width: responsive.widthPercentage(100),
        // height: responsive.heightPercentage(20),
        color: Colors.grey[200],
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1,
            crossAxisSpacing: 10,
            mainAxisSpacing: 5,
          ),
          itemCount: pokemonList.length,
          itemBuilder: (context, index) {
            return _cardOfPokemon(context, pokemonList[index]);
          },
        ),
      ),
    );
  }

  Widget _cardOfPokemon(context, Pokemon pokemon) {
    Responsive responsive = Responsive.of(context);
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PokemonDetailsPage(
            pokemon: pokemon,
            background: choiceColor('${pokemon.types![0].type!.name}'),
          ),
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: choiceColor('${pokemon.types![0].type!.name}'),
        ),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.bottomRight,
              child: Image.asset(
                'assets/pokeball.png',
                alignment: Alignment.bottomRight,
                height: responsive.heightPercentage(12),
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Container(
                width: responsive.widthPercentage(20),
                height: responsive.heightPercentage(20),
                alignment: Alignment.bottomCenter,
                margin: EdgeInsets.only(
                  right: responsive.widthPercentage(2),
                  bottom: responsive.heightPercentage(2),
                ),
                child: SvgPicture.network(
                  '${pokemon.sprites!.other!.dreamWorld!.frontDefault}',
                  height: responsive.heightPercentage(8),
                  width: responsive.widthPercentage(8),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                top: responsive.heightPercentage(3),
                left: responsive.widthPercentage(2),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${pokemon.name}',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: responsive.diagonalPercentage(2),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Expanded(
                    child: Container(
                      width: responsive.widthPercentage(20),
                      margin: EdgeInsets.only(
                        bottom: responsive.heightPercentage(2),
                      ),
                      // type
                      child: ListView.builder(
                          itemCount: pokemon.types!.length,
                          itemBuilder: (context, index) {
                            return _containerType(
                                context, '${pokemon.types![index].type!.name}');
                          }),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _containerType(context, String type) {
    Responsive responsive = Responsive.of(context);
    return Container(
      margin: EdgeInsets.only(
        top: responsive.heightPercentage(1),
        bottom: responsive.heightPercentage(0.5),
      ),
      decoration: BoxDecoration(
        color: Colors.white70.withOpacity(0.4),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        type,
        style: TextStyle(
          color: Colors.black,
          fontSize: responsive.diagonalPercentage(1.6),
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.center,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}

Color choiceColor(String type) {
  Color color;
  switch (type) {
    case "fire":
      color = fire;
      break;
    case "grass":
      color = grass;
      break;
    case "electric":
      color = electric;
      break;
    case "water":
      color = water;
      break;
    case "ground":
      color = ground;
      break;
    case "rock":
      color = rock;
      break;
    case "fairy":
      color = fairy;
      break;
    case "normal":
      color = normal;
      break;
    case "poison":
      color = poison;
      break;
    case "bug":
      color = bug;
      break;
    case "dragon":
      color = dragon;
      break;
    case "psychic":
      color = psychic;
      break;
    case "flying":
      color = flying;
      break;
    case "fighting":
      color = fighting;
      break;
    default:
      color = noColor;
  }
  return color;
}

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({
    Key? key,
    required this.responsive,
  }) : super(key: key);

  final Responsive responsive;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: responsive.heightPercentage(30),
      margin: EdgeInsets.symmetric(
        horizontal: responsive.widthPercentage(8),
      ),
      child: Column(
        children: [
          Text('Cargando Pokemons'),
          Expanded(child: Image.asset('assets/pokemon-pokeball.gif'))
        ],
      ),
    );
  }
}
