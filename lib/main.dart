
import 'package:flutter/material.dart';
import 'package:stop_watch/ui/timer.dart';

void main() {
  runApp(MyApp()
  );
}
  class MyApp extends StatelessWidget {
  
    @override
    Widget build(BuildContext context) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Time',
        theme: ThemeData(
          primarySwatch: Colors.blue
        ),

        home: MyTimer(),
      );
    }
  }
  