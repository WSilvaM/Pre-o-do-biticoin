import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

//https://blockchain.info/ticker
class _HomePageState extends State<HomePage> {
  String _Preco = "0";

  void _AtualizarValor() async {
    final request = Uri.parse("https://blockchain.info/ticker");

    http.Response response = await http.get(request);
    Map<String, dynamic> returno = json.decode(response.body);

    setState(() {
      _Preco = returno["BRL"]["buy"].toString();
    });

    print("Resultado :" + returno["BRL"]["buy"].toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Center(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Image.asset("img/bitcoin.png"),
              Padding(
                padding: EdgeInsets.only(top: 30, bottom: 30),
                child: Text(
                  "R\$ " + _Preco,
                  style: TextStyle(fontSize: 32),
                ),
              ),
              ElevatedButton(
                  onPressed: _AtualizarValor,
                  child: Text(
                    'Atualizar',
                    style: TextStyle(fontSize: 18),
                  ),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.amber.shade800)),
            ]),
          ),
        ),
      ),
    );
  }
}
