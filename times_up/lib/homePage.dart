import 'package:flutter/material.dart';
import 'game.dart';
import 'instructions.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var color = Colors.blueAccent;
  var color2 = Colors.amberAccent;
  var _numPlayers = 2;

  _swapColors() {
    setState(() {});
    color == Colors.blueAccent
        ? color = Colors.amberAccent
        : color = Colors.blueAccent;
    color2 == Colors.amberAccent
        ? color2 = Colors.blueAccent
        : color2 = Colors.amberAccent;
  }

  _changeNumberOfPlayers() {
    setState(() {});
    _numPlayers %= 4;
    _numPlayers++;
    if(_numPlayers == 1) ++_numPlayers;
  }

  Widget build(BuildContext context) {
    return Scaffold(
      /*
      appBar: AppBar(
        backgroundColor: color,
        title: Text(widget.title),
      ),
      */
      drawer: Drawer(
          child: ListView(children: <Widget>[
            UserAccountsDrawerHeader(
              accountEmail: Text(
                "timesUp@help.com",
                style: TextStyle(
                    color: color2, fontWeight: FontWeight.bold, fontSize: 15.0),
              ),
              accountName: null,
              currentAccountPicture: Icon(
                Icons.live_help,
                size: 100.0,
                color: color2,
              ),
              decoration: BoxDecoration(
                color: color,
              ),
            ),
            ListTile(
              //TODO Cambiar esto por botonera
              title: Text("Instrucciones"),
              trailing: Icon(Icons.help),
              onTap: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => Instructions())),
            )
          ])),
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Icon(
              Icons.timer_off,
              color: color,
              size: 130.0,
            ),
            Text(
              "TIME'S UP!",
              style: TextStyle(
                  color: color, fontWeight: FontWeight.bold, fontSize: 22.5),
            ),
            FlatButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(75.0))),
              onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) =>
                      Game(_numPlayers, color))),
              color: color,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    "Jugar  ",
                    style: TextStyle(
                      color: color2,
                      fontSize: 23.0,
                    ),
                  ),
                  Icon(
                    Icons.play_arrow,
                    color: color2,
                  )
                ],
              ),
            ),
            FlatButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(75.0))),
              onPressed: _changeNumberOfPlayers, //Empezar a jugar
              color: color,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    "Numero de Equipos: $_numPlayers",
                    style: TextStyle(
                      color: color2,
                      fontSize: 23.0,
                    ),
                  ),
                  Icon(
                    Icons.people,
                    color: color2,
                  )
                ],
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _swapColors,
        backgroundColor: color2,
        child: Icon(Icons.swap_horiz),
      ),
    );
  }
}