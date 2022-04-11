import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:pray_training/main_page.dart';
import 'package:pray_training/params.dart';
import 'package:sqflite/sqflite.dart';
import 'package:drag_and_drop_gridview/devdrag.dart';
import 'package:flutter/rendering.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:pray_training/prays/pray_for_tarry.dart';
import 'package:pray_training/prays/pray_for_believer.dart';
import 'package:pray_training/prays/pray_for_business.dart';
import 'package:pray_training/prays/pray_for_cell.dart';
import 'package:pray_training/prays/pray_for_children.dart';
import 'package:pray_training/prays/pray_for_church.dart';
import 'package:pray_training/prays/pray_for_dawn.dart';
import 'package:pray_training/prays/pray_for_devil.dart';
import 'package:pray_training/prays/pray_for_disease.dart';
import 'package:pray_training/prays/pray_for_healing.dart';
import 'package:pray_training/prays/pray_for_home.dart';
import 'package:pray_training/prays/pray_for_homeland.dart';
import 'package:pray_training/prays/pray_for_husband.dart';
import 'package:pray_training/prays/pray_for_money.dart';
import 'package:pray_training/prays/pray_for_night.dart';
import 'package:pray_training/prays/pray_for_parents.dart';
import 'package:pray_training/prays/pray_for_pastor.dart';
import 'package:pray_training/prays/pray_for_person.dart';
import 'package:pray_training/prays/pray_for_personal_1.dart';
import 'package:pray_training/prays/pray_for_personal_2.dart';
import 'package:pray_training/prays/pray_for_repentance.dart';
import 'package:pray_training/prays/pray_for_spiritual_power.dart';
import 'package:pray_training/prays/pray_for_spouse.dart';
import 'package:pray_training/prays/pray_for_temptations.dart';
import 'package:pray_training/prays/pray_for_thanks.dart';
import 'package:pray_training/prays/pray_for_tired.dart';
import 'package:pray_training/prays/pray_for_wife.dart';
import 'package:pray_training/link_list.dart';

import 'confs/conf_believer.dart';
import 'confs/conf_cell.dart';
import 'confs/conf_children.dart';
import 'confs/conf_church.dart';
import 'confs/conf_devil.dart';
import 'confs/conf_disease.dart';
import 'confs/conf_home.dart';
import 'confs/conf_husband.dart';
import 'confs/conf_parents.dart';
import 'confs/conf_pastor.dart';
import 'confs/conf_person.dart';
import 'confs/conf_personal_1.dart';
import 'confs/conf_personal_2.dart';
import 'confs/conf_repentance.dart';
import 'confs/conf_spouse.dart';
import 'confs/conf_wife.dart';
import 'main.dart';

class PrayTrainigPage extends StatefulWidget {
  final Future<Database> db;
  List<Map<String,dynamic>> list;
  List<String> winList;
  int winCounter;
  PrayTrainigPage(this.db, this.list, this.winList, this.winCounter);

  @override
  State<StatefulWidget> createState() => _PrayTrainigPage();
}

class _PrayTrainigPage extends State<PrayTrainigPage> {
  late List<Map<String, dynamic>> list = widget.list;
  late List<String> winList = widget.winList;
  late int winCounter = widget.winCounter;

  Future<List<Params>>? params;

  int pos = -1;
  late List<Map<String, dynamic>> tmpList;
  ScrollController? _scrollController;
  int variableSet = 0;
  late double width;
  late double height;

