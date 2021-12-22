import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pray_training/pray_list.dart';
import 'package:sqflite/sqflite.dart';

import '../params.dart';

class PrayForDisease extends StatefulWidget {
  final Future<Database> db;

  PrayForDisease(this.db);

  @override
  State<StatefulWidget> createState() => _PrayForDisease();
}

class _PrayForDisease extends State<PrayForDisease> {
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
        title: Text('27. 질병을 치료하는 기도'),
      ),
      drawer: PrayList(),
      body: Center(
        child: SingleChildScrollView(
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
            param3: maps[i]['param3'],
            param4: maps[i]['param4'],
            param5: maps[i]['param5'],
        );
      }
    });

    return p;
  }

  Future<List<TextSpan>> getPray() async {
    Params params = await getParams('disease');

    String? target = params.param1 == null ? "다른 사람(이름)" : params.param1.toString();
    String? accident = params.param2 == null ? "죄(구체적으로)" : params.param2.toString();
    String? patient = params.param3 == null ? "이 환자" : params.param3.toString();
    String? sin = params.param4 == null ? "(구체적으로 죄를 말하며 회개하십시오)" : params.param4.toString();
    String? disease = params.param5 == null ? "위암(병명)" : params.param5.toString();

    List<TextSpan> textSpanList = [];
    textSpanList.add(TextSpan(text: '1) 하나님은 거룩하신 분이십니다.\n'));
    textSpanList.add(TextSpan(text: '하나님 아버지의 이름이 나를 통하여 거룩히 여김 받으시기를 원합니다.\n'));
    textSpanList.add(TextSpan(text: '\n'));
    textSpanList.add(TextSpan(text: '2) 하나님 나라를 창조하시고 믿음을 보시고 은혜로 주심을 감사드립니다.\n'));
    textSpanList.add(TextSpan(text: '나의 영혼이 믿음을 인정받고 하나님 나라를 선물로 받게 하옵소서.\n'));
    textSpanList.add(TextSpan(text: '그리고 하나님께서 나의 마음과 육체를 통치하여 주옵소서.\n'));
    textSpanList.add(TextSpan(text: '\n'));
    textSpanList.add(TextSpan(text: '3) 하나님의 뜻이 하늘에서 이루어진 것 같이 나를 통하여 이 땅에서 이루어지기를 원합니다.\n'));
    textSpanList.add(TextSpan(text: '\n'));
    textSpanList.add(TextSpan(text: '4) 매일 일용할 양식과 필요한 것을 공급하여 주심을 감사드립니다.\n'));
    textSpanList.add(TextSpan(text: '\n'));
    textSpanList.add(TextSpan(text: '5-1) 자신의 병을 치료하기 위한 기도\n'));
    textSpanList.add(TextSpan(text: '하나님! '));
    textSpanList.add(TextSpan(text: target, style: TextStyle(color: Colors.blue), recognizer: TapGestureRecognizer()..onTapDown = (p) => {Navigator.popAndPushNamed(context, '/conf/disease')} ));
    textSpanList.add(TextSpan(text: '의 '));
    textSpanList.add(TextSpan(text: accident, style: TextStyle(color: Colors.blue), recognizer: TapGestureRecognizer()..onTapDown = (p) => {Navigator.popAndPushNamed(context, '/conf/disease')} ));
    textSpanList.add(TextSpan(text: '를 용서합니다.\n'));
    textSpanList.add(TextSpan(text: '예수님의 말씀에 순종하여 무조건 용서합니다.\n'));
    textSpanList.add(TextSpan(text: '그리고 그를 축복합니다.\n'));
    textSpanList.add(TextSpan(text: '그가 하나님을 경외하고 복 받기를 원합니다.\n'));
    textSpanList.add(TextSpan(text: '\n'));
    textSpanList.add(TextSpan(text: '5-2) 다른 사람의 병을 치료하기 위한 기도\n'));
    textSpanList.add(TextSpan(text: '하나님! '));
    textSpanList.add(TextSpan(text: patient, style: TextStyle(color: Colors.blue), recognizer: TapGestureRecognizer()..onTapDown = (p) => {Navigator.popAndPushNamed(context, '/conf/disease')} ));
    textSpanList.add(TextSpan(text: '가 다른 사람의 죄를 용서해 주기를 원합니다.\n'));
    textSpanList.add(TextSpan(text: '가슴에 맺혀 있는 미움과 분노와 증오를 버리고 이 시간에 예수님의 말씀에 순종하여 무조건으로 용서해 주기를 바랍니다.\n'));
    textSpanList.add(TextSpan(text: '자신도 남에게 상처를 준 죄인인 것을 알게 하시고 회개의 영을 부어 주옵소서.\n'));
    textSpanList.add(TextSpan(text: '\n'));
    textSpanList.add(TextSpan(text: '6-1) 자신의 병을 치료하기 위한 기도\n'));
    textSpanList.add(TextSpan(text: '하나님! 다른 사람의 죄를 용서해 준 것같이 나의 죄를 사하여 주옵소서.\n'));
    textSpanList.add(TextSpan(text: '내가 하나님을 믿지 않고 지은 죄를 용서하여 주옵소서.\n'));
    textSpanList.add(TextSpan(text: '내가 하나님의 말씀을 불순종한 것을 용서하여 주옵소서'));
    textSpanList.add(TextSpan(text: sin, style: TextStyle(color: Colors.blue), recognizer: TapGestureRecognizer()..onTapDown = (p) => {Navigator.popAndPushNamed(context, '/conf/disease')} ));
    textSpanList.add(TextSpan(text: '\n모든 죄를 예수님의 십자가의 보혈로 씻어 주옵소서.\n'));
    textSpanList.add(TextSpan(text: '다시는 같은 죄를 범하지 않겠습니다.\n'));
    textSpanList.add(TextSpan(text: '하나님만이 죄를 사하는 권세가 있는 줄 믿습니다.\n'));
    textSpanList.add(TextSpan(text: '\n'));
    textSpanList.add(TextSpan(text: '6-2) 다른 사람의 병을 치료하기 위한 기도\n'));
    textSpanList.add(TextSpan(text: patient, style: TextStyle(color: Colors.blue), recognizer: TapGestureRecognizer()..onTapDown = (p) => {Navigator.popAndPushNamed(context, '/conf/disease')} ));
    textSpanList.add(TextSpan(text: '가 자신도 죄인 중에 괴수인 것을 깨닫게 하시고 진심으로 회개하는 마음을 주옵소서.\n'));
    textSpanList.add(TextSpan(text: '그리고 회개할 때 지금까지의 모든 죄를 예수님의 십자가의 보혈로 씻어 주옵소서.\n'));
    textSpanList.add(TextSpan(text: '다시는 같은 죄를 범하지 않도록 할 것입니다.\n'));
    textSpanList.add(TextSpan(text: '하나님만이 죄를 사하는 권세가 있는 줄 믿습니다.\n'));
    textSpanList.add(TextSpan(text: '하나님! 나('));
    textSpanList.add(TextSpan(text: patient, style: TextStyle(color: Colors.blue), recognizer: TapGestureRecognizer()..onTapDown = (p) => {Navigator.popAndPushNamed(context, '/conf/disease')} ));
    textSpanList.add(TextSpan(text: ')에게 건강을 선물로 주옵소서.\n'));
    textSpanList.add(TextSpan(text: '\n'));
    textSpanList.add(TextSpan(text: '예수님이 말씀하시기를 (막 16:17~18) "[17] 믿는 자들에게는 이런 표적이 따르리니 곧 그들이 내 이름으로 귀신을 쫓아내며 새 방언을 말하며 [18] 뱀을 집어올리며 무슨 독을 마실지라도 해를 받지 아니하며 병든 사람에게 손을 얹은즉 나으리라."고 하셨습니다.\n'));
    textSpanList.add(TextSpan(text: '\n'));
    textSpanList.add(TextSpan(text: '이 말씀대로 내게 이루어지게 하옵소서.\n'));
    textSpanList.add(TextSpan(text: '\'믿는 자들에게는 이런 표적이 따르리니 곧 그들이 내 이름으로 귀신을 쫓아내며,,,. 병든 사람에게 손을 얹은즉 나으리라 하신 말씀이 내게 이루어지기를 원합니다.\' (반복)\n'));
    textSpanList.add(TextSpan(text: '\n'));
    textSpanList.add(TextSpan(text: '\'예수님의 이름으로 명령하노니 내 몸속에 있는 '));
    textSpanList.add(TextSpan(text: disease, style: TextStyle(color: Colors.blue), recognizer: TapGestureRecognizer()..onTapDown = (p) => {Navigator.popAndPushNamed(context, '/conf/disease')} ));
    textSpanList.add(TextSpan(text: '은 없어져라! 병마는 떠나라! 귀신은 나가라!\' (계속 반복)\n'));
    textSpanList.add(TextSpan(text: '\''));
    textSpanList.add(TextSpan(text: disease, style: TextStyle(color: Colors.blue), recognizer: TapGestureRecognizer()..onTapDown = (p) => {Navigator.popAndPushNamed(context, '/conf/disease')} ));
    textSpanList.add(TextSpan(text: '은 치료될지어다! '));
    textSpanList.add(TextSpan(text: disease, style: TextStyle(color: Colors.blue), recognizer: TapGestureRecognizer()..onTapDown = (p) => {Navigator.popAndPushNamed(context, '/conf/disease')} ));
    textSpanList.add(TextSpan(text: '은 깨끗이 나을지어다!\' (반복)\n'));
    textSpanList.add(TextSpan(text: '하나님께서 치료해 주신 줄로 믿겠습니다.\n'));
    textSpanList.add(TextSpan(text: '\n'));
    textSpanList.add(TextSpan(text: '\'(막 11:24) \"그러므로 내가 너희에게 말하노니 무엇이든지 기도하고 구하는 것은 받은 줄로 믿으라 그리하면 너희에게 그대로 되리라.\" 예수님의 말씀대로 이루어질 줄 믿습니다.\' (반복)\n'));
    textSpanList.add(TextSpan(text: '\n'));
    textSpanList.add(TextSpan(text: '7) 하나님! 내가 마귀의 시험에 속아 넘어가지 않도록 지켜 주옵소서.\n'));
    textSpanList.add(TextSpan(text: '항상 마귀와 귀신을 물리치고 이기게 하옵소서.\n'));
    textSpanList.add(TextSpan(text: '\n'));
    textSpanList.add(TextSpan(text: '8) 하나님! 나를 여러 가지 악에서 구원해 주옵소서.\n'));
    textSpanList.add(TextSpan(text: '마음을 정결케 하시고, 꿈에서라도 악에 빠지지 않게 하옵소서.\n'));
    textSpanList.add(TextSpan(text: '\n'));
    textSpanList.add(TextSpan(text: '9) 하나님의 나라와 권세와 영광이 영원히 하나님 아버지께 있사오며,\n'));
    textSpanList.add(TextSpan(text: '\n'));
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