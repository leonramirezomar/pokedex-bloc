import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pokedex/bloc/bloc/selected_pokemon_bloc.dart';
import 'package:pokedex/model/pokemon_model.dart';
import 'package:pokedex/pages/pokemon_details_page.dart';
import 'package:pokedex/utilities/colors.dart';
import 'package:pokedex/utilities/responsive.dart';

class TeamSelector extends StatefulWidget {
  final List<Pokemon>? listPokemon;
  TeamSelector({Key? key, @required this.listPokemon}) : super(key: key);

  @override
  State<TeamSelector> createState() => _TeamSelectorState();
}

class _TeamSelectorState extends State<TeamSelector> {
  SelectedPokemonBloc selectPokemonBloc = SelectedPokemonBloc();
//   @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          alignment: Alignment.topCenter,
          width: double.infinity,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
          ),
          child: DefaultTabController(
            length: 2,
            child: Column(
              children: [
                const TabBar(
                  labelColor: Colors.black,
                  unselectedLabelColor: Colors.grey,
                  tabs: [
                    Tab(text: 'Selected Pokemon'),
                    Tab(text: 'Teams'),
                    // Tab(text: 'About'),
                  ],
                ),
                Expanded(
                  child: TabBarView(
                    children: [
                      _selectedPokemon(context),
                      _teams(context),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _selectedPokemon(context) {
    // final SelectedPokemonBloc selectPokemonBloc = SelectedPokemonBloc();
    final Responsive responsive = Responsive.of(context);
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
          itemCount: widget.listPokemon!.length,
          itemBuilder: (context, index) {
            if (!selectPokemonBloc.selected) {
              selectPokemonBloc.change();
            } else {
              selectPokemonBloc.change();
            }
            return _cardOfPokemon(context, widget.listPokemon![index], index);
            // return _cardOfPokemon(context, widget.listPokemon![index], index);
          },
        ),
      ),
    );
  }

  Widget _cardOfPokemon(context, Pokemon pokemon, index) {
    Responsive responsive = Responsive.of(context);
    IconData icon;
    int counter = 0;

    final SelectedPokemonBloc selectPokemonBloc = SelectedPokemonBloc();
    return GestureDetector(
      onTap: () => selectPokemonBloc.selectedStreamController.sink
          .add(selectPokemonBloc.selected),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: choiceColor('${pokemon.types![0].type!.name}'),
        ),
        child: Stack(
          children: [
            // Text(selectPokemonBloc.selected.toString()),
            StreamBuilder(
              stream: selectPokemonBloc.selectedStreamController.stream,
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                selectPokemonBloc.change();
                IconData icon = Icons.check_box_outline_blank;
                // print(selectPokemonBloc.counter);
                if (snapshot.data != null) {
                  switch (snapshot.data) {
                    case false:
                      icon = Icons.check_box_outline_blank;
                      selectPokemonBloc.removePokemon(pokemon);

                      break;
                    case true:
                      icon = Icons.check_circle_rounded;
                      selectPokemonBloc.addPokemon(pokemon);

                      break;

                    default:
                      icon = Icons.check_box_outline_blank;
                      break;
                  }
                }
                // print(selectPokemonBloc.counter);
                print(selectPokemonBloc.listPokemon.length);
                return Icon(icon);
              },
            ),

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

  Widget _teams(context) {
    Responsive responsive = Responsive.of(context);
    return Container();
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
}
