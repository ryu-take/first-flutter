import 'dart:async';
import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class Pomodoro extends StatefulWidget {
  Pomodoro(this.worktime, this.resttime);
  final String worktime;
  final String resttime;

  @override
  _PomodoroState createState() => _PomodoroState();
}

class _PomodoroState extends State<Pomodoro> {
  // Future<AudioPlayer> playLocalAsset() async {
  //   AudioCache cache = new AudioCache();
  //   return await cache.play("../sounds/cursor1.mp3");
  // }
  final cache = AudioCache();

  @override
  void initState() {
    cache.load('cursor1.mp3');
    cache.load('warning1.mp3');
    start();
    super.initState();
  }

  Timer timer;
  bool isworktime = false;
  bool isstarted = true;
  int totalTime = 0;
  String timetodisplay = "";

  void start() {
    print("start,$totalTime");
    setState(() {
      if (isworktime) {
        print("torest");
        totalTime = int.parse(widget.resttime);
        isworktime = false;
      } else {
        print("towork");
        totalTime = int.parse(widget.worktime);
        isworktime = true;
      }
      isstarted = false;
    });
    timer = Timer.periodic(
      Duration(
        seconds: 1,
      ),
      (Timer t) {
        setState(() {
          print("tic,$totalTime");
          // if (totalTime < 1) {
          //   checktimer = true;
          if (totalTime < 1) {
            timetodisplay = "0:" + totalTime.toString();
            print("changing!");
            t.cancel();
            cache.play('warning1.mp3', mode: PlayerMode.LOW_LATENCY);
            start();
            // }
          } else if (totalTime < 60) {
            if (totalTime < 4) {
              cache.play('cursor1.mp3', mode: PlayerMode.LOW_LATENCY);
            }
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

  @override
  void dispose() {
    print("disposed");
    timer.cancel();
    super.dispose();
  }

  // void stop() {
  //   print(isworktime);
  //   setState(() {
  //     started = true;
  //     stopped = true;
  //     checktimer = false;
  //     var timearr = timetodisplay.split(":");
  //     totalTime = (int.parse(timearr[0]) * 60 + int.parse(timearr[1]) - 1);
  //     print('やった,$totalTime:,$timetodisplay');
  //   });
  //}

  @override
  Widget build(BuildContext context) {
    if (isworktime) {
      return Scaffold(
        body: Container(
          height: double.infinity,
          color: Colors.amberAccent,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  flex: 6,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Text("It's Work Time!!"),
                      Text(
                        "$timetodisplay",
                        style: TextStyle(
                          fontSize: 35.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    } else {
      return Scaffold(
        body: Container(
          height: double.infinity,
          color: Colors.lightBlue,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  flex: 6,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Text("It's Rest Time !!!"),
                      Text(
                        "$timetodisplay",
                        style: TextStyle(
                          fontSize: 35.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
  }
}
