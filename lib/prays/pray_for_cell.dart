import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pray_training/pray_list.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

import '../bottom_navi.dart';
import '../params.dart';
import '../pray_body.dart';

class PrayForCell extends StatefulWidget {
  final Future<Database> db;
  List<Map<String,dynamic>> list;
  List<String> winList;
  Function callback;

  PrayForCell(this.db, this.list, this.winList, this.callback);

  @override
  State<StatefulWidget> createState() => _PrayForCell();
}

class _PrayForCell extends State<PrayForCell> {
  late TextEditingController dataController;
  late List<Map<String,dynamic>> list;
  int index = -1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dataController = TextEditingController();
    list = widget.list;
    index = getIndex(list, 'cell');
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('04. 목장과 목장원을 위한 기도'),
      ),
      drawer: PrayList(),
      bottomNavigationBar: BottomNavi(list, index),
      body: PrayBody(widget.winList, 'cell', getPray(), widget.callback),
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
            param3: maps[i]['param3'],
            param4: maps[i]['param4'],
            param5: maps[i]['param5']);
      }
    });

    return p;
  }

  Future<List<TextSpan>> getPray() async {
    Params params = await getParams('cell');
    String? withPray = params.param1 ?? '(목장을 위한 중보기도)';
    withPray = withPray == "" ? '(목장을 위한 중보기도)' : withPray;

    final String prayContent =
        '1) 하나님은 거룩하신 분이십니다.\n'
            '하나님 아버지의 이름이 우리 목장과 목장원을 통하여 거룩히 여김 받으시기를 원합니다.\n'
            '그리고 우리 목장원들이 하나님의 이름을 거룩히 여길 일만 행하게 하옵소서.\n'
            '하나님의 이름을 망령되이 일컫는 일을 행하지 않게 하옵소서.\n'
            '\n'
            '2) 하나님의 나라가 우리 목장과 목장원에 이루어지기를 원합니다.\n'
            '우리 목장원들의 마음에 의와 평강과 기쁨이 이루어져 마음의 천국이 이루어지게 하옵소서.\n'
            '그리고 하나님께서 통치하셔서 하나님의 말씀을 깨닫게 하시고 말씀에 복종하는 삶을 살게 하옵소서.\n'
            '또 목장원들 가정에 하나님의 나라가 이루어지게 하옵소서.\n'
            '그리고 우리 목장와 목장원을 통하여 하나님의 나라가 이웃과 세상 모든 사람들에게 전파되기를 원합니다.\n'
            '\n'
            '3) 하나님의 뜻이 하늘에서 이루어진 것 같이 땅에서 우리 목장과 목장원을 통하여 이루어지기를 원합니다.\n'
            '우리 목장과 목장원이 하나님의 뜻인 사람을 구원하는 일을 최우선으로 하게 하옵소서.\n'
            '가정 식구들을 전도하고 이웃을 전도하여 하나님의 뜻을 이루어 드리기를 소원합니다.\n'
            '이 일에 마음이 뜨거워져서 열정적으로 전도하게 하옵소서.\n'
            '또한 예수님의 전도법과 관계법을 실천하여 자신이 변화되게 하옵소서.\n'
            '\n'
            '4) 하나님께서 우리 목장과 목장원에게 필요한 것을 공급해 주시기를 원합니다.\n'
            '우리 목장의 목자에게 은혜와 능력을 주옵시고, 목장원들에게 성령 충만과 말씀 충만을 주옵소서.\n'
            '우리 목장이 전도하여 크게 부흥하게 하옵소서.\n'
            '전 목장원이 매일 전도하게 하옵소서.\n'
            '그리고 목장원들이 서로 뜨겁게 기도하고 도와주며 사랑하게 하옵소서.\n'
            '또한 건강하게 하옵시고 생활도 안정되게 하옵소서.\n'
            '\n'
            + withPray +
            '\n우리 목장이 지역의 영혼들을 많이 구원하는 목장이 되기를 원합니다.\n'
                '그리고 영적 추수할 리더를 만들고 번식하는 목장이 되게 하옵소서.\n'
                '\n'
                '5) 하나님! 다른 사람의 죄를 용서해 주시기 원합니다.\n'
                '우리 목자와 목장원들에게 상처를 주고 힘들게 하였던 '+'사람을'+' 용서합니다.\n'
            '예수님의 이름으로 용서합니다.\n'
            '그리고 그를 축복해 주옵소서.\n'
            '그가 하나님을 경외하고 복 받기를 원합니다.\n'
            '\n'
            '6) 하나님! 다른 사람의 죄를 용서하여 준 것 같이 목자의 죄와 목장원의 죄를 사하여 주옵소서.\n'
            '하나님만이 죄를 사하는 권세가 있는 줄 믿습니다.\n'
            '\n'
            '7) 하나님! 우리 목장과 목장원이 시험에 들지 않기를 원합니다.\n'
            '마귀에게 시험당하지 않기를 원합니다.\n'
            '세상으로부터 시험당하지 않기를 원합니다.\n'
            '신앙생활에 시험 들지 않기를 원합니다.\n'
            '목장생활에 시험 들지 않기를 원합니다.\n'
            '물질로 시험당하지 않기를 원합니다.\n'
            '사람들로 인하여 시험이 없기를 원합니다.\n'
            '가정 식구들도 시험이 없기를 원합니다.\n'
            '시험을 주는 마귀를 우리 목장에서 내쫓아 주옵시고 다시는 들어오지 않게 하옵소서.\n'
            '천군 천사로 우리 목장을 지켜 주옵소서.\n'
            '\n'
            '8) 하나님! 우리 목장과 목장원을 악에서 구원하여 주옵소서.\n'
            '우리 목장과 목장원이 하나님의 법을 어기는 악을 버리게 하옵소서.\n'
            '이 악은 우리를 멸망 받게 하나이다.\n'
            '그러므로 악에서 구원받아 선한 마음으로 살며 하나님의 법을 순종하고 복종하게 하옵소서.\n'
            '우리 목장과 목장원에게 악은 모양이라도 버릴 수 있는 믿음을 주옵소서.\n'
            '우리 목장원은 연약하오니 하나님께서 악을 이길 수 있는 힘을 공급하여 주옵시고 악에서 구원하옵소서.\n'
            '\n'
            '9) 하나님의 나라와 권세와 영광이 영원히, 영원히 하나님 아버지께 있사오며,\n'
            '\n'
            '10) 예수님의 이름으로 기도드립니다. 아멘.\n';

    final wordToStyle = withPray;
    final wordStyle = TextStyle(color: Colors.blue);
    final wordTarget = TapGestureRecognizer()..onTapDown = (p) => {Navigator.pushNamed(context, '/conf/cell')};
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