  final _inputTextController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    _inputTextController.dispose();
    super.dispose();
  }

  void callback(List<String> winList) {
    setState(() {
      this.winList = winList;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    params = getParams();
    tmpList = [...list];
  }

  @override
  Widget build(BuildContext context) {
    Future<Database> database = initDatabase();
    // TODO: implement build
    return MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.blue,
          brightness: Brightness.light,
        ),
        darkTheme: ThemeData(
            brightness: Brightness.dark,
            primarySwatch: Colors.blue
        ),
        routes: {
          '/homeland': (context) => PrayForHomeland(list, winList, callback),
          '/church': (context) => PrayForChurch(database, list, winList, callback),
          '/pastor': (context) => PrayForPastor(database, list, winList, callback),
          '/cell': (context) => PrayForCell(database, list, winList, callback),
          '/believer': (context) => PrayForBeliever(database, list, winList, callback),
          '/person': (context) => PrayForPerson(database, list, winList, callback),
          '/home': (context) => PrayForHome(database, list, winList, callback),
          '/husband': (context) => PrayForHusband(database, list, winList, callback),
          '/wife': (context) => PrayForWife(database, list, winList, callback),
          '/parents': (context) => PrayForParents(database, list, winList, callback),
          '/children': (context) => PrayForChildren(database, list, winList, callback),
          '/personal_1': (context) => PrayForPersonal1(database, list, winList, callback),
          '/personal_2': (context) => PrayForPersonal2(database, list, winList, callback),
          '/repentance': (context) => PrayForRepentance(database, list, winList, callback),
          '/spiritual_power': (context) => PrayForSpiritualPower(list, winList, callback),
          '/temptations': (context) => PrayForTemptations(list, winList, callback),
          '/tarry': (context) => PrayForTarry(list, winList, callback),
          '/tired': (context) => PrayForTired(list, winList, callback),
          '/thanks': (context) => PrayForThanks(list, winList, callback),
          '/healing': (context) => PrayForHealing(list, winList, callback),
          '/spouse': (context) => PrayForSpouse(database, list, winList, callback),
          '/money': (context) => PrayForMoney(list, winList, callback),
          '/business': (context) => PrayForBusiness(list, winList, callback),
          '/dawn': (context) => PrayForDawn(list, winList, callback),
          '/night': (context) => PrayForNight(list, winList, callback),
          '/devil': (context) => PrayForDevil(database, list, winList, callback),
          '/disease': (context) => PrayForDisease(database, list, winList, callback),
          '/conf/church': (context) => ConfChurch(database),
          '/conf/pastor': (context) => ConfPastor(database),
          '/conf/person': (context) => ConfPerson(database),
          '/conf/cell': (context) => ConfCell(database),
          '/conf/believer': (context) => ConfBeliever(database),
          '/conf/home': (context) => ConfHome(database),
          '/conf/husband': (context) => ConfHusband(database),
          '/conf/parents': (context) => ConfParents(database),
          '/conf/wife': (context) => ConfWife(database),
          '/conf/children': (context) => ConfChildren(database),
          '/conf/personal_1': (context) => ConfPersonal1(database),
          '/conf/personal_2': (context) => ConfPersonal2(database),
          '/conf/repentance': (context) => ConfRepentance(database),
          '/conf/spouse': (context) => ConfSpouse(database),
          '/conf/devil': (context) => ConfDevil(database),
          '/conf/disease': (context) => ConfDisease(database),
        },
        home: Scaffold(
            appBar: AppBar(
                title: const Text('기도훈련집'), automaticallyImplyLeading: false,
                centerTitle: true,
                elevation: 0.0,
                leading: IconButton(
                  icon: Icon(Icons.home_filled),
                  onPressed: (){
                    Navigator.pushReplacement(
                      context,
                      // MaterialPageRoute(builder: (context) => MainPage(database, list, winList, winCounter)),
                      MaterialPageRoute(builder: (context) => MainPage(false)),
                    );
                  },
                ),
                // actions: [
                //   Padding(
                //     padding: EdgeInsets.fromLTRB(10, 0, 20, 0),
                //     child: SizedBox(
                //       child: TextButton(
                //         onPressed: (){
                //           Navigator.push(
                //             context,
                //             MaterialPageRoute(builder: (context) => LinkList()),
                //           );
                //         },
                //         child: Text("양육교재", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                //       )
                //     ),
                //   )
                // ]
            ),
            drawer: LinkList(),
            // bottomNavigationBar: SelectBottom(0),
            body: Column(

                children: <Widget> [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        '기도승리',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      SizedBox(
                        width: 60,
                        child: FutureBuilder(
                            future: _loadWin(),
                            builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
                              _inputTextController.text = '${snapshot.data}';
                              return TextField(
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                                textAlign: TextAlign.end,
                                keyboardType: TextInputType.number,
                                controller: _inputTextController,
                                onChanged: (text) {
                                  _saveWin(int.parse(text));
                                },
                              );
                            }
                        ),
                      ),
                      Text(
                        '독',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                    ]
                  ),
                  Expanded(
                    child: DragAndDropGridView(
                      controller: _scrollController,
                      itemCount: 27,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        childAspectRatio: 5 / 3,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                      ),
                      padding: const EdgeInsets.all(8.0),
                      itemBuilder: (context, index) =>
                          Opacity(
                              opacity: pos < 0 ? pos == index ? 0.6 : 1 : 1,
                              child: Card(
                                elevation: 2,
                                child: LayoutBuilder(builder: (context, costrains) {
                                  if (variableSet == 0) {
                                    width = costrains.maxWidth;
                                    height = costrains.maxHeight;
                                    variableSet++;
                                  }
                                  return GridTile(
                                      child: GestureDetector(
                                        onTap: () {
                                          Navigator.pushNamed(context,
                                              '/' + list[index].keys.first);
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.all(3.0),
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  width: 2,
                                                  color: ((winList).contains(list[index].keys.first))
                                                      ? Colors.lightGreen
                                                      : Colors.orange
                                              )
                                          ),
                                          child: Text(
                                            list[index].values.first,
                                            style: const TextStyle(fontSize: 15,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      )
                                  );
                                }),
                              )
                          ),
                      onWillAccept: (oldIndex, newIndex) {
                        list = [...tmpList];
                        int indexOfFirstItem = list.indexOf(list[oldIndex]);
                        int indexOfSecondItem = list.indexOf(list[newIndex]);

                        if (indexOfFirstItem > indexOfSecondItem) {
                          for (int i = list.indexOf(list[oldIndex]); i >
                              list.indexOf(list[newIndex]); i--) {
                            var tmp = list[i - 1];
                            list[i - 1] = list[i];
                            list[i] = tmp;
                          }
                        } else {
                          for (int i = list.indexOf(list[oldIndex]); i <
                              list.indexOf(list[newIndex]); i++) {
                            var tmp = list[i + 1];
                            list[i + 1] = list[i];
                            list[i] = tmp;
                          }
                        }
                        setState(() {
                          pos = newIndex;
                          _saveListMap(list);
                        });
                        return true;
                      },
                      onReorder: (oldIndex, newIndex) {
                        list = [...tmpList];
                        int indexOfFirstItem = list.indexOf(list[oldIndex]);
                        int indexOfSecondItem = list.indexOf(list[newIndex]);

                        if (indexOfFirstItem > indexOfSecondItem) {
                          for (int i = list.indexOf(list[oldIndex]); i >
                              list.indexOf(list[newIndex]); i--) {
                            var tmp = list[i - 1];
                            list[i - 1] = list[i];
                            list[i] = tmp;
                          }
                        } else {
                          for (int i = list.indexOf(list[oldIndex]); i <
                              list.indexOf(list[newIndex]); i++) {
                            var tmp = list[i + 1];
                            list[i + 1] = list[i];
                            list[i] = tmp;
                          }
                        }
                        tmpList = [...list];
                        setState(() {
                          pos = -1;
                          _saveListMap(list);
                        });
                      },
                    )
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      // OutlinedButton(
                      //     onPressed: (){
                      //       FlutterDialog(context, 'reset');
                      //     },
                      //     child: Text("초기화"),
                      //     style: OutlinedButton.styleFrom(
                      //         fixedSize: Size(150,10)
                      //     )
                      // ),
                      OutlinedButton(
                          onPressed: (){
                            FlutterDialog(context, 'win');
                          },
                          child: Text("전체1독"),
                          style: OutlinedButton.styleFrom(
                              fixedSize: Size(200,10)
                          )
                      )
                    ]
                  )
              ]
            )
      )
    );
  }

  Future<List<Params>> getParams() async {
    final Database database = await widget.db;
    final List<Map<String, dynamic>> maps = await database.query('params');

    if (maps.isEmpty) {
      var map = {
        'pray': 'pray'
      };

      maps.add(map);
    }

    return List.generate(maps.length, (i) {
      // int active = maps[i]['active'] == 1 ? 1 : 0;
      return Params(
          pray: maps[i]['pray'].toString(),
          param1: maps[i]['param1'].toString(),
          param2: maps[i]['param2'].toString(),
          param3: maps[i]['param3']);
    });
  }

  Future<Database> initDatabase() async {
    return openDatabase(
        join(await getDatabasesPath(), 'params_database.db'),
        onCreate: (db, version) {
          return db.execute("CREATE TABLE params(pray TEXT PRIMARY KEY, param1 TEXT, param2 TEXT, param3 TEXT, param4 TEXT, param5 TEXT)",);
        },
        version: 1
    );
  }

