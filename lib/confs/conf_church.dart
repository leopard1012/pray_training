import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../params.dart';
import '../pray_list.dart';

class ConfChurch extends StatefulWidget {
  final Future<Database> db;
  ConfChurch(this.db);

  @override
  State<StatefulWidget> createState() => _ConfChurch();
}

class _ConfChurch extends State<ConfChurch> {
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

  final _inputTextController1 = TextEditingController();

  var _selectedPray = 'church';

  Future<Params>? params;
  late Map<String, List<String>> pageParam;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    params = getParams(_selectedPray);
    params!.then((value) {
      if (value.param1 != null) {
        _inputTextController1.text = value.param1.toString();
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _inputTextController1.dispose();
    super.dispose();
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
//debug 모드로 해서 여기 넘어오는거 확인필요
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title: Text('기도입력'),
          leading:  IconButton(
              onPressed: () {
                Navigator.pop(context); //뒤로가기
              },
              icon: Icon(Icons.arrow_back)
          ),
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
                    Navigator.pushReplacementNamed(context, '/conf/' + value.toString());
                  });
                },
              ),
            ),
            Padding (
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _inputTextController1,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: '중보기도문',
                ),
              ),
            ),
            Padding (
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  child: const Text('저장'),
                  onPressed: (){
                    Params param = Params(
                      pray: 'church',
                      param1: _inputTextController1.text
                    );
                    _insertData(param);
                    flutterToast();
                    Navigator.pushReplacementNamed(context, '/'+_selectedPray);
                  },
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

  void flutterToast() {
    Fluttertoast.showToast(msg: '저장하였습니다.',
    gravity: ToastGravity.BOTTOM,
    backgroundColor: Colors.grey,
    fontSize: 20.0,
    textColor: Colors.black,
    toastLength: Toast.LENGTH_SHORT);
  }

  Future<Params> getParams(String prayType) async {
    final Database database = await widget.db;
    final List<Map<String, dynamic>> maps = await database.query('params');

    Params p = Params(pray: prayType);

    List.generate(maps.length, (i) {
      if (prayType == maps[i]['pray'].toString()) {
        p = Params(
            pray: maps[i]['pray'].toString(),
            param1: maps[i]['param1'].toString(),
            param2: maps[i]['param2'].toString(),
            param3: maps[i]['param3'].toString(),
            param4: maps[i]['param4'],
            param5: maps[i]['param5']
        );
      }
    });

    return p;
  }
}