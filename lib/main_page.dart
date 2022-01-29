import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:pray_training/params.dart';
import 'package:pray_training/pray_list.dart';
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



class MainPage extends StatefulWidget {
  final Future<Database> db;
  List<Map<String,dynamic>> list;
  MainPage(this.db, this.list);

  @override
  State<StatefulWidget> createState() => _MainPage();
}

class _MainPage extends State<MainPage> {
  late List<Map<String,dynamic>> list = widget.list;

  Future<List<Params>>? params;

  int pos = -1;
  late List<Map<String,dynamic>> tmpList;
  ScrollController? _scrollController;
  int variableSet = 0;
  late double width;
  late double height;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // _readListMap();
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
          '/homeland': (context) => PrayForHomeland(list),
          '/church': (context) => PrayForChurch(database,list),
          '/pastor': (context) => PrayForPastor(database,list),
          '/cell': (context) => PrayForCell(database,list),
          '/believer': (context) => PrayForBeliever(database,list),
          '/person': (context) => PrayForPerson(database,list),
          '/home': (context) => PrayForHome(database,list),
          '/husband': (context) => PrayForHusband(database,list),
          '/wife': (context) => PrayForWife(database,list),
          '/parents': (context) => PrayForParents(database,list),
          '/children': (context) => PrayForChildren(database,list),
          '/personal_1': (context) => PrayForPersonal1(database,list),
          '/personal_2': (context) => PrayForPersonal2(database,list),
          '/repentance': (context) => PrayForRepentance(database,list),
          '/spiritual_power': (context) => PrayForSpiritualPower(list),
          '/temptations': (context) => PrayForTemptations(list),
          '/tarry': (context) => PrayForTarry(list),
          '/tired': (context) => PrayForTired(list),
          '/thanks': (context) => PrayForThanks(list),
          '/healing': (context) => PrayForHealing(list),
          '/spouse': (context) => PrayForSpouse(database,list),
          '/money': (context) => PrayForMoney(list),
          '/business': (context) => PrayForBusiness(list),
          '/dawn': (context) => PrayForDawn(list),
          '/night': (context) => PrayForNight(list),
          '/devil': (context) => PrayForDevil(database,list),
          '/disease': (context) => PrayForDisease(database,list),
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
                title: const Text('Main'),
                automaticallyImplyLeading: false
            ),
            body: Center(
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
                  itemBuilder: (context, index) => Opacity(
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
                                  Navigator.pushNamed(context, '/' + list[index].keys.first);
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(3.0),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 2,
                                          color: Colors.orange
                                      )
                                  ),
                                  // color: Colors.redAccent,
                                  child: Text(
                                    list[index].values.first,
                                    style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
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
                      for (int i = list.indexOf(list[oldIndex]) ; i > list.indexOf(list[newIndex]) ; i--) {
                        var tmp = list[i-1];
                        list[i-1] = list[i];
                        list[i] = tmp;
                      }
                    } else {
                      for (int i = list.indexOf(list[oldIndex]) ; i < list.indexOf(list[newIndex]) ; i++) {
                        var tmp = list[i+1];
                        list[i+1] = list[i];
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
                      for (int i = list.indexOf(list[oldIndex]) ; i > list.indexOf(list[newIndex]) ; i--) {
                        var tmp = list[i-1];
                        list[i-1] = list[i];
                        list[i] = tmp;
                      }
                    } else {
                      for (int i = list.indexOf(list[oldIndex]) ; i < list.indexOf(list[newIndex]) ; i++) {
                        var tmp = list[i+1];
                        list[i+1] = list[i];
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
            )
        )
    );
  }

  // void _insertData(Params param) async {
  //   final Database database = await widget.db;
  //   await database.insert('params', param.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  // }

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
// // List<String>을 List<Map>으로 변환해주는 함수
//   List<Map<String,String>> toListMap(List<String> data) {
//     List<Map<String,String>> ret = [];
//     for (int i = 0; i < data.length; i++) {
//       ret.add(json.decode(data[i]));
//     }
//     return ret;
//   }

//로컬에 저장해주는 함수
  _saveListMap(List<Map<String,dynamic>> listMap) async {
    final prefs = await SharedPreferences.getInstance();
    const key = 'listMap';
    final value = toStringList(listMap);
    prefs.setStringList(key, value);
  }

// //로컬에 있는 데이터를 읽는 함수
//   _readListMap() async {
//     final prefs = await SharedPreferences.getInstance();
//     const key = 'listMap';
//     final value = prefs.getStringList(key);
//     try {
//       if (value!.isNotEmpty) {
//         log("TEST Log1 : " + value[0]);
//         list = toListMap(value);
//         log("TEST Log1-1 : " + list[0].toString());
//       } else {
//         log("TEST Log2");
//         list = getInitList();
//       }
//     } catch (e) {
//       return 0;
//     }
//   }

  // static List<Map<String,String>> getInitList() {
  //   return [
  //     {'homeland':'1. 나라를 위한 기도'},
  //     {'church':'2. 교회를 위한 기도'},
  //     {'pastor':'3. 담임목사님을 위한 기도'},
  //     {'cell':'4. 목장과 목장원을 위한 기도'},
  //     {'believer':'5. 태신자를 위한 기도'},
  //     {'person':'6. 사람을 위한 기도'},
  //     {'home':'7. 가정을 위한 기도'},
  //     {'husband':'8. 남편을 위한 기도'},
  //     {'wife':'9. 아내를 위한 기도'},
  //     {'parents':'10. 부모님을 위한 기도'},
  //     {'children':'11. 자녀를 위한 기도'},
  //     {'personal_1':'12. 개인기도'},
  //     {'personal_2':'13. 개인기도2'},
  //     {'repentance':'14. 회개기도'},
  //     {'spiritual_power':'15. 영적인 힘을 얻기 위한 기도'},
  //     {'temptations':'16. 시험이 있을 때 드리는 기도'},
  //     {'tarry':'17. 기도가 잘 되지 않을 때 드리는 기도'},
  //     {'tired':'18. 삶에 지칠 때 드리는 기도'},
  //     {'thanks':'19. 감사할 때 드리는 기도'},
  //     {'healing':'20. 몸이 아플 때 드리는 기도'},
  //     {'spouse':'21. 부부간에 불화가 있을 때 드리는 기도'},
  //     {'money':'22. 물질적인 어려움에 있을 때 드리는 기도'},
  //     {'business':'23. 사업을 위한 기도'},
  //     {'dawn':'24. 하루를 시작하며 드리는 기도'},
  //     {'night':'25. 하루를 마감하며 드리는 기도'},
  //     {'devil':'26. 마귀를 물리치는 기도'},
  //     {'disease':'27. 질병을 치료하는 기도'}
  //   ];
  // }
}