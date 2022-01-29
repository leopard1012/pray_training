import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pray_training/pray_list.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

import '../bottom_navi.dart';
import '../params.dart';

class PrayForHome extends StatefulWidget {
  final Future<Database> db;
  List<Map<String,dynamic>> list;
  Function callback;

  PrayForHome(this.db, this.list, this.callback);

  @override
  State<StatefulWidget> createState() => _PrayForHome();
}

class _PrayForHome extends State<PrayForHome> {
  late TextEditingController dataController;
  late List<Map<String,dynamic>> list;
  int index = -1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // params = getParams('spouse');
    dataController = TextEditingController();
    list = widget.list;
    index = getIndex(list, 'home');
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('07. 가정을 위한 기도'),
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
                  builder: (BuildContext context, AsyncSnapshot<List<TextSpan>> snapshot) {
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
    // final Object args = params!.then((value) => value.param1);
    Params params = await getParams('home');
    // final args = await params.the
    String? param = params.param1 ?? '그들(이름)';
    param = param == "" ? '그들(이름)' : param;

    final String prayContent =
        '1) 하나님 아버지는 거룩하십니다.\n'
        '하나님 아버지의 이름이 우리 가정을 통하여 거룩히 여김 받으시기를 원합니다.\n'
        '그러므로 우리 가정이 하나님의 이름을 거룩하게 할 일만 행하게 하옵소서.\n'
        '하나님의 이름을 욕되게 하는 일이 없기를 원합니다.\n'
        '\n'
        '2) 하나님의 나라가 우리 가정에 이루어지기를 원합니다.\n'
        '그리하여 우리 가정 식구들의 마음에 하나님 나라를 이루고 살게 하옵소서\n'
        '또한 우리 가정에 의와 평강과 희락이 이루어져 가정 천국을 이루게 하옵소서.\n'
        '우리 가족이 하나님의 통치를 받으며 하나님의 백성답게 하나님 나라의 법을 지키며 살게 하옵시고, 우리 가족이 하나님의 법을 어기는 일이 없기를 원합니다.\n'
        '그리고 우리 가족이 하나님 나라의 영광을 위하여 일하게 하옵소서.\n'
        '우리 가족을 통하여 하나님의 나라가 세상 모든 사람들에게 전파되기를 원합니다.\n'
        '\n'
        '3) 하나님의 뜻이 하늘에서 이루어진 것 같이 땅에서 우리 가정에 이루어지기를 원합니다.\n'
        '또한 우리 가정이 하나님의 선하신 뜻을 깨닫고 행하기를 기도합니다.\n'
        '하나님의 뜻이 우리 가정을 통하여 온 땅에 전파되기를 원합니다.\n'
        '\n'
        '4) 하나님께서 우리 가정에 평생 동안 일용할 양식을 공급해 주시기를 원합니다.\n'
        '또 세상에서 살아가는데 필요한 것을 공급해 주시기를 원합니다.\n'
        '우리 가정에 현재 필요한 것들이 많이 있습니다.\n'
        '하나님께서 공급하여 주옵소서.\n'
        '또 풍성하여 이웃들에게 나누어 주며 살게 하옵소서.\n'
        '그리고 우리 가정 식구들이 모두 죄인 된 것을 알고 회개하며 죄사함 받고 구원받게 하옵소서.\n'
        '또 교회의 법에 복종하며 불만 불평하지 말고 충성하며 헌신하게 하옵소서.\n'
        '복 받을 일을 하고 입술이나 말로 죄를 지어 복을 잃어버리지 않게 하옵소서.\n'
        '우리 가정을 통하여 주변 사람들이 하나님의 살아계심을 느끼고 예수 그리스도를 영접하고 믿기를 원합니다.\n'
        '우리 가정 식구들을 통하여 전도가 되도록 하옵소서.\n'
        '\n'
        '5) 하나님! 다른 사람의 죄를 용서합니다.\n'
        '우리 가정에 상처를 주고 힘들게 했던 사람들을 용서합니다.\n'
        '예수님의 이름으로 용서합니다.\n'
        '그리고 '+param+'을(를) 축복합니다.\n'
    '그들이 하나님을 경외하고 복 받기를 원합니다.\n'
    '\n'
    '6) 하나님! 다른 사람의 죄를 용서해 준 것 같이 우리 가정의 죄를 사하여 주옵소서.\n'
    '하나님만이 죄를 사하는 권세가 있는 줄 믿습니다.\n'
    '\n'
    '7) 하나님! 우리 가정이 시험에 들지 않기를 원합니다.\n'
    '마귀에게 시험당하지 않기를 원합니다.\n'
    '그러므로 마귀에게 시험 당함을 허락지 마옵소서.\n'
    '또 세상에 시험 당하지 않기를 원합니다.\n'
    '가난이나 물질, 질병, 불행한 사고, 세상 명예, 돈, 권력으로 시험당하지 않기를 원합니다.\n'
    '교회 생활에 시험 들지 않기를 원합니다.\n'
    '목회자나 성도, 교회에서 맡겨진 일들로부터 시험 들지 않기를 원합니다.\n'
    '\n'
    '8) 하나님! 우리 가정을 악에서 구원하여 주옵소서.\n'
    '우리 가정에 하나님의 법을 지키지 않는 악이 있습니다.\n'
    '우리 식구들 중에 악을 버리지 못하고 하나님이 싫어하는 행위를 하는 사람이 있습니다.\n'
    '이 악에서 우리 가정을 구원하여 주옵소서.\n'
    '그리하여 하나님의 법을 지키는 선한 가정이 되게 하옵소서.\n'
    '우리 가정이 세상의 악에 물들지 않도록 지켜 주옵소서.\n'
    '악은 모양이라도 보지 않게 하옵소서.\n'
    '우리 가정은 연약하오니 하나님께서 악을 이길 수 있는 힘을 공급하여 주옵소서.\n'
    '\n'
    '9) 하나님의 나라와 권세와 영광이 영원히, 영원히 하나님 아버지께 있사오며,\n'
    '\n'
    '10) 예수님의 이름으로 기도드립니다. 아멘.';

    final wordToStyle = param;
    final wordStyle = TextStyle(color: Colors.blue);
    final wordTarget = TapGestureRecognizer()..onTapDown = (p) => {Navigator.pushNamed(context, '/conf/home')};
    // final leftOverStyle = Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 20, fontWeight: FontWeight.bold);
    final spans = _getSpans(prayContent, wordToStyle, wordStyle, wordTarget);

    return spans;
  }

