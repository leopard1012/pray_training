import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

import '../params.dart';
import '../pray_list.dart';

class ConfPastor extends StatefulWidget {
  final Future<Database> db;
  ConfPastor(this.db);

  @override
  State<StatefulWidget> createState() => _ConfPastor();
}

class _ConfPastor extends State<ConfPastor> {
  final _prayNameList = [
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
    '21. 부부간에 불화가 있을 때 드리는 기도',
    '26. 마귀를 물리치는 기도',
    '27. 질병을 치료하는 기도'
  ];

  final _prayCodeList = [
    'church','pastor','cell','believer','person','home','husband','wife',
    'parents','children','personal_1','personal_2','repentance','spouse',
    'devil','disease'
  ];

  var _selectedPray = 'pastor';

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

    List<DropdownMenuItem> prayList = [];

    for (int i = 0 ; i < _prayCodeList.length ; i++) {
      prayList.add(DropdownMenuItem(
        value: _prayCodeList[i],
        child: Text(_prayNameList[i]),
      ));
    }

    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title: Text('APPBAR'),
        ),
        drawer: PrayList(),
        body: Column(
          children: <Widget>[
            Padding (
              padding: const EdgeInsets.all(8.0),
              child: DropdownButton<dynamic>(
                value: _selectedPray,
                items: prayList,
                onChanged: (value) {
                  setState(() {
                    _selectedPray = value.toString();
                    Navigator.popAndPushNamed(context, '/conf/' + value.toString());
                  });
                },
              ),
            ),
            Padding (
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: const <Widget>[
                  TextField(
                   decoration: InputDecoration(
                     border: OutlineInputBorder(),
                     labelText: '죄 용서 대상자',
                   ),
                  )
                ],
              )
            )
          ],
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
}