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

  final _prayNameList = [
    '1. 나라를 위한 기도',
    '2. 교회를 위한 기도',
    '3. 담임목사님을 위한 기도',
    '4. 목장과 목장원을 위한 기도',
    '5. 태신자를 위한 기도',
    '6. 사람을 위한 기도',
    '7. 가정을 위한 기도',
    '8. 남편을 위한 기도',
    '9. 아내를 위한 기도',
    '10. 부모님을 위한 기도',
    '11. 자녀를 위한 기도',
    '12. 개인기도',
    '13. 개인기도2',
    '14. 회개기도',
    '15. 영적인 힘을 얻기 위한 기도',
    '16. 시험이 있을 때 드리는 기도',
    '17. 기도가 잘 되지 않을 때 드리는 기도',
    '18. 삶에 지칠 때 드리는 기도',
    '19. 감사할 때 드리는 기도',
    '20. 몸이 아플 때 드리는 기도',
    '21. 부부간에 불화가 있을 때 드리는 기도',
    '22. 물질적인 어려움에 있을 때 드리는 기도',
    '23. 사업을 위한 기도',
    '24. 하루를 시작하며 드리는 기도',
    '25. 하루를 마감하며 드리는 기도',
    '26. 마귀를 물리치는 기도',
    '27. 질병을 치료하는 기도'
  ];

  final _prayCodeList = [
    'homeland','church','pastor','cell','believer','person','home','husband','wife',
    'parents','children','personal_1','personal_2','repentance','spiritual_power','temptations','tarry','tired',
    'thanks','healing','spouse','money','business','dawn','night','devil','disease'
  ];

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
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title: const Text('Main'),
          automaticallyImplyLeading: false
        ),
        // body: GridView.builder(
        //     padding: const EdgeInsets.all(8.0),
        //     itemCount: 27, //item 개수
        //     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        //     crossAxisCount: 3, //1개행에 보여줄 item 개수
        //     childAspectRatio: 5 / 3, //가로 / 세로 비율
        //     mainAxisSpacing: 10, //수평 padding
        //     crossAxisSpacing: 10, //수직 padding
        //   ),
        //   itemBuilder: (BuildContext context, int index) {
        //     return GestureDetector(
        //       onTap: () {
        //         Navigator.pushNamed(context, '/' + _prayCodeList[index]);
        //       },
        //       child: Container(
        //         padding: const EdgeInsets.all(3.0),
        //         decoration: BoxDecoration(
        //           border: Border.all(
        //             width: 2,
        //             color: Colors.orange
        //           )
        //         ),
        //         // color: Colors.redAccent,
        //         child: Text(
        //           _prayNameList[index],
        //           style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        //         ),
        //       ),
        //     );
        //   }
        // ),
      body: Column(
        children: <Widget>[
          const Text("TTTTTTTTTTTTTTTTTTTTTTTTTTT"),
          Expanded(child: GridView.builder(
                padding: const EdgeInsets.all(8.0),
                itemCount: 27, //item 개수
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3, //1개행에 보여줄 item 개수
                childAspectRatio: 5 / 3, //가로 / 세로 비율
                mainAxisSpacing: 10, //수평 padding
                crossAxisSpacing: 10, //수직 padding
              ),
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/' + _prayCodeList[index]);
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
                      _prayNameList[index],
                      style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                  ),
                );
              }
            )
          )
        ]
      )
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   List<DropdownMenuItem> prayList = [];
  //
  //   for (int i = 0 ; i < _prayCodeList.length ; i++) {
  //     prayList.add(new DropdownMenuItem(
  //         value: _prayCodeList[i],
  //         child: Text(_prayNameList[i]),
  //     ));
  //   }
  //
  //   // TODO: implement build
  //   return Scaffold(
  //       appBar: AppBar(
  //         title: Text('APPBAR'),
  //       ),
  //       drawer: PrayList(),
  //       body: Padding (
  //         padding: const EdgeInsets.all(8.0),
  //           child: DropdownButton<dynamic>(
  //             value: _selectedPray,
  //             items: prayList,
  //             onChanged: (value) {
  //               setState(() {
  //                 _selectedPray = value.toString();
  //                 Navigator.pushReplacementNamed(context, '/conf/' + value.toString());
  //               });
  //             },
  //           )
  //       )
  //   );
  // }

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