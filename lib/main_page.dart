import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:path/path.dart';
import 'package:pray_training/personal/praymemo/list.dart';
import 'package:pray_training/pray_full/pray_full.dart';
import 'package:pray_training/pray_training_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'package:vertical_card_pager/vertical_card_pager.dart';

import 'link_list.dart';
import 'main.dart';

class MainPage extends StatelessWidget {
  // final Future<Database> db;
  // List<Map<String,dynamic>> list;
  // List<String> winList;
  // int winCounter;
  // MainPage(this.db, this.list, this.winList, this.winCounter);
  bool initRun;
  MainPage(this.initRun);


  List<Map<String,dynamic>> list = [
    {'homeland':'1. 나라를 위한 기도'},
    {'church':'2. 교회를 위한 기도'},
    {'pastor':'3. 담임목사님을 위한 기도'},
    {'cell':'4. 목장과 목장원을 위한 기도'},
    {'believer':'5. 태신자를 위한 기도'},
    {'person':'6. 사람을 위한 기도'},
    {'home':'7. 가정을 위한 기도'},
    {'husband':'8. 남편을 위한 기도'},
    {'wife':'9. 아내를 위한 기도'},
    {'parents':'10. 부모님을 위한 기도'},
    {'children':'11. 자녀를 위한 기도'},
    {'personal_1':'12. 개인기도'},
    {'personal_2':'13. 개인기도2'},
    {'repentance':'14. 회개기도'},
    {'spiritual_power':'15. 영적인 힘을 얻기 위한 기도'},
    {'temptations':'16. 시험이 있을 때 드리는 기도'},
    {'tarry':'17. 기도가 잘 되지 않을 때 드리는 기도'},
    {'tired':'18. 삶에 지칠 때 드리는 기도'},
    {'thanks':'19. 감사할 때 드리는 기도'},
    {'healing':'20. 몸이 아플 때 드리는 기도'},
    {'spouse':'21. 부부간에 불화가 있을 때 드리는 기도'},
    {'money':'22. 물질적인 어려움에 있을 때 드리는 기도'},
    {'business':'23. 사업을 위한 기도'},
    {'dawn':'24. 하루를 시작하며 드리는 기도'},
    {'night':'25. 하루를 마감하며 드리는 기도'},
    {'devil':'26. 마귀를 물리치는 기도'},
    {'disease':'27. 질병을 치료하는 기도'}
  ];

  List<String> winList = [];
  int winCounter = 0;
  double initPos = 0;

