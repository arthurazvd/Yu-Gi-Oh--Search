import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About Yu-Gi-Oh! Card Search'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Text(
            'Yu-Gi-Oh! Card Search é um aplicativo dedicado à pesquisa de cartas do jogo Yu-Gi-Oh!. Você pode pesquisar por cartas, aplicar filtros por tipo e muito mais.',
            style: TextStyle(fontSize: 18, color: Colors.white),
            textAlign: TextAlign.center,
          ),
        ),
      ),
      backgroundColor: Colors.black,
    );
  }
}
