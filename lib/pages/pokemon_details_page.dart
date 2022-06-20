import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pokedex/model/pokemon_model.dart';
import 'package:pokedex/utilities/colors.dart';
import 'package:pokedex/utilities/responsive.dart';

class PokemonDetailsPage extends StatelessWidget {
  final Pokemon? pokemon;
  final Color? background;
  const PokemonDetailsPage(
      {Key? key, @required this.pokemon, @required this.background})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Responsive responsive = Responsive.of(context);
    return Scaffold(
      backgroundColor: background,
      body: Stack(
        children: [
          Container(
            alignment: Alignment.centerRight,
            margin: EdgeInsets.symmetric(
              horizontal: responsive.widthPercentage(12),
            ),
            height: double.infinity,
            width: responsive.widthPercentage(100),
            child: Image.asset(
              'assets/pokeball.png',
              alignment: Alignment.topRight,
              width: responsive.widthPercentage(50),
              height: responsive.heightPercentage(50),
            ),
          ),
          _buttonReturn(context),
          Container(
            margin: EdgeInsets.only(
              top: responsive.heightPercentage(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _nameOfPokemon(context),
                _typeOfPokemon(context),
                _containerImgPokemon(context),
                _containerTabDetailsPokemon(context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buttonReturn(context) {
    Responsive responsive = Responsive.of(context);
    return SafeArea(
      child: Container(
        margin: EdgeInsets.only(
          left: responsive.widthPercentage(3),
        ),
        child: IconButton(
          onPressed: () => Navigator.pop(context, 'home'),
          icon: const Icon(
            Icons.arrow_back_ios_rounded,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _nameOfPokemon(context) {
    Responsive responsive = Responsive.of(context);
    return SafeArea(
      child: Container(
        margin: EdgeInsets.symmetric(
          horizontal: responsive.widthPercentage(8),
        ),
        child: Text(
          pokemon!.name.toString(),
          style: TextStyle(
              color: Colors.white,
              fontSize: responsive.diagonalPercentage(2.8),
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _typeOfPokemon(context) {
    Responsive responsive = Responsive.of(context);
    return Container(
      width: double.infinity,
      // color: Colors.blueAccent,
      margin: EdgeInsets.only(
        top: responsive.heightPercentage(2),
        bottom: responsive.heightPercentage(3),
        left: responsive.widthPercentage(8),
        right: responsive.widthPercentage(8),
      ),
      height: responsive.heightPercentage(5),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: pokemon!.types!.length,
        itemBuilder: (context, index) {
          return _containerType(
            context,
            index,
          );
        },
      ),
    );
  }

  Widget _containerType(context, index) {
    Responsive responsive = Responsive.of(context);
    return Container(
      margin: EdgeInsets.only(
        left: 0,
        right: responsive.widthPercentage(2),
      ),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(30),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: responsive.widthPercentage(2),
        vertical: responsive.heightPercentage(1),
      ),
      child: Text(
        '${pokemon!.types![index].type!.name}',
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _containerImgPokemon(context) {
    Responsive responsive = Responsive.of(context);
    return SizedBox(
      width: double.infinity,
      height: responsive.heightPercentage(20),
      // margin: EdgeInsets.only(
      //   bottom: responsive.widthPercentage(8),
      // ),
      child: SvgPicture.network(
        '${pokemon!.sprites!.other!.dreamWorld!.frontDefault}',
        height: responsive.heightPercentage(8),
        width: responsive.widthPercentage(8),
        alignment: Alignment.center,
      ),
    );
  }

  Widget _containerTabDetailsPokemon(context) {
    return Expanded(
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
          length: 3,
          child: Column(
            children: [
              const TabBar(
                labelColor: Colors.black,
                unselectedLabelColor: Colors.grey,
                tabs: [
                  Tab(text: 'About'),
                  Tab(text: 'Base Stats'),
                  Tab(text: 'Moves'),
                  // Tab(text: 'About'),
                ],
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    _aboutPokemon(context),
                    _baseStats(context),
                    _movesPokemon(context),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _aboutPokemon(context) {
    Responsive responsive = Responsive.of(context);
    var abilities = '';
    pokemon!.abilities!.forEach((ability) {
      abilities = abilities + ability.ability!.name.toString() + ' ';
    });
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: responsive.widthPercentage(3),
        vertical: responsive.heightPercentage(2),
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
              ),
              padding: EdgeInsets.all(
                responsive.diagonalPercentage(2),
              ),
              child: Column(
                children: [
                  _rowProperties(context, 'Height', '"${pokemon!.height}'),
                  _rowProperties(context, 'Weigth', '${pokemon!.weight} lb'),
                  _rowProperties(context, 'Abilities', abilities)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _rowProperties(context, String title, String property) {
    Responsive responsive = Responsive.of(context);
    return Container(
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: responsive.widthPercentage(25),
            // height: responsive.heightPercentage(10),
            child: Text(
              title,
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: responsive.diagonalPercentage(2),
              ),
              maxLines: 6,
            ),
          ),
          Container(
            width: responsive.widthPercentage(50),
            child: Text(
              property,
              style: TextStyle(
                color: Colors.black,
                fontSize: responsive.diagonalPercentage(2),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _baseStats(context) {
    Responsive responsive = Responsive.of(context);
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: responsive.widthPercentage(3),
        vertical: responsive.heightPercentage(2),
      ),
      padding: EdgeInsets.all(
        responsive.diagonalPercentage(2),
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            _rowState(context, '${pokemon!.stats![0].stat!.name}',
                '${pokemon!.stats![0].baseStat}', Colors.greenAccent),
            _rowState(context, '${pokemon!.stats![1].stat!.name}',
                '${pokemon!.stats![1].baseStat}', Colors.redAccent),
            _rowState(context, '${pokemon!.stats![2].stat!.name}',
                '${pokemon!.stats![2].baseStat}', Colors.blueAccent),
            _rowState(context, '${pokemon!.stats![3].stat!.name}',
                '${pokemon!.stats![3].baseStat}', Colors.amberAccent),
            _rowState(context, '${pokemon!.stats![4].stat!.name}',
                '${pokemon!.stats![4].baseStat}', Colors.lightBlue),
            _rowState(context, '${pokemon!.stats![5].stat!.name}',
                '${pokemon!.stats![5].baseStat}', Colors.green),
          ],
        ),
      ),
    );
  }

  Widget _rowState(context, String title, String statNumber, Color color) {
    Responsive responsive = Responsive.of(context);
    var valor = ((double.parse(statNumber) / 100) * 67) - 15;
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: responsive.heightPercentage(1),
      ),
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.only(
              right: responsive.widthPercentage(2),
            ),
            width: responsive.widthPercentage(20),
            child: Text(
              title,
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: responsive.diagonalPercentage(2),
              ),
              maxLines: 6,
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              right: responsive.widthPercentage(2),
            ),
            child: Text(
              statNumber,
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: responsive.diagonalPercentage(2),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.grey[300],
              ),
              child: Stack(
                children: [
                  Container(
                    // color: Colors.green,
                    height: responsive.heightPercentage(1),
                    width: responsive.widthPercentage(valor),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: color,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _movesPokemon(context) {
    Responsive responsive = Responsive.of(context);
    return Container(
      width: responsive.widthPercentage(100),
      margin: EdgeInsets.symmetric(
        horizontal: responsive.widthPercentage(8),
      ),
      child: ListView.builder(
          itemCount: pokemon!.moves!.length,
          itemBuilder: (context, index) {
            return Text(
              '${pokemon!.moves![index].move!.name}',
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: responsive.diagonalPercentage(2),
              ),
            );
          }),
    );
  }
}