  List<TextSpan> _getSpans(String text, String matchWord, TextStyle style, TapGestureRecognizer recognizer) {
    List<TextSpan> spans = [];
    int spanBoundary = 0;

    do {

      // 전체 String 에서 키워드 검색
      final startIndex = text.indexOf(matchWord, spanBoundary);

      // 전체 String 에서 해당 키워드가 더 이상 없을때 마지막 KeyWord부터 끝까지의 TextSpan 추가
      if (startIndex == -1) {
        spans.add(TextSpan(text: text.substring(spanBoundary)));
        return spans;
      }

      // 전체 String 사이에서 발견한 키워드들 사이의 text에 대한 textSpan 추가
      if (startIndex > spanBoundary) {
        print(text.substring(spanBoundary, startIndex));
        spans.add(TextSpan(text: text.substring(spanBoundary, startIndex)));
      }

      // 검색하고자 했던 키워드에 대한 textSpan 추가
      final endIndex = startIndex + matchWord.length;
      final spanText = text.substring(startIndex, endIndex);
      spans.add(TextSpan(text: spanText, style: style, recognizer: recognizer));

      // mark the boundary to start the next search from
      spanBoundary = endIndex;

      // continue until there are no more matches
    }
    //String 전체 검사
    while (spanBoundary < text.length);

    return spans;
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