
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:stop_watch/ui/stopwatch.dart';

class MyTimer extends StatefulWidget {
    const MyTimer({ Key? key }) : super(key: key);
  
    @override
    _MyTimerState createState() => _MyTimerState();

 
    }
    
    class _MyTimerState extends State<MyTimer> with TickerProviderStateMixin {
  
     late TabController tb;
     int hour = 0;
     int min = 0;
     int sec = 0;
     bool started=true;
     bool stopped=true;
     int timeForTimer=0;
     String timeToDisplay='';
     bool checkTimer=true;
  
     @override
    void initState() {
      tb = TabController(
        length: 2,
        vsync: this,
      );
      super.initState();
    }
  
    void start(){
      setState(() {
        started=false;
        stopped=false;
      });
      timeForTimer= ((hour*60*60)+(min*60)+sec) ;
      Timer.periodic(
        Duration(
        seconds:1,
        ),
        
      (Timer t) { 
        setState(() {
          if (timeForTimer<1 || checkTimer==false) {
            t.cancel();
            checkTimer=true;
            timeToDisplay='';
            started=true;
            stopped=true;
            Navigator.pushReplacement(context, 
            MaterialPageRoute(builder: (context){
              return MyTimer();
            })

            );
          }
          else if(timeForTimer<60){
            timeToDisplay=timeForTimer.toString();
            timeForTimer= timeForTimer-1;
          }
          else if(timeForTimer<3600){
            int m = timeForTimer ~/ 60;       
            int s = timeForTimer -(60*m);
            timeToDisplay= m.toString() +':'+ s.toString();
            timeForTimer= timeForTimer-1;
          }else{
            int h= timeForTimer ~/ 3600;
            int t= timeForTimer - (3600*h);
            int m= t ~/60;
            int s= t - (60*m);
            timeToDisplay=
              h.toString()+':' + m.toString()+ ':' +s.toString();
            timeForTimer= timeForTimer - 1;
          }

          // else{
          //   timeForTimer=timeForTimer-1;
          // }
          // timeToDisplay=timeForTimer.toString();
        });
      });
    // debugPrint(timeForTimer.toString());
  }
  void stop(){
    started=true;
    stopped=true;
    checkTimer=false;
  }


  Widget timer(){
    return Container(
      
    child: Column(
      children:<Widget>[
        Expanded(
          flex:6,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children:<Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children:<Widget>[
                  Padding(
                    padding: EdgeInsets.only(bottom:10.0),
                    child: Text('HH',
                    style: TextStyle(
                      fontSize:18.0,
                      fontWeight:FontWeight.w600
                    ),)
                    ),
                  
                   NumberPicker(
                     itemWidth: 50,
                      minValue: 0,
                      maxValue: 23,
                      value: hour,
                      onChanged: (val){
                        setState(() {
                          hour=val;
                        });
                      }),
                  
                ]
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children:<Widget>[
                  Padding(
                    padding: EdgeInsets.only(bottom:10.0),
                    child: Text('MM',
                    style: TextStyle(
                      fontSize:18.0,
                      fontWeight:FontWeight.w600
                    ))
                    ),
                  NumberPicker(
                    itemWidth: 50,
                    minValue: 0,
                    maxValue: 59,
                    value: min,
                    onChanged: (val){
                      setState(() {
                        min=val;
                      });
                    })
                ]
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children:<Widget>[
                  Padding(
                    padding: EdgeInsets.only(bottom:10.0),
                    child: Text('SS',
                    style: TextStyle(
                      fontSize:18.0,
                      fontWeight:FontWeight.w600
                    ))
                    ),
                  NumberPicker(
                    itemWidth: 50,
                    minValue: 0,
                    maxValue: 59,
                    value: sec,
                    onChanged: (val){
                      setState(() {
                        sec=val;
                      });
                    })
                ]
              )
            ]
          )),
        Expanded(
          flex:1,
          child: Text(timeToDisplay,
           style: TextStyle(
             fontSize:35.0,
             fontWeight:FontWeight.w700
           ),)
          ),
        Expanded(
          flex:3,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children:<Widget>[
               
               new RaisedButton(
                  child: new Text('Start',
                  style: TextStyle(
                    fontSize: 18.0,
                    color:Colors.white
                  ),),
                  padding: EdgeInsets.symmetric(horizontal:30.0,
                            vertical:10.0),
                 shape: RoundedRectangleBorder(
                   borderRadius: BorderRadius.circular(15.0)
                 ),
                  onPressed: started ? start : null,
                  color: Colors.green
              ),
               new RaisedButton(
                 color:Colors.orange,
                 onPressed: stopped ? null : stop,
                 child:Text('Stop',
                 style: TextStyle(
                    fontSize: 18.0,
                    color:Colors.white
                  ),),
                  padding: EdgeInsets.symmetric(horizontal:30.0,
                            vertical:10.0),
                 shape: RoundedRectangleBorder(
                   borderRadius: BorderRadius.circular(15.0)
                 ),) 
            ]
          ) )
      ]
    ),
    );
  }
 
  Widget stopwatch(){
    return Stopwatch1();
  }
  
    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: new AppBar(
          title: Text('Time Project'),
          centerTitle: true,
          bottom: TabBar(tabs: <Widget>[
            Text('Timer'),
            Text('Stopwatch')
          ],
          labelPadding: EdgeInsets.only(bottom:10.0),
          labelStyle: new TextStyle(
            fontSize: 20.0,color: Colors.black12
          ),
          unselectedLabelColor: Colors.white60,
          controller: tb,
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            timer(),
              // Text('Timer'),
              // Text('Stopwatch')
            stopwatch()
            
          ],
          controller: tb,),
      );
    }
  }