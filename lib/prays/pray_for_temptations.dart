import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pray_training/pray_list.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../bottom_navi.dart';
import '../pray_body.dart';

class PrayForTemptations extends StatefulWidget {
  List<Map<String, dynamic>> list;
  List<String> winList;
  Function callback;

  PrayForTemptations(this.list, this.winList, this.callback);

  @override
  State<StatefulWidget> createState() => _PrayForTemptations();
}

class _PrayForTemptations extends State<PrayForTemptations> {
  late List<Map<String,dynamic>> list;
  int index = -1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    list = widget.list;
    index = getIndex(list, 'temptations');
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('16. 시험이 있을 때 드리는 기도'),
      ),
      drawer: PrayList(),
      bottomNavigationBar: BottomNavi(list, index),
      body: PrayBody(widget.winList, 'temptations', getPray(), widget.callback),
    );
  }

  Future<List<TextSpan>> getPray() async {
    String? param = 'NONE';

    final String prayContent =
        '1) 하나님은 거룩하신 분이십니다.\n'
    '하나님 아버지의 이름이 나를 통하여 거룩히 여김 받으시기를 원합니다.\n'
        '\n'
        '2) 하나님의 나라가 나에게 이루어지기를 원합니다.\n'
        '나의 심령에 의와 평강과 희락이 항상 있게 하옵소서.\n'
        '\n'
        '3) 하나님의 뜻이 하늘에서 이루어진 것 같이 나를 통하여 이 땅에서 이루어지기를 원합니다.\n'
        '\n'
        '4) 하나님! 나의 기도를 방해하며 믿음을 훼방하고, 하나님을 찾지 못하게 하며 또 하나님께 예배하지 못하게 하고 말씀을 듣지도, 읽지도, 깨닫지도 못하게 하여 시험에 들게 하는 악한 영들을 물리쳐 주옵소서.\n'
        '나의 마음속에서 쫓아 주옵소서.\n'
        '그리고 내 삶의 현장인 가정과 직장과 사업장에서 시험 들게 하는 마귀를 물리쳐 주옵소서.\n'
        '마귀가 마음과 입술에 시험 들게 하나이다.\n'
        '물리쳐 주옵소서.\n'
        '나에게 시험이 올지라도 시험에 들지 않고 이기고 물리치는 믿음과 능력을 주옵소서.\n'
        '그리하여 매일 승리하여 감사함으로 살게 하옵소서.\n'
        '시험에 넘어지지 않게 하옵시고 시험을 통하여 연단되어 하나님께 인정받는 굳건한 믿음이 되게 하옵소서.\n'
        '\n'
        '성경 말씀을 믿고 기도합니다.\n'
        '\"시험을 가져오는 모든 악한 영들은 예수님의 이름으로 다 결박되어 내 영혼과 마음과 육체와 가정에서 떠나갈지어다!\n'
        '예수 그리스도의 이름으로 명하노니 떠나가라!\"\n'
        '하나님 아버지! 천군 천사들을 보내주셔서 모든 악한 영들을 진멸하며 가정과 우리의 삶을 보호해 주옵소서.\n'
        '시험과 모든 악으로 인해 연결된 죄의 사슬과 저주의 통로가 없어지게 하옵소서.\n'
        '그리고 축복의 통로가 열리게 하옵소서.\n'
        '\n'
        '6) 하나님! 다른 사람의 죄를 용서해 준 것 같이 나의 죄를 용서하여 주옵소서.\n'
        '하나님만이 죄를 사하는 권세가 있는 줄 믿습니다.\n'
        '\n'
        '7) 하나님! 늘 시험에 들지 않도록 사탄의 시험에 버려두지 마옵소서.\n'
        '\n'
        '8) 하나님! 나를 악에서 구원하여 주옵소서.\n'
        '나의 마음속에 있는 여러 가지 악에서 구원하셔서 시험과 악을 통해 죄를 짓지 않도록 선한 마음으로 인도해 주옵소서.\n'
        '또한 세상의 수많은 악에 물들지 않도록 지켜 주옵소서.\n'
        '\n'
        '9) 하나님의 나라와 권세와 영광이 영원히 하나님 아버지께 있사오며,\n'
        '\n'
        '10) 예수님의 이름으로 기도드립니다.';


    final wordToStyle = param;
    final wordStyle = TextStyle(color: Colors.blue);
    // final leftOverStyle = Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 20, fontWeight: FontWeight.bold);
    final spans = _getSpans(prayContent, wordToStyle, wordStyle);

    return spans;
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