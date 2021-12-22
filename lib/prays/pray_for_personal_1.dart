import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pray_training/pray_list.dart';
import 'package:sqflite/sqflite.dart';

import '../params.dart';

class PrayForPersonal1 extends StatefulWidget {
  final Future<Database> db;

  PrayForPersonal1(this.db);

  @override
  State<StatefulWidget> createState() => _PrayForPersonal1();
}

class _PrayForPersonal1 extends State<PrayForPersonal1> {
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
        title: Text('12. 개인기도'),
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
            param3: maps[i]['param3']);
      }
    });

    return p;
  }

  Future<List<TextSpan>> getPray() async {
    Params params = await getParams('personal_1');

    String? target = params.param1 == null ? "다른 사람(OOO)" : params.param1.toString();
    String? accident = params.param2 == null ? "죄(어떤 죄)" : params.param2.toString();

    List<TextSpan> textSpanList = [];
    textSpanList.add(TextSpan(text: '1) 하나님은 거룩한 분이십니다.\n'));
    textSpanList.add(TextSpan(text: '하나님 아버지의 이름이 나를 통하여 거룩히 여김 받으시기를 원합니다.\n'));
    textSpanList.add(TextSpan(text: '내가 하나님의 이름을 거룩히 할 일만 하게 하옵소서.\n'));
    textSpanList.add(TextSpan(text: '그리고 온 세상 사람들이 하나님의 이름을 거룩히 여기기를 원합니다.\n'));
    textSpanList.add(TextSpan(text: '\n'));
    textSpanList.add(TextSpan(text: '2) 하나님 나라를 창조하시고 사람의 믿음을 보시고 은혜로 주심을 감사합니다.\n'));
    textSpanList.add(TextSpan(text: '하나님의 나라가 내게 이루어지기를 원합니다.\n'));
    textSpanList.add(TextSpan(text: '그리하여 내 심령에 의와 평강과 희락이 항상 있어 마음의 천국이 이루어지고, 마귀에게 마음의 천국(의와 평강과 희락)을 빼앗기지 않게 하옵소서.\n'));
    textSpanList.add(TextSpan(text: '내가 하나님의 통치를 받으며 하나님의 백성답게 하나님 나라의 법을 지키며 살게 하옵시고, 몸은 세상에 있으나 마음은 하나님 나라를 이루고 사는 모습을 보이게 하옵소서.\n'));
    textSpanList.add(TextSpan(text: '그리고 나를 통하여 하나님의 나라가 세상 모든 사람들에게 전파되기를 원합니다.\n'));
    textSpanList.add(TextSpan(text: '\n'));
    textSpanList.add(TextSpan(text: '3) 하나님의 뜻이 하늘에서 이루어진 것 같이 땅에서 나에게 이루어지기를 원합니다.\n'));
    textSpanList.add(TextSpan(text: '또 내가 하나님의 뜻을 알고 이루어드리기를 기도합니다.\n'));
    textSpanList.add(TextSpan(text: '하나님의 뜻은 사람을 구원하는 일과 선과 의를 행하는 일인 줄로 압니다.\n'));
    textSpanList.add(TextSpan(text: '열심히 행하게 하옵소서.\n'));
    textSpanList.add(TextSpan(text: '하나님의 뜻이 나를 통하여 온 땅에 전파되기를 원합니다.\n'));
    textSpanList.add(TextSpan(text: '\n'));
    textSpanList.add(TextSpan(text: '4) 하나님께서 나에게 평생 동안 일용할 양식을 공급해 주시기를 원합니다.\n'));
    textSpanList.add(TextSpan(text: '또 세상에서 살아가는데 필요한 것을 공급해 주시기를 원합니다.\n'));
    textSpanList.add(TextSpan(text: '나에게 지금 필요한 것들이 많이 있습니다.\n'));
    textSpanList.add(TextSpan(text: '하나님께서 공급하여 주옵소서.\n'));
    textSpanList.add(TextSpan(text: '모든 것이 주께로부터 공급되는 줄을 믿습니다.\n'));
    textSpanList.add(TextSpan(text: '하나님을 사랑하고 이웃을 사랑하게 하옵소서.\n'));
    textSpanList.add(TextSpan(text: '성령 충만함과 믿음의 은사를 주시어 행하게 하옵소서.\n'));
    textSpanList.add(TextSpan(text: '또 나를 부인하고 나에게 주신 십자가를 지고 예수님의 뒤를 따르게 하옵소서.\n'));
    textSpanList.add(TextSpan(text: '나에게 버릴 것이 많이 있습니다.\n'));
    textSpanList.add(TextSpan(text: '세상의 악한 것들을 모두 버리게 하옵소서.\n'));
    textSpanList.add(TextSpan(text: '그리고 예수님의 마음을 배우게 하시며 온유와 겸손을 배워서 실천하게 하옵소서.\n'));
    textSpanList.add(TextSpan(text: '마음과 물질에 풍성하여 이웃들에게 나누어 주며 살게 하옵소서.\n'));
    textSpanList.add(TextSpan(text: '또한 나의 주변 사람들이 모두 구원받기를 원합니다.\n'));
    textSpanList.add(TextSpan(text: '그들을 구원하시어 하나님의 일꾼으로 사용하여 주옵소서.\n'));
    textSpanList.add(TextSpan(text: '\n'));
    textSpanList.add(TextSpan(text: '5) 하나님! '));
    textSpanList.add(TextSpan(text: target, style: TextStyle(color: Colors.blue), recognizer: TapGestureRecognizer()..onTapDown = (p) => {Navigator.popAndPushNamed(context, '/conf/personal_1')} ));
    textSpanList.add(TextSpan(text: '의 '));
    textSpanList.add(TextSpan(text: accident, style: TextStyle(color: Colors.blue), recognizer: TapGestureRecognizer()..onTapDown = (p) => {Navigator.popAndPushNamed(context, '/conf/personal_1')} ));
    textSpanList.add(TextSpan(text: '를 용서합니다.\n'));
    textSpanList.add(TextSpan(text: '나에게 상처를 주고 힘들게 했던 사람을 용서합니다.\n'));
    textSpanList.add(TextSpan(text: '나를 무시하고 멸시한 사람들을 용서합니다.\n'));
    textSpanList.add(TextSpan(text: '예수님의 이름으로 용서합니다.\n'));
    textSpanList.add(TextSpan(text: '그리고 그를 축복합니다.\n'));
    textSpanList.add(TextSpan(text: '그의 영혼이 잘되고 하나님을 경외하고 복 받기를 원합니다.\n'));
    textSpanList.add(TextSpan(text: '\n'));
    textSpanList.add(TextSpan(text: '6) 하나님! 다른 사람의 죄를 용서해 준 것 같이 나의 죄를 사하여 주옵소서.\n'));
    textSpanList.add(TextSpan(text: '나도 죄인 중에 괴수입니다.\n'));
    textSpanList.add(TextSpan(text: '그러므로 용서하여 주옵소서.\n'));
    textSpanList.add(TextSpan(text: '예수님의 십자가의 보혈로 씻어 주옵소서.\n'));
    textSpanList.add(TextSpan(text: '하나님만이 죄를 사하는 권세가 있는 줄 믿습니다.\n'));
    textSpanList.add(TextSpan(text: '\n'));
    textSpanList.add(TextSpan(text: '7) 하나님! 내가 시험에 들지 않기를 원합니다.\n'));
    textSpanList.add(TextSpan(text: '마귀에게 시험당하지 않기를 원합니다.\n'));
    textSpanList.add(TextSpan(text: '믿음의 시험이 없기를 원합니다.\n'));
    textSpanList.add(TextSpan(text: '욥과 같은 시험이 없기를 원합니다.\n'));
    textSpanList.add(TextSpan(text: '세상에서 시험당하지 않기를 원합니다.\n'));
    textSpanList.add(TextSpan(text: '물질이나 명예로 시험당하지 않기를 원합니다.\n'));
    textSpanList.add(TextSpan(text: '신앙생활에서 시험 들지 않기를 원합니다.\n'));
    textSpanList.add(TextSpan(text: '교회 생활에서 시험 들지 않기를 원합니다.\n'));
    textSpanList.add(TextSpan(text: '가정에서 시험 들지 않기를 원합니다.\n'));
    textSpanList.add(TextSpan(text: '하나님이 관심 없어 하는 것을 바라거나 가지려고 하지 않기를 원합니다.\n'));
    textSpanList.add(TextSpan(text: '하나님! 내가 시험에 들지 않도록 지켜 주옵소서.\n'));
    textSpanList.add(TextSpan(text: '\n'));
    textSpanList.add(TextSpan(text: '8) 하나님! 나를 악에서 구원하여 주옵소서.\n'));
    textSpanList.add(TextSpan(text: '나의 마음속에는 악이 가득합니다.\n'));
    textSpanList.add(TextSpan(text: '세상의 욕심과 부끄러운 마음이 있습니다.\n'));
    textSpanList.add(TextSpan(text: '버리지 못한 악한 습관들이 있습니다.\n'));
    textSpanList.add(TextSpan(text: '그러므로 이 악에서 나를 구원하여 선한 마음으로 인도하여 주옵소서.\n'));
    textSpanList.add(TextSpan(text: '나를 세상의 악에 물들지 않도록 지켜 주옵소서.\n'));
    textSpanList.add(TextSpan(text: '나는 연약하오니 하나님께서 악을 이길 수 있는 힘을 공급하여 주옵소서.\n'));
    textSpanList.add(TextSpan(text: '\n'));
    textSpanList.add(TextSpan(text: '9) 하나님의 나라와 권세와 영광이 영원히, 영원히 하나님 아버지께 있사오며,\n'));
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