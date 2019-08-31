import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as prefix0;
import 'dart:async';
import 'dart:collection';
import 'characterList.dart';
import 'team.dart';

class Game extends StatefulWidget {
  final int _numTeams;
  final Color _color;
  Game(this._numTeams, this._color);

  @override
  GameState createState() => new GameState(_numTeams, _color);
}

class GameState extends State<Game> {
  //Constants & Finals
  static const String BeginText = "Turno del equipo ";
  static const int MAX_TIME = 30;
  final Color _color;
  final Color tick = Colors.green.shade500;

  //Timer stuff
  Timer _timer;
  int _start = MAX_TIME;
  bool started = false;

  //Num of teams
  final int _numTeams;
  int currentTeam;
  List<Team> teams;

  //List of chararacters
  ListQueue<String> characterList;
  List<String> initialList;

  //Others
  String _text;
  int round;

  GameState(this._numTeams, this._color) {
    round = 1;
    currentTeam = 0;
    teams = new List();
    
    _text = BeginText + (currentTeam + 1).toString() + "\nCLICK PARA EMPEZAR!";

    for (var i = 0; i < _numTeams; i++) {
      Team team = new Team();
      team.name = (i+1).toString();
      teams.add(team);
    }

    characterList = setLista();
    initialList = characterList.toList();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
            body: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  buildTimer(),
                  buildCharacterCard(),
                  buildCorrectButton(),
                  buildIncorrectButton(),
                ]),
          );
        }


  //Widgets

  AppBar buildAppBar() {
    TextStyle styleDefault10 = new TextStyle(
      fontSize: 10.0,
    );
    TextStyle styleDefault20 = new TextStyle(
      fontSize: 20.0,
    );
    return AppBar(
      backgroundColor: _color,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Text("Equipo", style: styleDefault10),
              Icon(selectIcon(currentTeam),size: 20.0,),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Text("Puntos", style: styleDefault10),
              Text(teams[currentTeam].points.toString(), style: styleDefault20),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Text("Quedan", style: styleDefault10,),
              Text(characterList.length.toString(), style: styleDefault20),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Text("Ronda", style: styleDefault10),
              Text( round.toString() + "/3", style: styleDefault20),
            ],
          )
        ],
      ),
    );
  }
      
  Text buildTimer() {
          return Text(
            "$_start",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 50.0, color: _color),
          );
        }
      
  Card buildCharacterCard() {
          return Card(
            color: _color,
            elevation: 7.0,
            child: FlatButton(

              child: Text(
              _text,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 30.0, color: Colors.white),
            ),
            onPressed:(){
              if(!started){
                swapText();
                startTimer();
              } 
            },
            ) ,
          );
        }

  FlatButton buildCorrectButton() {
      
          return FlatButton(
              onPressed: () {
                if(started){
                correctAnswer();
                swapText();
                }
              },
              child: Icon(
                Icons.check_circle,
                size: 180.0,
                color: tick,
              ));
        }
      
  FlatButton buildIncorrectButton() {
          return FlatButton(
              onPressed: () {
                if(started){
                swapText();
                // ? If you press pass on 1st round you got 5 less secs
                  if(round == 1){
                  (_start - 5) <= 0 ? _start = 0 : _start -= 5;
                  } 
                }
                  
              },
              child: Icon(
                Icons.cancel,
                size: 100.0,
                color: Colors.red,
              ));
        }
 
  IconData selectIcon(int _currentTeam) {
          switch (_currentTeam) {
            case 0:
              return Icons.filter_1;
              break;
            case 1:
              return Icons.filter_2;
              break;
            case 2:
              return Icons.filter_3;
              break;
            case 3:
              return Icons.filter_4;
              break;
          }
          return Icons.filter_none;
        }


  //Functionality

  swapText() {
    setState(() {});
    _text = characterList.removeFirst();
    characterList.addLast(_text);
  }

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    started = true;
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) => setState(
        () {
          if (_start < 1) {
            timer.cancel();
            currentTeam++;
            currentTeam %= _numTeams;
            _text = BeginText + (currentTeam + 1).toString() + "\nCLICK PARA EMPEZAR!";
            started = false;
            _start = MAX_TIME;
          } else {
            _start = _start - 1;
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }


  correctAnswer() {
    setState(() {});
    if(started) teams[currentTeam].points++;
    if (characterList.length > 1) {
      characterList.removeLast();
    } else {
      initialList.shuffle();
      characterList = new ListQueue.of(initialList);
      round++;
      if(round > 3){
        round = 4;
        Navigator.pop(context);
      }
        showPoints();
      //3 states (s0 -> can't pass, s1 && s2 -> can pass)
      started = false;
      _start = 0;
    }
  }

  void showPoints() {
    Navigator.of(context).push(
      new MaterialPageRoute(
        builder: (context){
          return new Scaffold(
            backgroundColor: _color,
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: pointsByTeam(teams, round, context),
              ),
            ),
          );
        },
    
      )
    );
  }
}


List<Widget> pointsByTeam(List<Team> teams,int round, var context){
TextStyle bigStyle = new TextStyle(fontSize: 30.0,
color: Colors.white,
);

TextStyle bigBigStyle = new TextStyle(fontSize: 40.0,
color: Colors.black,
);
List<Widget> pointsByTeam = new List<Widget>();
if(round == 4){
  pointsByTeam.add(Text("FIN DEL JUEGO",style: TextStyle(fontSize: 30.0,color: Colors.black),));
}
else pointsByTeam.add(Text("Ronda nº " + (round-1).toString(),style: TextStyle(fontSize: 30.0,color: Colors.black),));
for (var i = 0; i < teams.length; i++) {
  pointsByTeam.add(new Text("Total equipo "+ teams[i].name + " es: "
  ,style: bigStyle,));
   pointsByTeam.add(new Text(teams[i].points.toString()
  ,style: bigBigStyle,));
}
if(round != 4){

pointsByTeam.add(
  FlatButton(child: Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      Text("Siguiente ronda   ",style: bigStyle,),
      Icon(Icons.navigate_next,color: Colors.white,size: 50.0,),
    ],
  ),
  onPressed:(){
    Navigator.pop(context);
  },
  color: Colors.black38,)
);
}
return pointsByTeam;
}