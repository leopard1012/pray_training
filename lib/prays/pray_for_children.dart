import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pray_training/main_page.dart';
import 'package:pray_training/pray_list.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

import '../bottom_navi.dart';
import '../params.dart';

class PrayForChildren extends StatefulWidget {
  final Future<Database> db;
  List<Map<String,dynamic>> list;
  Function callback;

  PrayForChildren(this.db, this.list, this.callback);

  @override
  State<StatefulWidget> createState() => _PrayForChildren();
}

class _PrayForChildren extends State<PrayForChildren> {
  // late TextEditingController dataController;
  late List<Map<String,dynamic>> list;
  int index = -1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // dataController = TextEditingController();
    list = widget.list;
    index = getIndex(list, 'children');
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Scaffold(
      appBar: AppBar(
        title: Text('11. 자녀를 위한 기도'),
      ),
      drawer: PrayList(),
      bottomNavigationBar: BottomNavi(list, index),
      body: Column(
        children: <Widget>[
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(8.0),
              scrollDirection: Axis.vertical,
              child: FutureBuilder(
                  future: getPray(),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<TextSpan>> snapshot) {
                    return Text.rich(
                        TextSpan(
                          style: Theme
                              .of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(
                              fontSize: 20, fontWeight: FontWeight.bold),
                          children: snapshot.data,
                        )
                    );
                  }
              ),
            ),
          ),
          OutlinedButton(
            onPressed: (){
              _saveWinList(index);
              Fluttertoast.showToast(msg: '기도승리');
              if (index < 26) {
                Navigator.pushReplacementNamed(context, '/' + list[index+1].keys.first);
              }
            },
            child: Text("기도승리"),
            style: OutlinedButton.styleFrom(
              fixedSize: Size(300,10)
            )
          )
        ]
      ),
    );
  }

  Future<Params> getParams(String prayType) async {
    final Database database = await widget.db;
    final List<Map<String, dynamic>> maps = await database.query('params');

    Params p = Params(pray: prayType);

    List.generate(maps.length, (i) {
      // int active = maps[i]['active'] == 1 ? 1 : 0;
      if (prayType == maps[i]['pray'].toString()) {
        p = Params(
            pray: maps[i]['pray'].toString(),
            param1: maps[i]['param1'].toString(),
            param2: maps[i]['param2'].toString(),
            param3: maps[i]['param3']);
      }
    });

    return p;
  }

  Future<List<TextSpan>> getPray() async {
    Params params = await getParams('children');

    String? target = params.param1 == null ? "OOO" : params.param1.toString();
    String? withPray = params.param2 == null ? "(자녀를 위한 중보기도)" : params.param2.toString();
    target = target == "" ? 'OOO' : target;
    withPray = withPray == "" ? '(자녀를 위한 중보기도)' : withPray;

    List<TextSpan> textSpanList = [];
    textSpanList.add(TextSpan(text: '1) 하나님 아버지는 거룩하신 분입니다.\n'));
    textSpanList.add(TextSpan(text: '하나님 아버지의 이름이 '));
    textSpanList.add(TextSpan(text: target, style: TextStyle(color: Colors.blue), recognizer: TapGestureRecognizer()..onTapDown = (p) => {Navigator.pushNamed(context, '/conf/children')} ));
    textSpanList.add(TextSpan(text: '을(를) 통하여 거룩히 여김 받으시기를 원합니다.\n'));
    textSpanList.add(TextSpan(text: '그러므로 우리 '));
    textSpanList.add(TextSpan(text: target, style: TextStyle(color: Colors.blue), recognizer: TapGestureRecognizer()..onTapDown = (p) => {Navigator.pushNamed(context, '/conf/children')} ));
    textSpanList.add(TextSpan(text: '이(가) 하나님의 이름을 거룩히 할 일만 행하기를 원합니다.\n'));
    textSpanList.add(TextSpan(text: '\n'));
    textSpanList.add(TextSpan(text: '2) 하나님의 나라가 '));
    textSpanList.add(TextSpan(text: target, style: TextStyle(color: Colors.blue), recognizer: TapGestureRecognizer()..onTapDown = (p) => {Navigator.pushNamed(context, '/conf/children')} ));
    textSpanList.add(TextSpan(text: '에게 이루어지기를 원합니다.\n'));
    textSpanList.add(TextSpan(text: '그리하여 '));
    textSpanList.add(TextSpan(text: target, style: TextStyle(color: Colors.blue), recognizer: TapGestureRecognizer()..onTapDown = (p) => {Navigator.pushNamed(context, '/conf/children')} ));
    textSpanList.add(TextSpan(text: '의 마음에 의와 평강과 희락이 항상 있게 하옵시고, 세상 나라가 마음에 들어가지 않게 하옵소서.\n'));
    textSpanList.add(TextSpan(text: '그리고 '));
    textSpanList.add(TextSpan(text: target, style: TextStyle(color: Colors.blue), recognizer: TapGestureRecognizer()..onTapDown = (p) => {Navigator.pushNamed(context, '/conf/children')} ));
    textSpanList.add(TextSpan(text: '이(가) 하나님의 통치를 받으며 하나님의 백성답게 하나님 나라의 법을 지키며 살게 하옵시고, 몸은 땅에 있지만 마음은 하나님 나라에 두고 살게 하옵소서.\n'));
    textSpanList.add(TextSpan(text: ''));
    textSpanList.add(TextSpan(text: target, style: TextStyle(color: Colors.blue), recognizer: TapGestureRecognizer()..onTapDown = (p) => {Navigator.pushNamed(context, '/conf/children')} ));
    textSpanList.add(TextSpan(text: '이(가) 세상의 영광보다는 하나님 나라의 영광을 위하여 일하게 하옵소서.\n'));
    textSpanList.add(TextSpan(text: '그리고 '));
    textSpanList.add(TextSpan(text: target, style: TextStyle(color: Colors.blue), recognizer: TapGestureRecognizer()..onTapDown = (p) => {Navigator.pushNamed(context, '/conf/children')} ));
    textSpanList.add(TextSpan(text: '을(를) 통하여 하나님의 나라가 세상 모든 사람들에게 전파되기를 원합니다.\n'));
    textSpanList.add(TextSpan(text: '\n'));
    textSpanList.add(TextSpan(text: '3) 하나님의 뜻이 하늘에서 이루어진 것 같이 땅에서 '));
    textSpanList.add(TextSpan(text: target, style: TextStyle(color: Colors.blue), recognizer: TapGestureRecognizer()..onTapDown = (p) => {Navigator.pushNamed(context, '/conf/children')} ));
    textSpanList.add(TextSpan(text: '에게 이루어지기를 원합니다.\n'));
    textSpanList.add(TextSpan(text: '또 '));
    textSpanList.add(TextSpan(text: target, style: TextStyle(color: Colors.blue), recognizer: TapGestureRecognizer()..onTapDown = (p) => {Navigator.pushNamed(context, '/conf/children')} ));
    textSpanList.add(TextSpan(text: '을(를) 통하여 하나님의 선하신 뜻이 땅에서 이루어지기를 기도합니다.\n'));
    textSpanList.add(TextSpan(text: '하나님의 뜻이 '));
    textSpanList.add(TextSpan(text: target, style: TextStyle(color: Colors.blue), recognizer: TapGestureRecognizer()..onTapDown = (p) => {Navigator.pushNamed(context, '/conf/children')} ));
    textSpanList.add(TextSpan(text: '을(를) 통하여 온 땅에 전파되기를 원합니다.\n'));
    textSpanList.add(TextSpan(text: '\n'));
    textSpanList.add(TextSpan(text: '4) 하나님께서 '));
    textSpanList.add(TextSpan(text: target, style: TextStyle(color: Colors.blue), recognizer: TapGestureRecognizer()..onTapDown = (p) => {Navigator.pushNamed(context, '/conf/children')} ));
    textSpanList.add(TextSpan(text: '에게 평생 동안 일용할 양식을 공급해 주시기를 원합니다.\n'));
    textSpanList.add(TextSpan(text: '또 세상에서 살아가는데 필요한 것을 공급해 주시기를 원합니다.\n'));
    textSpanList.add(TextSpan(text: ''));
    textSpanList.add(TextSpan(text: target, style: TextStyle(color: Colors.blue), recognizer: TapGestureRecognizer()..onTapDown = (p) => {Navigator.pushNamed(context, '/conf/children')} ));
    textSpanList.add(TextSpan(text: '이(가) 살아가야 할 모든 생활 속에 축복하여 주옵소서.\n'));
    textSpanList.add(TextSpan(text: '그리고 큰 믿음을 주셔서 사용하시며 건강을 주셔서 항상 하나님을 기쁘게 하는 사람이 되게 하옵소서.\n'));
    textSpanList.add(TextSpan(text: '\n'));
    textSpanList.add(TextSpan(text: withPray, style: TextStyle(color: Colors.blue), recognizer: TapGestureRecognizer()..onTapDown = (p) => {Navigator.pushNamed(context, '/conf/children')} ));
    textSpanList.add(TextSpan(text: '\n'));
    textSpanList.add(TextSpan(text: target, style: TextStyle(color: Colors.blue), recognizer: TapGestureRecognizer()..onTapDown = (p) => {Navigator.pushNamed(context, '/conf/children')} ));
    textSpanList.add(TextSpan(text: '에게 지혜와 총명함을 주셔서 다윗처럼 하나님을 경외하게 하옵소서.\n'));
    textSpanList.add(TextSpan(text: '하나님을 제일 사랑하고 부모를 사랑하게 하옵시며, 기도의 사람이 되게 하옵소서.\n'));
    textSpanList.add(TextSpan(text: '언제나 머리가 되게 하옵시고, 교회와 세상의 리더가 되어 하나님의 뜻대로 모든 것을 새롭게 하는 사람이 되게 하옵소서.\n'));
    textSpanList.add(TextSpan(text: '주고, 섬기고, 대접하고, 사랑할 줄 아는 사람이 되게 하셔서, 이웃들에게 나누어 주며 살게 하옵소서.\n'));
    textSpanList.add(TextSpan(text: '또한 풍성한 물질을 주셔서 하나님을 위하여 언제나 풍성하게 드리게 하옵시며, 모범적으로 충성하고 헌신하는 사람이 되게 하옵소서.\n'));
    textSpanList.add(TextSpan(text: '목사님께 순종하며 섬기는 믿음을 주옵소서.\n'));
    textSpanList.add(TextSpan(text: '부모와 형제, 자매에게 신실한 사람이 되게 하옵시고, 세상에서 믿음으로 살고 존경과 신뢰를 얻는 사람이 되게 하옵소서.\n'));
    textSpanList.add(TextSpan(text: '또 온유와 오래 참음의 은사들을 공급하여 주옵소서.\n'));
    textSpanList.add(TextSpan(text: '또한 '));
    textSpanList.add(TextSpan(text: target, style: TextStyle(color: Colors.blue), recognizer: TapGestureRecognizer()..onTapDown = (p) => {Navigator.pushNamed(context, '/conf/children')} ));
    textSpanList.add(TextSpan(text: '의 주변 사람들이 모두 구원받기를 원합니다.\n'));
    textSpanList.add(TextSpan(text: '그들을 구원하시어 하나님의 일꾼으로 사용하여 주옵소서.\n'));
    textSpanList.add(TextSpan(text: '\n'));
    textSpanList.add(TextSpan(text: '5) 하나님! '));
    textSpanList.add(TextSpan(text: target, style: TextStyle(color: Colors.blue), recognizer: TapGestureRecognizer()..onTapDown = (p) => {Navigator.pushNamed(context, '/conf/children')} ));
    textSpanList.add(TextSpan(text: '의 죄를 용서합니다.\n'));
    textSpanList.add(TextSpan(text: '나에게 상처를 주고 힘들게 하였던 '));
    textSpanList.add(TextSpan(text: target, style: TextStyle(color: Colors.blue), recognizer: TapGestureRecognizer()..onTapDown = (p) => {Navigator.pushNamed(context, '/conf/children')} ));
    textSpanList.add(TextSpan(text: '을(를) 용서합니다.\n'));
    textSpanList.add(TextSpan(text: '예수님의 이름으로 용서합니다.\n'));
    textSpanList.add(TextSpan(text: '그리고 '));
    textSpanList.add(TextSpan(text: target, style: TextStyle(color: Colors.blue), recognizer: TapGestureRecognizer()..onTapDown = (p) => {Navigator.pushNamed(context, '/conf/children')} ));
    textSpanList.add(TextSpan(text: '을(를) 축복합니다.\n'));
    textSpanList.add(TextSpan(text: ''));
    textSpanList.add(TextSpan(text: target, style: TextStyle(color: Colors.blue), recognizer: TapGestureRecognizer()..onTapDown = (p) => {Navigator.pushNamed(context, '/conf/children')} ));
    textSpanList.add(TextSpan(text: '이(가) 하나님을 경외하고 복 받기를 원합니다.\n'));
    textSpanList.add(TextSpan(text: '\n'));
    textSpanList.add(TextSpan(text: '6) 하나님! 다른 사람의 죄를 용서해 준 것 같이 나의 죄를 용서하여 주옵소서.\n'));
    textSpanList.add(TextSpan(text: '하나님만이 죄를 사하는 권세가 있는 줄 믿습니다.\n'));
    textSpanList.add(TextSpan(text: '\n'));
    textSpanList.add(TextSpan(text: '7) 하나님! '));
    textSpanList.add(TextSpan(text: target, style: TextStyle(color: Colors.blue), recognizer: TapGestureRecognizer()..onTapDown = (p) => {Navigator.pushNamed(context, '/conf/children')} ));
    textSpanList.add(TextSpan(text: '이(가) 시험에 들지 않기를 원합니다.\n'));
    textSpanList.add(TextSpan(text: '마귀에게 시험당하지 않기를 원합니다.\n'));
    textSpanList.add(TextSpan(text: '그러므로 마귀에게 시험을 허락지 마옵소서.\n'));
    textSpanList.add(TextSpan(text: '또 세상에서 시험당하지 않기를 원합니다.\n'));
    textSpanList.add(TextSpan(text: '가난이나 물질, 질병, 불행한 사고, 세상 명예, 돈, 권력으로 시험당하지 않기를 원합니다.\n'));
    textSpanList.add(TextSpan(text: '교회 생활에 시험 들지 않기를 원합니다.\n'));
    textSpanList.add(TextSpan(text: '목회자나 성도, 교회에서 맡겨진 일들로부터 시험 들지 않기를 원합니다.\n'));
    textSpanList.add(TextSpan(text: '\n'));
    textSpanList.add(TextSpan(text: '8) 하나님! '));
    textSpanList.add(TextSpan(text: target, style: TextStyle(color: Colors.blue), recognizer: TapGestureRecognizer()..onTapDown = (p) => {Navigator.pushNamed(context, '/conf/children')} ));
    textSpanList.add(TextSpan(text: '을(를) 악에서 구원하여 주옵소서.\n'));
    textSpanList.add(TextSpan(text: ''));
    textSpanList.add(TextSpan(text: target, style: TextStyle(color: Colors.blue), recognizer: TapGestureRecognizer()..onTapDown = (p) => {Navigator.pushNamed(context, '/conf/children')} ));
    textSpanList.add(TextSpan(text: '에게 하나님의 법을 지키지 않는 악이 있습니다.\n'));
    textSpanList.add(TextSpan(text: '이 악에서 '));
    textSpanList.add(TextSpan(text: target, style: TextStyle(color: Colors.blue), recognizer: TapGestureRecognizer()..onTapDown = (p) => {Navigator.pushNamed(context, '/conf/children')} ));
    textSpanList.add(TextSpan(text: '을(를) 구원하여 주옵소서.\n'));
    textSpanList.add(TextSpan(text: ''));
    textSpanList.add(TextSpan(text: target, style: TextStyle(color: Colors.blue), recognizer: TapGestureRecognizer()..onTapDown = (p) => {Navigator.pushNamed(context, '/conf/children')} ));
    textSpanList.add(TextSpan(text: '이(가) 세상의 악에 물들지 않도록 지켜 주옵소서.\n'));
    textSpanList.add(TextSpan(text: '악은 모양이라도 보지 않게 하옵소서.\n'));
    textSpanList.add(TextSpan(text: '세상의 악이 유혹을 해도 물리치고 이기게 하옵소서.\n'));
    textSpanList.add(TextSpan(text: ''));
    textSpanList.add(TextSpan(text: target, style: TextStyle(color: Colors.blue), recognizer: TapGestureRecognizer()..onTapDown = (p) => {Navigator.pushNamed(context, '/conf/children')} ));
    textSpanList.add(TextSpan(text: '은(는) 연약하오니 하나님께서 악을 이길 수 있는 힘을 공급하여 주옵소서.\n'));
    textSpanList.add(TextSpan(text: '\n'));
    textSpanList.add(TextSpan(text: '9) 하나님의 나라와 권세와 영광이 영원히, 영원히 하나님 아버지께 있사오며,\n'));
    textSpanList.add(TextSpan(text: '10) 예수님의 이름으로 기도드립니다.\n'));
    textSpanList.add(TextSpan(text: '\n'));
    textSpanList.add(TextSpan(text: '아멘.\n'));

    return textSpanList;
  }

  int getIndex(List<Map<String,dynamic>> list, String pray) {
    for(int i = 0 ; i < list.length ; i++) {
      if(list[i].keys.first == pray) return i;
    }
    return -1;
  }

  _saveWinList(int index) async {
    final prefs = await SharedPreferences.getInstance();
    const key = 'winList';
    List<String>? value = prefs.getStringList(key) ?? [];
    value.add(index.toString());
    prefs.setStringList(key, value);
    widget.callback(value);
  }
}