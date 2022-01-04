import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../params.dart';
import '../pray_list.dart';

class ConfSpouse extends StatefulWidget {
  final Future<Database> db;
  ConfSpouse(this.db);

  @override
  State<StatefulWidget> createState() => _ConfSpouse();
}

class _ConfSpouse extends State<ConfSpouse> {
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

  var _selectedPray = 'spouse';
  var _selectedParam = '';
  // bool _value = false;

  Future<Params>? params;
  late Map<String, List<String>> pageParam;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    params = getParams(_selectedPray);
    params!.then((value) {
      if (value.param1 != null) {
        _selectedParam = value.param1.toString();
      }
    });
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
// 라디오버튼 기본값 셋팅 하는 방법 확인
// initState를 하기전에 Scaffold 를 실행하는게 문제제
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
              child: Center(
                // child: Column(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: <Widget>[
                //     RadioListTile(
                //       title: Text('남편'),
                //       value: '남편',
                //       groupValue: _selectedParam,
                //       onChanged: (String? value) {
                //         setState(() {
                //           _selectedParam = value!;
                //           // _value = false;
                //         });
                //       },
                //       // selected: this._selectedParam == '남편',
                //       selected: this._selectHusband
                //     ),
                //     RadioListTile(
                //       title: Text('아내'),
                //       value: '아내',
                //       groupValue: _selectedParam,
                //       onChanged: (String? value) {
                //         setState(() {
                //           _selectedParam = value??_selectedParam;
                //         });
                //       },
                //       // selected: this._selectedParam == '아내',
                //       selected: this._selectWife
                //     ),
                //   ],
                // )
                child: RadioGroup(),
              ),
            ),
            Padding (
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  child: const Text('저장'),
                  onPressed: (){
                    Params param = Params(
                        pray: 'spouse',
                        param1: _selectedParam
                    );
                    _insertData(param);
                    flutterToast();
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

class RadioGroup extends StatefulWidget {
  @override
  RadioGroupWidget createState() => RadioGroupWidget();
}

class DataList {
  String data;
  int index;
  DataList({required this.data, required this.index});
}

class RadioGroupWidget extends State {


  String radioItemHolder = '남편';

  int id = 1;

  List<DataList> dList = [
    DataList(data: '남편', index: 1),
    DataList(data: '아내', index: 2),
  ];

  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
            padding : EdgeInsets.all(14.0),
            child: Text('Selected Item = '+'$radioItemHolder', style: TextStyle(fontSize: 23))
        ),
        Expanded(
            child: Container(
              height: 350.0,
              child: Column(
                children:
                dList.map((data) => RadioListTile(
                  title: Text("${data.data}"),
                  groupValue: id,
                  value: data.index,
                  onChanged: (val) {
                    setState(() {
                      radioItemHolder = data.data ;
                      id = data.index;
                    });
                  },
                )).toList(),
              ),
            )
        ),
      ],
    );
  }
}