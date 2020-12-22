import 'package:flutter/material.dart';
import './pomodoro_timer_app.dart';
import 'package:my_app/timers.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MyAPP',
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: //Row(
        // children:[
        // CountDownTimerApp(),
        Timers(title:'title'),
        // ]
      //)
    );
  }
}


