import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pray_training/pray_list.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

import '../bottom_navi.dart';
import '../params.dart';
import '../pray_body.dart';

class PrayForBeliever extends StatefulWidget {
  final Future<Database> db;
  List<Map<String,dynamic>> list;
  List<String> winList;
  Function callback;

  PrayForBeliever(this.db, this.list, this.winList, this.callback);

  @override
  State<StatefulWidget> createState() => _PrayForBeliever();
}

class _PrayForBeliever extends State<PrayForBeliever> {
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
    index = getIndex(list, 'believer');
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Scaffold(
      appBar: AppBar(
        title: Text('05. 태신자를 위한 기도'),
      ),
      drawer: PrayList(),
      bottomNavigationBar: BottomNavi(list, index),
      body: PrayBody(widget.winList, 'believer', getPray(), widget.callback),
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
    Params params = await getParams('believer');
    // final args = await params.the
    String? param = params.param1 ?? '태신자';
    param = param == "" ? '태신자' : param;

    final String prayContent =
        '1) 하나님 아버지는 거룩하십니다.\n'
        '하나님 아버지의 이름이 '+param+'을(를) 통하여 거룩히 여김 받으시기를 원합니다.\n'
    '그리고 '+param+'이(가) 하나님의 이름을 거룩히 여기는 일들을 하기 원합니다.\n'
    '\n'
    '2) 하나님의 나라가 '+param+'에게 이루어지기를 원합니다.\n'
    '그리하여'+param+'의 심령에 의와 평강과 희락이 항상 있어 마음의 천국이 이루어지게 하옵소서.\n'
    +param+'이(가) 하나님의 통치를 받으며 하나님의 백성답게 하나님 나라의 법을 깨닫고 지키며 살게 하옵시고, 하나님 나라의 영광을 위하여 일하게 하옵소서.\n'
    '그리고 '+param+'을(를) 통하여 하나님 나라가 세상 모든 사람들에게 전파되기를 원합니다.\n'
    '\n'
    '3) 하나님의 뜻이 하늘에서 이루어진 것 같이 땅에서 '+param+'에게 이루어지기를 원합니다.\n'
    '또한 '+param+'이(가) 하나님의 뜻을 깨닫고 이루어 드리기를 기도합니다.\n'
    +param+'이(가) 하나님의 뜻대로 구원받은 백성이 되고 다른 사람을 구원할 수 있게 하옵소서.\n'
    '그리고 하나님의 뜻이 '+param+'을(를) 통하여 온 땅에 전파되기를 원합니다.\n'
    '\n'
    '4) 하나님께서 '+param+'에게 평생 동안 일용할 양식을 공급해 주시기를 원합니다.\n'
    '또 세상에서 살아가는데 필요한 것을 공급해주시기를 원합니다.\n'
    +param+'에게 지금 필요한 것들이 많이 있습니다.\n'
    '하나님께서 공급하여 주옵소서\n'
    '또 풍성하여 이웃들에게 나누어 주며 살게 하옵소서.\n'
    '또한 '+param+' 주변의 사람들이 모두 구원받기를 원합니다.\n'
    '그들을 구원하시어 하나님의 일꾼으로 사용하여 주옵소서.\n'
    '그리고 교회의 일꾼이 되며 리더가 되어 전도하고 목장을 부흥시키게 하옵소서.\n'
    '\n'
    '5) 하나님! '+param+'이(가) 다른 사람의 죄를 용서하기를 원합니다.\n'
    +param+'에게 상처를 주고 힘들게 했던 사람들을 용서해 주시기 원합니다.\n'
    '예수님의 이름으로 용서하는 마음을 주옵소서.\n'
    '그리고 그들의 영혼을 축복하게 하옵소서.\n'
    +param+'이(가) 하나님을 경외하고 복받기를 원합니다.\n'
    '\n'
    '6) 하나님! 다른 사람의 죄를 용서해 준 것 같이 '+param+'의 죄도 용서하여 주옵소서.\n'
    +param+'도 하나님 앞에서 죄인입니다.\n'
    '하나님이 용서하셔야 구원을 받사오니 용서하여 주옵소서.\n'
    '하나님만이 죄를 사하는 권세가 있는 줄 믿습니다.\n'
    '\n'
    '7) 하나님!'+param+'이(가) 시험에 들지 않기를 원합니다.\n'
    '마귀에게 시험당하지 않기를 원합니다.\n'
    '세상에 시험당하지 않기를 원합니다.\n'
    '물질이나 명예로 시험당하지 않기를 원합니다.\n'
    '가정에서 시험 들지 않기를 원합니다.\n'
    +param+'이(가) 시험 들지 않도록 지켜 주옵소서.\n'
    '\n'
    '8) 하나님! '+param+'을(를) 악에서 구원해 주옵소서.\n'
    +param+'의 마음속에 있는 여러가지 악에서 구원하여 선한 마음으로 인도하여 주옵소서.\n'
    +param+'을(를) 악에서 빠져나오게 하사 선을 행하게 하옵소서.\n'
    +param+'에게 악이 무엇인지를 알게 하옵소서.\n'
    '그리고 악에 물들지 않도록 지켜 주옵소서.\n'
    +param+'은(는) 연약하오니 하나님께서 악을 이길 수 있는 힘을 공급하여 주옵소서.\n'
    '\n'
    '9) 하나님의 나라와 권세와 영광이 영원히, 영원히 하나님 아버지께 있사오며,\n'
    '\n'
    '10) 예수님의 이름으로 기도드립니다. 아멘.\n';

    final wordToStyle = param;
    final wordStyle = TextStyle(color: Colors.blue);
    final wordTarget = TapGestureRecognizer()..onTapDown = (p) => {Navigator.pushNamed(context, '/conf/believer')};
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
      spans.add(TextSpan(text: spanText, style: style));//, recognizer: recognizer));

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
}