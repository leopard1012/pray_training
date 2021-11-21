  import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pray_training/params.dart';
import 'package:pray_training/pray_list.dart';
import 'package:sqflite/sqflite.dart';

class MainPage extends StatefulWidget {
  final Future<Database> db;
  MainPage(this.db);

  @override
  State<StatefulWidget> createState() => _MainPage();
}

class _MainPage extends State<MainPage> {
  // Future<SharedPreferences> pref = SharedPreferences.getInstance();

  // Map<String, List<String>> map = {};

  final _prayList = [
    // {'1. 나라를 위한 기도':'homeland'},
    // {'21. 부부간에 불화가 있을 때 드리는 기도':'spouse'}
    'homeland', 'spouse'
  ];
  var _selectedPray = 'spouse';

  Future<List<Params>>? params;
  late Map<String, List<String>> pageParam;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    params = getParams();
  }

  @override
  Widget build(BuildContext context) {
    // Future 안에 있는 List 가져오는거 테스트해야함
    // params!.then((value) =>
    //     for(Map<String, dynamic) map : value) {
    //       if (map.get('pray').equals('/spouse')) {
    //
    //       }
    //     }
    // );

    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title: Text('APPBAR'),
        ),
        drawer: PrayList(),
        body: Padding (
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: DropdownButton(
              value: _selectedPray,
              items: _prayList.map(
                  (value) {
                    return DropdownMenuItem(
                      value: value,
                      child: Text(value),
                    );
                  },
              ).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedPray = value.toString();
                });
              },
              // items: _prayList.map((e) => e.)
            )
          )
        )
    );
  }

  void _insertData(Params param) async {
    final Database database = await widget.db;
    await database.insert('params', param.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
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

// void writeParamFile(String param, String file_path) async {
//   var dir = await getApplicationDocumentsDirectory();
//   var file = await File(dir.path + file_path).writeAsString(param);
// }

// Future<List<String>?> readListFile(String file_path) async {
//   List<String> itemList = [];
//   var key = file_path;
//   SharedPreferences pref = await SharedPreferences.getInstance();
//   bool? firstCheck = pref.getBool(key);
//   var dir = await getApplicationDocumentsDirectory();
//   bool fileExist = await File(dir.path + '/' + key + '.txt').exists();
//
//   if (firstCheck == null || firstCheck == false || fileExist == false) {
//     pref.setBool(key, true);
//     var file = await DefaultAssetBundle.of(context).loadString('repo/' + key + '.txt');
//     File(dir.path + '/' + key + '.txt').writeAsStringSync(file);
//     var array = file.split('\n');
//     for (var item in array) {
//       print(item);
//       itemList.add(item);
//     }
//     return itemList;
//   }


// setState(() {
//   map.putIfAbsent(file_path, () => null)
// });

// }
}