  @override
  Widget build(BuildContext context) {
    Color themeBorderColor = Colors.black;
    Color themeTextColor = Colors.black;
    Future<Database> db = initDatabase();

    if (SchedulerBinding.instance?.window.platformBrightness == Brightness.dark) {
      themeBorderColor = Colors.white;
      themeTextColor = Colors.white;
    }

    final List<String> titles = ["기도훈련집", "기도훈련집\n(전체)", "나의기도문", "양육교재"];

    final List<Widget> images = [
      Container(
        decoration: BoxDecoration(
          color: Colors.cyan,
          borderRadius: BorderRadius.circular(20.0),
          border: Border.all(
            width: 4,
            color: themeBorderColor,
          ),
        ),
      ),
      Container(
        decoration: BoxDecoration(
          color: Colors.blueAccent,
          borderRadius: BorderRadius.circular(20.0),
          border: Border.all(
            width: 4,
            color: themeBorderColor,
          ),
        ),
      ),
      Container(
        decoration: BoxDecoration(
          color: Colors.deepOrangeAccent,
          borderRadius: BorderRadius.circular(20.0),
          border: Border.all(
            width: 4,
            color: themeBorderColor,
          ),
        ),
      ),
      Container(
        decoration: BoxDecoration(
          color: Colors.deepPurple,
          borderRadius: BorderRadius.circular(20.0),
          border: Border.all(
            width: 4,
            color: themeBorderColor,
          ),
        ),
      ),
    ];

    return FutureBuilder(
      future: Init.instance.initialize(),
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting && initRun) {
          // _readListMap();
          // _readWinList();
          // _readInitPos();
          return const MaterialApp(home: Splash());
        } else {
          return MaterialApp(
              theme: ThemeData(
                primarySwatch: Colors.blue,
                brightness: Brightness.light,
              ),
              darkTheme: ThemeData(
                  brightness: Brightness.dark,
                  primarySwatch: Colors.blue
              ),
              home: Scaffold(
                body: SafeArea(
                  child: Column(
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          child: VerticalCardPager(
                              titles: titles,
                              // required
                              images: images,
                              // required
                              textStyle: TextStyle(color: themeTextColor,
                                  fontWeight: FontWeight.bold),
                              // optional
                              onPageChanged: (page) { // optional
                              },
                              onSelectedItem: (index) {
                                _readInitPos();
                                _readWinList();
                                _readListMap();
                                if (index == 0) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) =>
                                        PrayTrainigPage(
                                            db, list, winList, winCounter)),
                                  );
                                } else if (index == 1) {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) =>
                                        PrayFull(db, initPos)),
                                  );
                                } else if (index == 2) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) =>
                                        PrayMemoList(title: 'memo')),
                                  );
                                } else if (index == 3) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => LinkList()),
                                  );
                                }
                              },
                              initialPage: 0,
                              // optional
                              align: ALIGN.CENTER // optional
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
          );
        }
      }
    );
  }

  Future<Database> initDatabase() async {
    return openDatabase(
        join(await getDatabasesPath(), 'params_database.db'),
        onCreate: (db, version) {
          return db.execute(
            "CREATE TABLE params(pray TEXT PRIMARY KEY, param1 TEXT, param2 TEXT, param3 TEXT, param4 TEXT, param5 TEXT)",);
        },
        version: 1
    );
  }

  // List<String>을 List<Map>으로 변환해주는 함수
  List<Map<String,dynamic>> toListMap(List<String> data) {
    List<Map<String,dynamic>> ret = [];
    log("toListMap:"+data.length.toString());
    for (int i = 0; i < data.length; i++) {
      ret.add(json.decode(data[i]));
    }
    return ret;
  }

  _readInitPos() async {
    final prefs = await SharedPreferences.getInstance();
    const key = 'initPos';
    final value = prefs.getDouble(key) ?? 0;
    print('read : ' + value.toString());
    initPos = value;
  }

  //로컬에 있는 데이터를 읽는 함수
  _readListMap() async {
    final prefs = await SharedPreferences.getInstance();
    const key = 'listMap';
    final value = prefs.getStringList(key);
    try {
      if (value!.isNotEmpty) {
        list = toListMap(value);
      } else {
        list = getInitList();
      }
    } catch (e) {
      return 0;
    }
  }

  _readWinList() async {
    final prefs = await SharedPreferences.getInstance();
    const listKey = 'winList';
    final value = prefs.getStringList(listKey);
    final win = prefs.getInt('winCounter');
    try {
      if (value!.isNotEmpty) {
        winList = value;
      } else {
        winList = [];
      }

      if (win != null) {
        winCounter = win;
      }
    } catch (e) {
      return 0;
    }
  }

  static List<Map<String,dynamic>> getInitList() {
    return [
      {'homeland':'1. 나라를 위한 기도'},
      {'church':'2. 교회를 위한 기도'},
      {'pastor':'3. 담임목사님을 위한 기도'},
      {'cell':'4. 목장과 목장원을 위한 기도'},
      {'believer':'5. 태신자를 위한 기도'},
      {'person':'6. 사람을 위한 기도'},
      {'home':'7. 가정을 위한 기도'},
      {'husband':'8. 남편을 위한 기도'},
      {'wife':'9. 아내를 위한 기도'},
      {'parents':'10. 부모님을 위한 기도'},
      {'children':'11. 자녀를 위한 기도'},
      {'personal_1':'12. 개인기도'},
      {'personal_2':'13. 개인기도2'},
      {'repentance':'14. 회개기도'},
      {'spiritual_power':'15. 영적인 힘을 얻기 위한 기도'},
      {'temptations':'16. 시험이 있을 때 드리는 기도'},
      {'tarry':'17. 기도가 잘 되지 않을 때 드리는 기도'},
      {'tired':'18. 삶에 지칠 때 드리는 기도'},
      {'thanks':'19. 감사할 때 드리는 기도'},
      {'healing':'20. 몸이 아플 때 드리는 기도'},
      {'spouse':'21. 부부간에 불화가 있을 때 드리는 기도'},
      {'money':'22. 물질적인 어려움에 있을 때 드리는 기도'},
      {'business':'23. 사업을 위한 기도'},
      {'dawn':'24. 하루를 시작하며 드리는 기도'},
      {'night':'25. 하루를 마감하며 드리는 기도'},
      {'devil':'26. 마귀를 물리치는 기도'},
      {'disease':'27. 질병을 치료하는 기도'}
    ];
  }
}

class Splash extends StatelessWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool lightMode =
        MediaQuery
            .of(context)
            .platformBrightness == Brightness.light;
    return Scaffold(
        backgroundColor:
        lightMode ? const Color(0xffe1f5fe) : const Color(0xff042a49),
        // body: Center(
        //     child: Image.asset('repo/screen.PNG')
        // ),
        body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('repo/imgmain_praytrainingbookN.png'),
                  fit: BoxFit.cover
              )
          ),
        )
    );
  }
}

class Init {
  Init._();

  static final instance = Init._();

  Future initialize() async {
    // This is where you can initialize the resources needed by your app while
    // the splash screen is displayed.  Remove the following example because
    // delaying the user experience is a bad design practice!
    await Future.delayed(const Duration(seconds: 2));
  }
}


