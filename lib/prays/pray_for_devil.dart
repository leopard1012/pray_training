import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pray_training/pray_list.dart';
import 'package:sqflite/sqflite.dart';

import '../bottom_navi.dart';
import '../params.dart';

class PrayForDevil extends StatefulWidget {
  final Future<Database> db;

  PrayForDevil(this.db);

  @override
  State<StatefulWidget> createState() => _PrayForDevil();
}

class _PrayForDevil extends State<PrayForDevil> {
  // late TextEditingController dataController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // dataController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Scaffold(
      appBar: AppBar(
        title: Text('26. 마귀를 물리치는 기도'),
      ),
      drawer: PrayList(),
      bottomNavigationBar: BottomNavi(26),
      body: Center(
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
    Params params = await getParams('devil');

    String? target = params.param1 == null ? "다른 사람(이름)" : params.param1.toString();
    String? accident = params.param3 == null ? "죄(구체적으로)" : params.param3.toString();
    target = target == "" ? '다른 사람(이름)' : target;
    accident = accident == "" ? '죄(구체적으로)' : accident;

    List<TextSpan> textSpanList = [];
    textSpanList.add(TextSpan(text: '1) 하나님은 거룩하신 분이십니다.\n'));
    textSpanList.add(TextSpan(text: '내가 하나님의 이름을 거룩하게 할 일만 하게 하옵소서.\n'));
    textSpanList.add(TextSpan(text: '내가 하는 일로 하나님의 이름이 사람들에게서 거룩하게 되기를 원합니다.\n'));
    textSpanList.add(TextSpan(text: '\n'));
    textSpanList.add(TextSpan(text: '2) 하나님 나라를 창조하시고 믿음을 보시고 은혜로 주심을 감사드립니다.\n'));
    textSpanList.add(TextSpan(text: '나의 영혼이 믿음을 인정받고 하나님 나라를 선물로 받게 하옵소서.\n'));
    textSpanList.add(TextSpan(text: '그리고 하나님께서 나를 통치하여 주옵소서.\n'));
    textSpanList.add(TextSpan(text: '\n'));
    textSpanList.add(TextSpan(text: '3) 하나님의 뜻이 하늘에서 이루어진 것 같이 나를 통하여 이 땅에서 이루어지기를 원합니다.\n'));
    textSpanList.add(TextSpan(text: '\n'));
    textSpanList.add(TextSpan(text: '4) 날마다 일용할 양식을 주심을 감사드립니다.\n'));
    textSpanList.add(TextSpan(text: '계속하여 양식과 필요한 것들을 공급하여 주옵소서.\n'));
    textSpanList.add(TextSpan(text: '\n'));
    textSpanList.add(TextSpan(text: '5) 하나님! '));
    textSpanList.add(TextSpan(text: target, style: TextStyle(color: Colors.blue), recognizer: TapGestureRecognizer()..onTapDown = (p) => {Navigator.pushNamed(context, '/conf/devil')} ));
    textSpanList.add(TextSpan(text: '의 '));
    textSpanList.add(TextSpan(text: accident, style: TextStyle(color: Colors.blue), recognizer: TapGestureRecognizer()..onTapDown = (p) => {Navigator.pushNamed(context, '/conf/devil')} ));
    textSpanList.add(TextSpan(text: '를 용서합니다.\n'));
    textSpanList.add(TextSpan(text: '예수님의 말씀에 순종하여 무조건 용서합니다.\n'));
    textSpanList.add(TextSpan(text: '그리고 그를 축복합니다.\n'));
    textSpanList.add(TextSpan(text: '그가 하나님을 경외하고 복 받기를 원합니다.\n'));
    textSpanList.add(TextSpan(text: '\n'));
    textSpanList.add(TextSpan(text: '6) 하나님! 다른 사람의 죄를 용서해 준 것 같이 나의 죄를 사하여 주옵소서.\n'));
    textSpanList.add(TextSpan(text: '나 또한 다른 사람에게 아무렇지 않게 상처 주는 일들을 하였음을 고백합니다.\n'));
    textSpanList.add(TextSpan(text: '용서하여 주옵소서.\n'));
    textSpanList.add(TextSpan(text: '예수님의 십자가의 보혈로 씻어 주옵소서.\n'));
    textSpanList.add(TextSpan(text: '하나님만이 죄를 사하는 권세가 있는 줄 믿습니다.\n'));
    textSpanList.add(TextSpan(text: '하나님! 마귀와 악령과 귀신을 물리쳐 주옵소서.\n'));
    textSpanList.add(TextSpan(text: '하나님! 나에게 전신갑주를 입혀 주옵소서.\n'));
    textSpanList.add(TextSpan(text: '(약 4:7) "그런즉 너희는 하나님께 복종할지어다. 마귀를 대적하라. 그리하면 너희를 피하리라."라고 말씀하셨습니다.\n'));
    textSpanList.add(TextSpan(text: '이 말씀을 믿고 기도합니다.\n'));
    textSpanList.add(TextSpan(text: '\n'));
    textSpanList.add(TextSpan(text: '<명령하십시오.>\n'));
    textSpanList.add(TextSpan(text: '\'마귀와 악령과 귀신은 내 몸속에서 나가라! 나는 하나님을 믿는다. 더러운 귀신아! 내 몸속에서 나가라!\' (반복)\n'));
    textSpanList.add(TextSpan(text: '\'나는 이제부터 하나님의 자녀요, 백성이다. 그러니 내 몸속에서 나가라!\' (반복)\n'));
    textSpanList.add(TextSpan(text: '\'하나님께서 마귀를 물리치라고 하셨느니라. 그러니 내 몸에서 나가라! 예수 그리스도 이름으로 명령하노니 당장에 나가라!\' (반복)\n'));
    textSpanList.add(TextSpan(text: '\'예수 그리스도께서 말씀하셨느니라. (막 16:17) "믿는 자들에게는 이런 표적이 따르리니 곧 그들이 내 이름으로 귀신을 쫓아내며"라고 하셨느니라. 그러니 귀신아, 내 몸에서 나가라!\' (반복)\n'));
    textSpanList.add(TextSpan(text: '\n'));
    textSpanList.add(TextSpan(text: '7) 하나님! 내가 마귀에게서 시험에 들지 않도록 인도하여 주옵소서.\n'));
    textSpanList.add(TextSpan(text: '\n'));
    textSpanList.add(TextSpan(text: '8) 하나님! 마귀가 주는 여러 가지 악에서 구원해 주옵소서.\n'));
    textSpanList.add(TextSpan(text: '마음을 정결케 하시고 꿈에서라도 악에 빠지지 않게 하옵소서.\n'));
    textSpanList.add(TextSpan(text: '\n'));
    textSpanList.add(TextSpan(text: '9) 하나님의 나라와 권세와 영광이 영원히 하나님 아버지께 있사오며,\n'));
    textSpanList.add(TextSpan(text: ' \n'));
    textSpanList.add(TextSpan(text: '10) 예수님의 이름으로 기도드립니다.\n'));
    textSpanList.add(TextSpan(text: '\n'));
    textSpanList.add(TextSpan(text: '아멘.\n'));

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
}