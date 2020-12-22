import 'dart:async';
import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';

class Timers extends StatefulWidget {
  Timers({Key key}) : super(key: key);

  @override
  _TimersState createState() => _TimersState();
}

class _TimersState extends State<Timers> with TickerProviderStateMixin {
  int min = 0;
  int sec = 0;
  bool started = true;
  bool stopped = true;
  bool ispushed = true;
  int totalTime = 0;
  String timetodisplay = "";
  bool checktimer = true;
  Timer timer;

  @override
  void initState() {
    super.initState();
  }

  void start() {
    setState(() {
      started = false;
      stopped = false;
      if (ispushed) totalTime = ((min * 60) + sec);
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
            if (totalTime == 0) {
              timetodisplay = totalTime.toString();
              print("owatta");
            }
          } else if (totalTime < 60) {
            timetodisplay = totalTime.toString();
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

  Widget timerW() {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            flex: 6,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(
                        bottom: 10.0,
                      ),
                      child: Text("MM"),
                    ),
                    NumberPicker.integer(
                      initialValue: min,
                      minValue: 0,
                      maxValue: 59,
                      onChanged: (val) {
                        setState(() {
                          min = val;
                          totalTime = ((min * 60) + sec);
                          print(totalTime);
                        });
                      },
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(
                        bottom: 10.0,
                      ),
                      child: Text("SS"),
                    ),
                    NumberPicker.integer(
                      initialValue: sec,
                      minValue: 0,
                      maxValue: 59,
                      onChanged: (val) {
                        setState(() {
                          sec = val;
                          totalTime = ((min * 60) + sec);
                          print(totalTime);
                        });
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              ispushed ? '$min:$sec' : timetodisplay,
              style: TextStyle(
                fontSize: 35.0,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                ElevatedButton(
                  child: Text('Start!'),
                  style: ElevatedButton.styleFrom(
                      primary: Colors.orange,
                      onPrimary: Colors.white,
                      padding: EdgeInsets.symmetric(
                        horizontal: 40.0,
                        vertical: 10.0,
                      )),
                  onPressed: started ? start : null,
                ),
                ElevatedButton(
                  child: Text('Stop!'),
                  style: ElevatedButton.styleFrom(
                      primary: Colors.red,
                      onPrimary: Colors.white,
                      padding: EdgeInsets.symmetric(
                        horizontal: 40.0,
                        vertical: 10.0,
                      )),
                  onPressed: stopped ? null : stop,
                ),
              ],
            ),
          ),
          //RaisedButton(
          // onPressed: (){},
          // child: Text(
          //   "Start!",
          //   style: TextStyle(
          //     fontSize: 18.0,
          //   ),
          // ),
          //),
          //),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Timer",
        ),
      ),
      body: timerW(),
    );
  }
}
