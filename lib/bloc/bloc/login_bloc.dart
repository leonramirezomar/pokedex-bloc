import 'package:flutter/material.dart';
import 'package:pokedex/pages/pokedexPage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginBloc {
  TextEditingController textName = TextEditingController();

  bool validateData() {
    // print(textName.text);
    if (textName.text.isEmpty) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> getUser(context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('user', textName.text);

    Navigator.pushNamed(context, 'pokedex');
  }
}