// List<Map>를 List<String>으로 변환해주는 함수
  List<String> toStringList(List<Map<String,dynamic>> data) {
    List<String> ret = [];
    for (int i = 0; i < data.length; i++) {
      ret.add(json.encode(data[i]));
    }
    return ret;
  }

//로컬에 저장해주는 함수
  _saveListMap(List<Map<String,dynamic>> listMap) async {
    final prefs = await SharedPreferences.getInstance();
    const key = 'listMap';
    final value = toStringList(listMap);
    prefs.setStringList(key, value);
  }

  _saveWinListReset() async {
    final prefs = await SharedPreferences.getInstance();
    const key = 'winList';
    prefs.setStringList(key, []);
    callback([]);
  }

  _saveWin(int cnt) async {
    final prefs = await SharedPreferences.getInstance();
    const listKey = 'winList';
    const countKey = 'winCounter';
    var prefInt = cnt == -1 ? winCounter+1 : cnt;
    prefs.setInt(countKey, prefInt);
    if (cnt == -1) {
      prefs.setStringList(listKey, []);
      setState(() {
        winList = [];
        winCounter = prefInt;
      });
    }
  }

  Future<int> _loadWin() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var value = pref.getInt('winCounter') ?? 0;
    return value;
  }

  void FlutterDialog(BuildContext context, String type) {
    showDialog(
        context: context,
        //barrierDismissible - Dialog를 제외한 다른 화면 터치 x
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(type == 'reset' ? "기도승리 초기화" : "전체1독 승리"),
            content: Text(type == 'reset' ? "기도승리 체크를 초기화 하시겠습니까?" : "전체1독 하셨나요?"),
            actions: <Widget>[
              FlatButton(
                child: Text("네"),
                onPressed: () {
                  type == 'reset' ? _saveWinListReset() : _saveWin(-1);
                  Navigator.pop(context);
                },
              ),
              FlatButton(
                child: Text("아니요"),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
  }
}