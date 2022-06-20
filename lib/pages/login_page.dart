import 'package:flutter/material.dart';
import 'package:pokedex/bloc/bloc/login_bloc.dart';
import 'package:pokedex/utilities/responsive.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final LoginBloc loginBloc = LoginBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: IntrinsicHeight(
          child: Stack(
            children: [
              _backGroundImage(context),
              Column(
                children: [
                  _boxFields(context),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _backGroundImage(context) {
    return Center(child: Image.asset('assets/pokeball.png'));
  }

  Widget _boxFields(context) {
    final Responsive responsive = Responsive.of(context);
    return SafeArea(
      child: Container(
        width: double.infinity,
        height: responsive.heightPercentage(90),
        margin: EdgeInsets.symmetric(
          horizontal: responsive.widthPercentage(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Ingresa tu nombre',
              style: TextStyle(
                  fontSize: responsive.diagonalPercentage(1.8),
                  fontWeight: FontWeight.bold),
            ),
            TextField(
              controller: loginBloc.textName,
              keyboardType: TextInputType.name,
              decoration: const InputDecoration(
                hintText: 'Nombre del Entrenador',
                hintStyle: TextStyle(color: Colors.grey),
              ),
            ),
            _buttonContinue(context)
          ],
        ),
      ),
    );
  }

  Widget _buttonContinue(context) {
    final Responsive responsive = Responsive.of(context);
    return Container(
      width: responsive.widthPercentage(100),
      margin: EdgeInsets.symmetric(
        vertical: responsive.heightPercentage(3),
      ),
      child: ElevatedButton(
        child: const Text(
          'Comenzar',
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.w400, fontSize: 16),
          textAlign: TextAlign.center,
        ),
        onPressed: () => loginBloc.validateData()
            ? ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'Ingresa tu nombre',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: responsive.diagonalPercentage(1.8),
                    ),
                  ),
                  backgroundColor: Colors.red,
                ),
              )
            : loginBloc.getUser(context),
        style: ElevatedButton.styleFrom(
          primary: Colors.red,
          padding:
              EdgeInsets.symmetric(horizontal: responsive.widthPercentage(3)),
        ),
      ),
    );
  }
}
