import 'dart:async';

import 'package:flutter/material.dart';

class Stopwatch1 extends StatefulWidget {
  const Stopwatch1({ Key? key }) : super(key: key);

  @override
  _Stopwatch1State createState() => _Stopwatch1State();
}

class _Stopwatch1State extends State<Stopwatch1> {
  bool startIsPressed = true;
  bool stopIsPressed = true;
  bool resetIsPressed = true;
  String stoptimeToDisplay = '00.00.00';
  var stopwatch1 = Stopwatch();
  final dur = Duration(seconds: 1);

  void startTimer(){
    Timer(dur, keepRunning);
  }
  void keepRunning(){
    if (stopwatch1.isRunning) {
      startTimer();
    }
    setState(() {
      stoptimeToDisplay= stopwatch1.elapsed.inHours.toString().padLeft(2,'0')+':'
                         +(stopwatch1.elapsed.inMinutes%60).toString().padLeft(2,'0')+':'
                         +(stopwatch1.elapsed.inSeconds%60).toString().padLeft(2,'0');
    });
  }

  void startStopwatch(){
    setState(() {
      stopIsPressed = false;
      startIsPressed = false;
    });
    stopwatch1.start();
    startTimer();
  }

  void stopStopwatch(){
    setState(() {
      stopIsPressed= true;
      resetIsPressed= false;
    });
    stopwatch1.stop();
  }
  void resetStopwatch(){
    setState(() {
      resetIsPressed= true;
      startIsPressed= true;
    });
    stopwatch1.reset();
    stoptimeToDisplay= '00.00.00';
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Expanded(
            flex: 6,
            child: Container(
              alignment: Alignment.center,
              child: new Text(stoptimeToDisplay,
                  style: TextStyle(
                    fontSize: 40.0,
                    fontWeight: FontWeight.w800
                  ),),
            )),
          Expanded(
            flex: 4,
            child: Container(
              child: new Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      new RaisedButton(
                        padding: EdgeInsets.symmetric(
                          horizontal:40.0,
                          vertical:10.0
                        ),
                        color: Colors.red,
                        child: Text('Stop',
                          style:TextStyle(
                            fontSize: 18.0,
                            color: Colors.white
                          )),
                        onPressed: stopIsPressed ? null : stopStopwatch),

                      new RaisedButton(
                        color:Colors.teal,
                        padding: EdgeInsets.symmetric(
                          horizontal:40.0,
                          vertical:10.0
                        ),
                        child: Text('Reset',
                        style: TextStyle(
                          fontSize:18.0,
                          color: Colors.white
                        ),),
                        onPressed: resetIsPressed ? null : resetStopwatch),
                     ] ),
                       new RaisedButton(
                padding: EdgeInsets.symmetric(
                  horizontal: 70.0,
                  vertical: 15.0
                ),
                color: Colors.green,
                child: Text('Start',
                style: TextStyle(
                  fontSize:22.0,
                  color:Colors.white
                ),),
                onPressed: startIsPressed ? startStopwatch : null),
                    ]
        
              )
              )
        
              )]));  
            
  }
}