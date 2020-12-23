import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';

import 'countdown.dart';
import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.red,
        // visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Pomodoro? Timer'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  final audio = AudioCache();

  @override
  void initState() {
    audio.load('cursor8.mp3');
    super.initState();
  }

  int workmin = 0;
  int worksec = 0;
  int workTotalTime = 0;
  int restmin = 0;
  int restsec = 0;
  int restTotalTime = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        color: Colors.deepPurpleAccent[100],
        child: Column(
          //一番大きいの
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Expanded( ??
            //いるらしい
            Row(
              //二つのコンテナとボタンが入る
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(
                    bottom: 150.0,
                  ),
                  child: Container(
                    height: 200.0,
                    decoration: BoxDecoration(
                      // shape: BoxShape.circle,
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.yellowAccent,
                    ),
                    //文字とナンバーピッカーが入る
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Icon(Icons.no_cell),
                            Text(
                              " Work time ",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Icon(Icons.fitness_center),
                          ],
                        ),
                        Row(
                          children: [
                            NumberPicker.integer(
                              initialValue: workmin,
                              minValue: 0,
                              maxValue: 59,
                              onChanged: (val) {
                                audio.play('cursor8.mp3', mode: PlayerMode.LOW_LATENCY);
                                setState(() {
                                  workmin = val;
                                  workTotalTime = ((workmin * 60) + worksec);
                                });
                              },
                            ),
                            Text(
                              ":",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0,
                              ),
                            ),
                            NumberPicker.integer(
                              initialValue: worksec,
                              minValue: 0,
                              maxValue: 59,
                              onChanged: (val) {
                                audio.play('cursor8.mp3', mode: PlayerMode.LOW_LATENCY);
                                setState(() {
                                  worksec = val;
                                  workTotalTime = ((workmin * 60) + worksec);
                                });
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    bottom: 150.0,
                  ),
                  child: Container(
                    height: 200,
                    decoration: BoxDecoration(
                      // shape: BoxShape.circle,
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.lightBlueAccent[100],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Row(
                          children: [
                            Icon(Icons.music_note),
                            Text(
                              " Rest time ",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Icon(Icons.airline_seat_individual_suite_rounded),
                          ],
                        ),
                        Row(
                          children: [
                            NumberPicker.integer(
                              initialValue: restmin,
                              minValue: 0,
                              maxValue: 59,
                              onChanged: (val) {
                                setState(() {
                                  restmin = val;
                                  restTotalTime = ((restmin * 60) + restsec);
                                });
                              },
                            ),
                            Text(
                              ":",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0,
                              ),
                            ),
                            NumberPicker.integer(
                              initialValue: restsec,
                              minValue: 0,
                              maxValue: 59,
                              onChanged: (val) {
                                setState(() {
                                  restsec = val;
                                  restTotalTime = ((restmin * 60) + restsec);
                                });
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            // ),
            //Expanded(
            //child:
            Padding(
              padding: EdgeInsets.only(bottom: 100),
              child: ElevatedButton(
                child: Text(
                  'Start Timer!',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  primary: Colors.lightGreenAccent,
                  onPrimary: Colors.white,
                  padding: EdgeInsets.symmetric(
                    horizontal: 40.0,
                    vertical: 10.0,
                  ),
                ),
                onPressed: () {
                  showDialog(
                    context: context,
                    child: AlertDialog(
                      title: Text("Start Timer"),
                      content: Text(
                        'Work Time → $workmin:$worksec \nRest Time  → $restmin:$restsec \nでタイマーを起動します。',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      actions: <Widget>[
                        // ボタン領域
                        FlatButton(
                          child: Text("Cancel"),
                          onPressed: () => Navigator.pop(context),
                        ),
                        FlatButton(
                          child: Text("OK"),
                          onPressed: () => Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Pomodoro(
                                    '$workTotalTime', '$restTotalTime')),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            //),
          ],
        ),
      ),

      // floatingActionButton: FloatingActionButton(
      //   onPressed: _incrementCounter,
      //   tooltip: 'Increment',
      //   child: Icon(Icons.add),
      // ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
