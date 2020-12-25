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

  int workmin = 25;
  int worksec = 0;
  int workTotalTime = 1500;
  int restmin = 5;
  int restsec = 0;
  int restTotalTime = 300;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Container(
          color: Colors.deepPurpleAccent[100],
          child: Column(
            //一番大きいの
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              //いるらしい
              Expanded(
                flex: 5,
                child: Row(
                  //二つのコンテナとボタンが入る
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    ConstrainedBox(
                      constraints: BoxConstraints(maxWidth: 196),
                      child: Container(
                        height: 200.0,
                        decoration: BoxDecoration(
                          // shape: BoxShape.circle,
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.yellowAccent,
                        ),
                        //文字とナンバーピッカーが入る
                        child: Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
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
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Expanded(
                                    child: NumberPicker.integer(
                                      initialValue: workmin,
                                      minValue: 0,
                                      maxValue: 59,
                                      onChanged: (val) {
                                        audio.play('cursor8.mp3', volume: 0.1, mode: PlayerMode.LOW_LATENCY);
                                        setState(() {
                                          workmin = val;
                                          workTotalTime = ((workmin * 60) + worksec);
                                        });
                                      },
                                    ),
                                  ),
                                  //Expanded(
                                    //child: 
                                    Text(
                                      ":",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20.0,
                                      ),
                                    ),
                                  //),
                                  Expanded(
                                    child: NumberPicker.integer(
                                      initialValue: worksec,
                                      minValue: 0,
                                      maxValue: 59,
                                      onChanged: (val) {
                                        audio.play('cursor8.mp3', volume: 0.1, mode: PlayerMode.LOW_LATENCY);
                                        setState(() {
                                          worksec = val;
                                          workTotalTime = ((workmin * 60) + worksec);
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    ConstrainedBox(
                      constraints: BoxConstraints(maxWidth: 196),
                      child: Container(
                        height: 200,
                        decoration: BoxDecoration(
                          // shape: BoxShape.circle,
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.lightBlueAccent[100],
                        ),
                        child: Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Icon(Icons.music_note),
                                  Text(
                                    " Rest time ",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold
                                    ),
                                  ),
                                  Icon(Icons.airline_seat_individual_suite_rounded),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: <Widget>[
                                  Expanded(
                                    child: NumberPicker.integer(
                                      initialValue: restmin,
                                      minValue: 0,
                                      maxValue: 59,
                                      onChanged: (val) {
                                        audio.play('cursor8.mp3',volume: 0.1, mode: PlayerMode.LOW_LATENCY);
                                        setState(() {
                                          restmin = val;
                                          restTotalTime = ((restmin * 60) + restsec);
                                        });
                                      },
                                    ),
                                  ),
                                  // Expanded(
                                  //  child:
                                    Text(
                                      ":",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20.0,
                                      ),
                                    // ),
                                  ),
                                  Expanded(
                                    child: NumberPicker.integer(
                                      initialValue: restsec,
                                      minValue: 0,
                                      maxValue: 59,
                                      onChanged: (val) {
                                        audio.play('cursor8.mp3',volume: 0.1, mode: PlayerMode.LOW_LATENCY);
                                        setState(() {
                                          restsec = val;
                                          restTotalTime = ((restmin * 60) + restsec);
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
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
                            color: Colors.blue,
                            child: Text("Cancel"),
                            onPressed: () => Navigator.pop(context),
                          ),
                          FlatButton(
                            color: Colors.red,
                            child: Text("OK"),
                            onPressed: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Pomodoro(
                                  '$workTotalTime', '$restTotalTime',
                                ),
                              ),
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
      ),
    );
  }
}
