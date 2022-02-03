import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pray_training/pray_list.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

import '../bottom_navi.dart';
import '../params.dart';
import '../pray_body.dart';

class PrayForHusband extends StatefulWidget {
  final Future<Database> db;
  List<Map<String,dynamic>> list;
  List<String> winList;
  Function callback;

  PrayForHusband(this.db, this.list, this.winList, this.callback);

  @override
  State<StatefulWidget> createState() => _PrayForHusband();
}

class _PrayForHusband extends State<PrayForHusband> {
  // late TextEditingController dataController;
  late List<Map<String,dynamic>> list;
  int index = -1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // dataController = TextEditingController();
    list = widget.list;
    index = getIndex(list, 'husband');
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Scaffold(
      appBar: AppBar(
        title: Text('08. 남편을 위한 기도'),
      ),
      drawer: PrayList(),
      bottomNavigationBar: BottomNavi(list, index),
      body: PrayBody(widget.winList, 'husband', getPray(), widget.callback),
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
    Params params = await getParams('husband');

    String? target = params.param1 == null ? "OOO" : params.param1.toString();
    String? withPray = params.param2 == null ? "(남편을 위한 중보기도)" : params.param2.toString();
    target = target == "" ? 'OOO' : target;
    withPray = withPray == "" ? '(남편을 위한 중보기도)' : withPray;

    List<TextSpan> textSpanList = [];
    textSpanList.add(TextSpan(text: '1) 하나님 아버지는 거룩하십니다.\n하나님 아버지의 이름이 남편('));
    textSpanList.add(TextSpan(text: target, style: TextStyle(color: Colors.blue),
        recognizer: TapGestureRecognizer()..onTapDown = (p) => {Navigator.pushNamed(context, '/conf/husband')} ));
    textSpanList.add(TextSpan(text: ')을(를) 통하여 거룩히 여김 받으시기를 원합니다.\n'));
    textSpanList.add(TextSpan(text: '그리고 남편이'));
    textSpanList.add(TextSpan(text: ' 하나님의 이름을 거룩히 여기는 일을 찾아서 하기를 원합니다.\n'));
    textSpanList.add(TextSpan(text: '\n'));
    textSpanList.add(TextSpan(text: '2) 하나님의 나라가 '));
    textSpanList.add(TextSpan(text: '남편에게 이루어지기를 원합니다.'));
    textSpanList.add(TextSpan(text: '그리하여'));
    textSpanList.add(TextSpan(text: ' 남편의 심령에 의와 평강과 희락이 항상 있게 하옵소서.\n'));
    textSpanList.add(TextSpan(text: '항상 의로운 일만 행하게 하시며 마음에 평강이 있어서 여유 있게 웃으며 살게 하시고, 기쁨이 있어서 다른 사람을 즐겁게 하게 하옵소서.\n'));
    textSpanList.add(TextSpan(text: '남편이 하나님의 통치를 받아 하나님 나라의 법을 지키며 살게 하옵시고, 하나님의 법을 어기는 것은 버리게 하옵소서.\n'));
    textSpanList.add(TextSpan(text: '그리고 하나님 나라의 영광을 위하여 일하게 하옵소서.\n'));
    textSpanList.add(TextSpan(text: '또한 남편을 통하여 하나님의 나라가 세상 모든 사람들에게 전파되기를 원합니다.\n\n'));
    textSpanList.add(TextSpan(text: '3) 하나님의 뜻이 하늘에서 이루어진 것 같이 땅에서 남편에게 이루어지기를 원합니다.\n'));
    textSpanList.add(TextSpan(text: '또 남편이 하나님의 뜻을 깨닫고 이루어드리기를 기도합니다.\n'));
    textSpanList.add(TextSpan(text: '하나님의 뜻이 남편을 통하여 온 땅에 전파되기를 원합니다.\n\n'));
    textSpanList.add(TextSpan(text: '4) 하나님께서 남편에게 평생동안 일용할 양식을 공급해 주시기를 원합니다.\n'));
    textSpanList.add(TextSpan(text: '또 세상에서 살아가는데 필요한 것을 공급하여 주시기를 원합니다.\n'));
    textSpanList.add(TextSpan(text: '남편이 하는 일들을 축복하여 주옵소서.\n'));
    textSpanList.add(TextSpan(text: '큰 믿음과 건강을 주옵시며, 항상 하나님을 기쁘게 하는 사람이 되게 하옵소서.\n\n'));
    textSpanList.add(TextSpan(text: withPray, style: TextStyle(color: Colors.blue),
        recognizer: TapGestureRecognizer()..onTapDown = (p) => {Navigator.pushNamed(context, '/conf/husband')} ));
    textSpanList.add(TextSpan(text: '\n남편에게 풍성한 물질을 주셔서 하나님을 위하여 언제나 마음껏 드리게 하옵시며 교회에서 모범적으로 충성하고 헌신하는 사람이 되게 하옵소서.'));
    textSpanList.add(TextSpan(text: '\n목사님께 순종하며 섬기는 믿음을 주옵시고, 성도를 사랑하며 겸손히 섬기는 신앙을 주옵소서.'));
    textSpanList.add(TextSpan(text: '\n가정에 충실하고 믿음의 제사장이 되어 가정을 신앙으로 이끌게 하옵소서.'));
    textSpanList.add(TextSpan(text: '\n아내와 자녀에게 좋은 본이 되게 하옵소서.'));
    textSpanList.add(TextSpan(text: '\n세상에서 믿음으로 살고 존경과 신뢰를 얻는 사람이 되게 하옵소서.'));
    textSpanList.add(TextSpan(text: '\n지혜와 명철을 주옵시고, 사랑과 온유와 오래 참음의 은사들을 공급하여 주옵소서.'));
    textSpanList.add(TextSpan(text: '\n또 풍성하여 이웃들에게 나누어 주며 살게 하옵소서.'));
    textSpanList.add(TextSpan(text: '\n남편의 주변 사람들이 남편을 보고 모두 구원받기를 원합니다.'));
    textSpanList.add(TextSpan(text: '\n그들을 구원하시어 하나님의 일꾼으로 사용하여 주옵소서.'));
    textSpanList.add(TextSpan(text: '\n'));
    textSpanList.add(TextSpan(text: '\n5) 하나님! 남편의 죄를 용서합니다.'));
    textSpanList.add(TextSpan(text: '\n나에게 상처를 주고 힘들게 하였던 남편을 용서합니다.'));
    textSpanList.add(TextSpan(text: '\n예수님의 이름으로 용서합니다.'));
    textSpanList.add(TextSpan(text: '\n그리고 남편을 축복합니다.'));
    textSpanList.add(TextSpan(text: '\n남편이 하나님을 경외하고 복 받기를 원합니다.'));
    textSpanList.add(TextSpan(text: '\n'));
    textSpanList.add(TextSpan(text: '\n6) 하나님! 다른 사람의 죄를 용서해 준 것 같이 나의 죄를 사하여 주옵소서.'));
    textSpanList.add(TextSpan(text: '\n나도 하나님 앞에 죄인입니다.'));
    textSpanList.add(TextSpan(text: '\n하나님만이 죄를 사하는 권세가 있는 줄 믿습니다.'));
    textSpanList.add(TextSpan(text: '\n'));
    textSpanList.add(TextSpan(text: '\n7) 하나님! 남편이 시험에 들지 않기를 원합니다.'));
    textSpanList.add(TextSpan(text: '\n마귀에게 시험당하지 않기를 원합니다.'));
    textSpanList.add(TextSpan(text: '\n그러므로 마귀에게 시험을 허락지 마옵소서.'));
    textSpanList.add(TextSpan(text: '\n또 남편이 세상에 시험당하지 않기를 원합니다.'));
    textSpanList.add(TextSpan(text: '\n물질이나 명예로 시험당하지 않기를 원합니다.'));
    textSpanList.add(TextSpan(text: '\n사람들로 인해 시험 들지 않기를 원합니다.'));
    textSpanList.add(TextSpan(text: '\n신앙생활에서 시험 들지 않기를 원합니다.'));
    textSpanList.add(TextSpan(text: '\n교회 생활과 교인들로 인하여 시험 들지 않기를 원합니다.'));
    textSpanList.add(TextSpan(text: '\n가정에서 시험 들지 않기를 원합니다.'));
    textSpanList.add(TextSpan(text: '\n남편이 시험에 들지 않도록 지켜 주옵소서.'));
    textSpanList.add(TextSpan(text: '\n'));
    textSpanList.add(TextSpan(text: '\n8) 하나님! 남편을 악에서 구원하여 주옵소서.'));
    textSpanList.add(TextSpan(text: '\n남편의 마음속에는 악이 가득합니다.'));
    textSpanList.add(TextSpan(text: '\n악을 주는 사탄의 세력을 쫓아 주옵소서.'));
    textSpanList.add(TextSpan(text: '\n그리고 악에서 남편을 구원하여 선한 마음으로 인도하여 주옵소서.'));
    textSpanList.add(TextSpan(text: '\n또한 남편이 세상의 악에 물들지 않도록 지켜 주옵소서.'));
    textSpanList.add(TextSpan(text: '\n남편은 연약하오니 하나님께서 악을 물리치고 이길 수 있는 힘을 공급하여 주옵소서.'));
    textSpanList.add(TextSpan(text: '\n'));
    textSpanList.add(TextSpan(text: '\n9) 하나님의 나라와 권세와 영광이 영원히, 영원히 하나님 아버지께 있사오며,'));
    textSpanList.add(TextSpan(text: '\n'));
    textSpanList.add(TextSpan(text: '\n10) 예수님의 이름으로 기도드립니다.'));
    textSpanList.add(TextSpan(text: '\n'));
    textSpanList.add(TextSpan(text: '\n아멘.'));

    return textSpanList;
  }

  List<TextSpan> _getSpans(String text, String matchWord, TextStyle style) {
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
      spans.add(TextSpan(text: spanText, style: style));

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