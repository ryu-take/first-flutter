import 'dart:async';

import 'package:flutter/material.dart';

class Pomodoro extends StatefulWidget {
  Pomodoro(this.worktime, this.resttime);
  final String worktime;
  final String resttime;

  @override
  _PomodoroState createState() => _PomodoroState();
}

class _PomodoroState extends State<Pomodoro> {
  Timer timer;
  bool isworktime = false;
  bool started = true;
  bool stopped = true;
  bool ispushed = true;
  bool checktimer = true;
  int totalTime = 0;
  String timetodisplay = "";

  void start() {
    print("start");
    setState(() {
      started = false;
      stopped = false;
      // if (ispushed) totalTime = ((min * 60) + sec);
      ispushed = false;
    });
    timer = Timer.periodic(
      Duration(
        seconds: 1,
      ),
      (Timer t) {
        setState(() {
          if (totalTime < 1 || checktimer == false) {
            t.cancel();
            checktimer = true;
            started = true;
            stopped = true;
            if (totalTime < 1) {
              timetodisplay = "0:" + totalTime.toString();
              change();
              start();
            }
          } else if (totalTime < 60) {
            timetodisplay = "0:" + totalTime.toString();
            totalTime -= 1;
          } else if (totalTime < 3600) {
            int m = totalTime ~/ 60;
            int s = totalTime - (60 * m);
            timetodisplay = m.toString() + ":" + s.toString();
            totalTime -= 1;
          }
        });
      },
    );
  }

  void stop() {
    print(isworktime);
    setState(() {
      started = true;
      stopped = true;
      checktimer = false;
      try {
        var timearr = timetodisplay.split(":");
        totalTime = (int.parse(timearr[0]) * 60 + int.parse(timearr[1]) - 1);
        print('やった,$totalTime:,$timetodisplay');
      } catch (exception) {
        print('だめ,$totalTime:,$timetodisplay');
      }
    });
  }

  void change() {
    print("change");
    setState(() {
      if (isworktime) {
        totalTime = int.parse(widget.worktime);
        int m = totalTime ~/ 60;
        int s = totalTime - (60 * m);
        timetodisplay = m.toString() + ":" + s.toString();
        isworktime = false;
      } else {
        totalTime = int.parse(widget.resttime);
        int m = totalTime ~/ 60;
        int s = totalTime - (60 * m);
        timetodisplay = m.toString() + ":" + s.toString();
        isworktime = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // start();
    return Scaffold(
      body: Container(
        height: double.infinity,
        color: Colors.amberAccent,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Timerだよ！${widget.worktime},${widget.resttime},$totalTime"),
              Text("$timetodisplay"),
              RaisedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("Finish?"),
              ),
              RaisedButton(
                onPressed: () {
                  change();
                },
                child: Text("a"),
              ),
              RaisedButton(
                onPressed: () {
                  start();
                },
                child: Text("start"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
