import 'package:flutter/material.dart';

class Instructions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blueAccent,
          elevation: 0.0,
          title: Text("Instrucciones"),
        ),
        backgroundColor: Colors.blue.shade50,
        body: Center(
          child: Text(
            //TODO Poner las reglas
            "Pues en internet las ves, crack",
            style: TextStyle(
              color: Colors.blue.shade700,
              fontWeight: FontWeight.bold,
            ),
          ),
        ));
  }
}
