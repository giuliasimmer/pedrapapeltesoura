import 'dart:math';
import 'package:flutter/material.dart';

class PPT extends StatefulWidget {
  const PPT({Key? key}) : super(key: key);

  @override
  State<PPT> createState() => _PPTState();
}

class _PPTState extends State<PPT> {
  String _imgUserPlayer = "assets/indefinido.png";
  String _imgAppPlayer = "assets/indefinido.png";

  // PONTUAÇÃO
  int _userPoints = 0;
  int _appPoints = 0;
  int _tiePoints = 0;

  //Bordas:
  Color _borderUserColor = Colors.transparent;
  Color _borderAppColor = Colors.transparent;

  String _obtemEscolhaApp() {
    var opcoes = ['Pedra', 'Papel', 'Tesoura'];

    String vlrEscolhido = opcoes[Random().nextInt(3)];

    return vlrEscolhido;
  }

  void _terminaJogada(String escolhaUser, String escolhaApp) {
    var resultado = "Indefinido";

    switch (escolhaUser) {
      case "Pedra":
        if (escolhaApp == "Papel") {
          resultado = "app";
        } else if (escolhaApp == "Tesoura") {
          resultado = "user";
        } else {
          resultado = "Empate";
        }
        break;
      case "Papel":
        if (escolhaApp == "Pedra") {
          resultado = "user";
        } else if (escolhaApp == "Tesoura") {
          resultado = "app";
        } else {
          resultado = "Empate";
        }
        break;
      case "Tesoura":
        if (escolhaApp == "Papel") {
          resultado = "user";
        } else if (escolhaApp == "Pedra") {
          resultado = "app";
        } else {
          resultado = "Empate";
        }
        break;
    }

    setState(() {
      if (resultado == "user") {
        _userPoints++;
        _borderUserColor = Colors.green;
        _borderAppColor = Colors.transparent;
      } else if (resultado == "app") {
        _appPoints++;
        _borderUserColor = Colors.transparent;
        _borderAppColor = Colors.green;
      } else {
        _tiePoints++;
        _borderUserColor = Colors.orange;
        _borderAppColor = Colors.orange;
      }
    });
  }

  void _iniciaJogada(String opcao) {
    //Configura a opção escolhida pelo usuário:
    setState(() {
      _imgUserPlayer = "assets/$opcao.png";
    });

    String escolhaApp = _obtemEscolhaApp();
    setState(() {
      _imgAppPlayer = "assets/$escolhaApp.png";
    });

    _terminaJogada(opcao, escolhaApp);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.green),
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Pedra, Papel e Tesoura"),
        ),
        body: Column(children: [
          const Padding(
            padding: EdgeInsets.only(top: 10, bottom: 20),
            child: Text(
              'Disputa',
              style: TextStyle(fontSize: 26),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Badge(borderColor: _borderUserColor, imgPlayer: _imgUserPlayer),
              const Text('VS'),
              Badge(borderColor: _borderAppColor, imgPlayer: _imgAppPlayer),
            ],
          ),
          const Padding(
            padding: EdgeInsets.only(top: 10, bottom: 20),
            child: Text(
              'Placar',
              style: TextStyle(fontSize: 18),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Placar(playerName: 'Você', playerPoints: _userPoints),
              Placar(playerName: 'Empate', playerPoints: _tiePoints),
              Placar(playerName: 'Máquina', playerPoints: _appPoints),
            ],
          ),
          const Padding(
            padding: EdgeInsets.only(top: 10, bottom: 20),
            child: Text(
              'Opções',
              style: TextStyle(fontSize: 16),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () => _iniciaJogada("Pedra"),
                child: Image.asset(
                  'assets/pedra.png',
                  height: 90,
                ),
              ),
              GestureDetector(
                onTap: () => _iniciaJogada("Papel"),
                child: Image.asset(
                  'assets/papel.png',
                  height: 90,
                ),
              ),
              GestureDetector(
                onTap: () => _iniciaJogada("Tesoura"),
                child: Image.asset(
                  'assets/tesoura.png',
                  height: 90,
                ),
              ),
            ],
          )
        ]),
      ),
    );
  }
}

class Placar extends StatelessWidget {
  const Placar({
    Key? key,
    required String playerName,
    required int playerPoints,
  })  : _playerPoints = playerPoints,
        _playerName = playerName,
        super(key: key);

  final int _playerPoints;
  final String _playerName;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(_playerName),
        Container(
          decoration: BoxDecoration(
              border: Border.all(color: Colors.black45, width: 2),
              borderRadius: const BorderRadius.all(Radius.circular(7))),
          margin: const EdgeInsets.all(8),
          padding: const EdgeInsets.all(35),
          child: Text('$_playerPoints', style: TextStyle(fontSize: 26)),
        )
      ],
    );
  }
}

class Badge extends StatelessWidget {
  const Badge({
    Key? key,
    required Color borderColor,
    required String imgPlayer,
  })  : _borderColor = borderColor,
        _imgPlayer = imgPlayer,
        super(key: key);

  final Color _borderColor;
  final String _imgPlayer;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: _borderColor, width: 4),
          borderRadius: const BorderRadius.all(Radius.circular(100))),
      child: Image.asset(
        _imgPlayer,
        height: 120,
      ),
    );
  }
}

void main() {
  runApp(const PPT());
}