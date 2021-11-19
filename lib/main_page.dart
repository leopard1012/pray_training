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
        body: Center(
          child: FutureBuilder<List<Params>>(
            future: params,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                Params p = snapshot.data!.asMap().values.elementAt(0);
                return Text('text : ${p.param1}');
              } else {
                return Text('tttt');
              }
            },
          ),
          // child: Text('child'),
        )
    );
  }

  Future<List<Params>> getParams() async {
    final Database database = await widget.db;
    final List<Map<String, dynamic>> maps = await database.query('params');

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