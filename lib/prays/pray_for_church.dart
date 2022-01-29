import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pray_training/pray_list.dart';
import 'package:sqflite/sqflite.dart';

import '../bottom_navi.dart';
import '../params.dart';

class PrayForChurch extends StatefulWidget {
  final Future<Database> db;

  PrayForChurch(this.db);

  @override
  State<StatefulWidget> createState() => _PrayForChurch();
}

class _PrayForChurch extends State<PrayForChurch> {
  late TextEditingController dataController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dataController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Scaffold(
      appBar: AppBar(
        title: Text('02. 교회를 위한 기도'),
      ),
      drawer: PrayList(),
      bottomNavigationBar: BottomNavi(2),
      body: Center(
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
    Params params = await getParams('church');
    String? withPray = params.param1 ?? '(교회를 위한 중보기도)';
    withPray = withPray == "" ? '(교회를 위한 중보기도)' : withPray;

    final String prayContent =
        '1) 하나님 아버지는 거룩하십니다.\n'
            '하나님 아버지의 이름이 우리 교회를 통하여 거룩히 여김 받으시기를 원합니다.\n'
            '그리고 우리 교회가 하나님의 이름을 거룩하게 할 일만 하게 하옵소서.\n'
            '\n'
            '2) 하나님의 나라가 우리 교회에 이루어지기를 원합니다.\n'
            '그리하여 의와 평강과 희락이 넘치는 교회가 되어 교회 천국이 이루어지게 하옵소서.\n'
            '또한 우리 교회를 통치하셔서 하나님의 말씀대로 세워지게 하옵시고 하나님이 기뻐하는 교회가 되게 하옵소서.\n'
            '그리고 우리 교회를 통하여 하나님의 나라가 이웃과 지역사회와 세상 모든 사람들에게 전파되기를 원합니다.\n'
            '\n'
            '3) 하나님의 뜻이 하늘에서 이루어진 것 같이 땅에서 우리 교회를 통하여 이루어지기를 원합니다.\n'
            '또 우리 교회가 하나님의 뜻을 알고 이루어 드리기를 기도합니다.\n'
            '하나님의 뜻이 우리 교회를 통하여 모든 민족에게 증거되기를 원합니다.\n'
            '\n'
            '4) 하나님께서 우리 교회에 필요한 것을 공급해 주시기를 원합니다.\n'
            '우리 교회 담임목사님의 건강을 지켜 주옵소서.\n'
            '하나님의 뜻을 이루어 드리는 능력의 사자로 사용하여 주옵소서.\n'
            '또 우리 교회의 목표가 이루어지게 하옵소서.\n'
            '\n'
            + withPray +
            '\n우리 교회가 지역의 영혼들을 많이 구원하는 교회가 되기를 원합니다.\n'
                '그리고 영적 추수할 리더를 만들고 번식하는 교회가 되게 하옵소서.\n'
                '우리 교회 부교역자들과 중진들이 담임목사님을 도와서 하나님의 뜻을 이루게 하옵소서.\n'
                '또한 그들이 성령 충만하고 말씀에 충만하여 능력으로 하나님의 큰 뜻을 이루게 하옵소서.\n'
                '우리 교인들이 하나님을 잘 섬기고 복 받는 사람들이 되기를 원합니다.\n'
                '\n'
                '5) 하나님! 다른 사람의 죄를 용서해 주시기 원합니다.\n'
                '우리 교회에 상처를 주고 힘들게 했던 사람들을 용서합니다.\n'
                '예수님의 이름으로 용서합니다.\n'
                '그리고 그들의 영혼을 축복해 주옵소서.\n'
                '그들이 하나님을 경외하고 복 받기를 원합니다.\n'
                '\n'
                '6) 하나님! 다른 사람의 죄를 용서해 준 것 같이 우리 교회의 죄를 사하여 주옵소서.\n'
                '하나님만이 죄를 사하는 권세가 있는 줄 믿습니다.\n'
                '\n'
                '7) 하나님! 우리 교회가 시험에 들지 않기를 원합니다.\n'
                '마귀에게 시험당하지 않기를 원합니다.\n'
                '세상으로부터 시험당하지 않기를 원합니다.\n'
                '신앙 생활에 시험 들지 않기를 원합니다.\n'
                '교회생활에 시험 들지 않기를 원합니다.\n'
                '물질로 시험 당하지 않기를 원합니다.\n'
                '사람들로 인하여 시험 들지 않기를 원합니다.\n'
                '여러 가지 시험에 들지 않도록 하옵소서.\n'
                '그리고 시험을 주는 마귀를 우리 교회에서 내쫓아 주옵시고, 다시는 들어오지 않게 하옵소서.\n'
                '천군 천사로 우리 교회를 지켜 주옵소서.\n'
                '\n'
                '8) 하나님! 우리 교회를 악에서 구원하여 주옵소서.\n'
                '우리 교회가 하나님의 법을 어기는 악을 행하지 않게 하옵소서.\n'
                '우리 교회가 하나님의 말씀대로 행하여 선과 의를 행하게 하옵소서.\n'
                '우리 교회는 연약하오니 하나님께서 악을 이길 수 있는 힘과 능력을 공급하여 주옵소서.\n'
                '언제나 악에서 지켜주시고 악이 들어올 때 구원하여 주옵소서.\n'
                '\n'
                '9) 하나님의 나라와 권세와 영광이 영원히, 영원히 하나님 아버지께 있사오며,\n'
                '\n'
                '10) 예수님의 이름으로 기도드립니다. 아멘.\n';

    final wordToStyle = withPray;
    final wordStyle = TextStyle(color: Colors.blue);
    final wordTarget = TapGestureRecognizer()..onTapDown = (p) => {Navigator.pushNamed(context, '/conf/church')};
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
}