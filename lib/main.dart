import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(
    const MainApp(),
  ); // Ponto de partida do, refere-se ao import e o pacote
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});
  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  var _randomNumber = 0;
  var _text = "???";
  var _alert = '';
  final List<int> _randomNumberList = [];

  void _generateRandom() {
    setState(() {
      _randomNumber = Random().nextInt(100) + 1;
      _text = _randomNumber.toString();
      if (_randomNumberList.contains(_randomNumber)) {
        _alert = 'Número $_randomNumber já foi sorteado! \n          ヽ（≧□≦）ノ';
      } else {
        _alert = '';
        _randomNumberList.add(_randomNumber);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          toolbarHeight: 100,
          title: const Text(
            'Número da Sorte     O(∩_∩)O',
            style: TextStyle(
              color: Color(0xff39ff14),
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: Color(0xff0a100a),
        ),
        body: Center(
          child: Container(
            padding: EdgeInsets.fromLTRB(30, 50, 30, 100),
            color: Color(0xff000000),
            child: Column(
              spacing: 20,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  'Hoje é seu dia de sorte! Clique no botão abaixo e confira agora mesmo!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xff00ff00),
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  child: Text(
                    _text,
                    style: TextStyle(
                      color: Color(0xff39ff14),
                      fontSize: 120,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text(
                  _alert,
                  style: TextStyle(
                    color: Color(0xff20a020),
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                ElevatedButton(
                  onPressed: _generateRandom,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xff39ff14),
                    foregroundColor: Color(0xff000000),
                    padding: EdgeInsets.symmetric(horizontal: 60, vertical: 20),
                    textStyle: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  child: Text('SORTE!'),
                ),
                Text(
                  _randomNumberList.isEmpty
                      ? ''
                      : 'Números já sorteados: \n${_randomNumberList.toString()}',
                  style: TextStyle(
                    color: Color(0xff20a020),
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() {
              _randomNumberList.clear();
              _text = '???';
              _alert = '';
            });
          },
          backgroundColor: const Color(0xff39ff14),
          child: const Icon(Icons.refresh, color: Color(0xff000000)),
        ),
      ),
    );
  }
}
