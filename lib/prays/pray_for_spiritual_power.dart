import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pray_training/pray_list.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../bottom_navi.dart';
import '../pray_body.dart';

class PrayForSpiritualPower extends StatefulWidget {
  List<Map<String, dynamic>> list;
  List<String> winList;
  Function callback;

  PrayForSpiritualPower(this.list, this.winList, this.callback);

  @override
  State<StatefulWidget> createState() => _PrayForSpiritualPower();
}

class _PrayForSpiritualPower extends State<PrayForSpiritualPower> {
  late List<Map<String,dynamic>> list;
  int index = -1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    list = widget.list;
    index = getIndex(list, 'spiritual_power');
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('15. 영적인 힘을 얻기 위한 기도'),
      ),
      drawer: PrayList(),
      bottomNavigationBar: BottomNavi(list, index),
      body: PrayBody(widget.winList, 'spiritual_power', getPray(), widget.callback),
    );
  }

  Future<List<TextSpan>> getPray() async {
    String? param = 'NONE';

    final String prayContent =
          '1) 전능하신 하나님! 하나님은 거룩한 분이십니다.\n'
        '하나님 아버지의 이름이 나를 통하여 거룩히 여김 받으시기를 원합니다.\n'
        '\n'
        '2) 하나님 나라를 창조하시고 사람의 믿음을 보시고 은혜로 구원하여 주심을 감사드립니다.\n'
        '영원한 하나님의 나라가 나에게 이루어지기를 원합니다.\n'
        '그리고 마음의 천국인 의와 평강과 희락이 마음속에 항상 있게 하옵소서.\n'
        '\n'
        '3) 하나님의 뜻이 하늘에서 이루어진 것 같이 나를 통하여 이 땅에서 이루어지기를 원합니다.\n'
        '\n'
        '4) 하나님, 이 시간에 내 마음속에 들어오셔서 나의 하나님이 되어주시고 나의 죄를 용서하시며 영생의 길로, 복된 길로 인도하여 주옵소서.\n'
        '하나님은 나의 하나님이십니다.\n'
        '하나님은 나의 전능자이십니다.\n'
        '하나님은 나의 창조주이십니다.\n'
        '하나님은 나의 구원자이십니다.\n'
        '하나님은 나의 치료자이십니다.\n'
        '하나님은 나의 생명이십니다.\n'
        '하나님은 나의 소망이십니다.\n'
        '하나님은 나의 평안이십니다.\n'
        '하나님은 나의 능력이십니다.\n'
        '하나님은 나의 축복이십니다.\n'
        '하나님은 나의 반석이시며, 산성이십니다.\n'
        '하나님은 나의 요새이시며, 피난처이십니다.\n'
        '나의 힘이 되신 하나님을 사랑합니다.\n'
        '나의 평생에 주의 인자하심과 성실하심 속에 거하게 하옵소서.\n'
        '\n'
        '5) 하나님! 다른 사람의 죄를 용서합니다.\n'
        '나에게 아픔과 상처를 주어 분노와 혈기를 일이키며 미움과 증오를 갖게 했던 사람을 용서합니다.\n'
        '그를 축복합니다.\n'
        '그 사람에게 말과 행동으로 분노와 혈기를 일으켰던 악한 영의 세력을 예수님의 이름으로 결박하사 그의 삶에서 물리쳐 주시고, 그의 행동과 입술의 열매가 믿음으로 아름답게 맺히도록 성령의 충만함으로 축복하옵소서.\n'
        '\n'
        '6) 하나님! 다른 사람의 죄를 용서해 준 것 같이 나의 말과 행동과 거짓과 욕심과 이기적인 마음과 혈기와 분노와 미움의 죄를 사하여 주옵소서.\n'
        '하나님만이 죄를 사하는 권세가 있는 줄 믿습니다.\n'
        '\n'
        '7) 하나님! 내가 이런 말과 행동으로 인하여 시험에 들지 않도록 내 마음을 지켜 주시기를 원합니다.\n'
        '사탄의 시험에 버려두지 마옵소서.\n'
        '\n'
        '8) 하나님! 나의 마음속에 있는 용서하지 못하는 악과 분노와 미움과 혈기의 악에서 구원하여 주옵소서.\n'
        '나는 연약하오니 하나님께서 악에 빠지지 않게 하옵소서.\n'
        '\n'
        '9) 하나님의 나라와 권세와 영광이 영원히 하나님 아버지께 있사오며,\n'
        '\n'
        '10) 예수님의 이름으로 기도드립니다. 아멘';

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