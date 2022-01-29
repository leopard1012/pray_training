import 'package:flutter/material.dart';
import 'package:pray_training/pray_list.dart';

import '../bottom_navi.dart';

class PrayForTarry extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('17. 기도가 잘 되지 않을 때 드리는 기도'),
      ),
      drawer: PrayList(),
      bottomNavigationBar: BottomNavi(17),
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
        '4) 기도를 통해 하나님과의 대화의 길을 열어주신 주님, 기도의 말문이 막혀 기도하지 못하는 나의 입술을 열어 주시기를 간구합니다.\n'
        '바쁘다는 핑계로, 시간이 없다는 이유로, 여러 가지 다른 이유를 대고 하나님과 대화하는 기도 시간을 소홀히 하였습니다.\n'
        '신앙생활의 우선순위를 잊어버리고 사탄으로 하여금 틈을 타게 한 나의 악을 용서하여 주옵소서.\n'
        '영적인 호흡인 기도를 멈춤으로 인해 내 영이 목마른 가운데 있습니다.\n'
        '주님! 이 영혼을 불쌍히 여겨 주옵소서.\n'
        '늘 깨어 기도하라고 하셨는데 순간의 피곤함과 유혹을 이기지 못하는 나의 연약함을 도와주옵소서.\n'
        '이 시간 이후로는 기도가 즐거워지고 행복하게 하옵소서.\n'
        '기도의 은사를 주옵소서.\n'
        '기도의 능력을 주옵소서.\n'
        '내게 고난과 가난을 주심은 기도하라는 말씀이었는데 기도하지 못했음을 용서하여 주옵소서.\n'
        '이제는 새벽기도, 철야기도, 금식기도, 작정기도 하게 하옵소서.\n'
        '그리하여 다니엘처럼 기도의 사람이 되게 하옵소서.\n'
        '\n'
        '5) 하나님! 다른 사람의 죄를 용서합니다.\n'
        '나에게 상처를 주고 힘들게 했던 사람을 용서합니다.\n'
        '예수님의 이름으로 용서합니다.\n'
        '그를 축복합니다.\n'
        '\n'
        '6) 하나님! 다른 사람의 죄를 용서해 준 것 같이 나의 죄를 용서하여 주옵소서.\n'
        '기도의 중요성을 알면서도 게을러서 기도하지 못하고, 하나님의 기도하라는 뜻을 소홀히 한 죄를 용서하여 주옵소서.\n'
        '하나님만이 죄를 사하는 권세가 있는 줄 믿습니다.\n'
        '\n'
        '7) 하나님! 내가 시험에 들지 않기를 원합니다.\n'
        '사탄의 시험에 버려두지 마옵소서.\n'
        '\n'
        '8) 하나님! 나를 악에서 구원하여 주옵소서.\n'
        '나의 마음속에 있는 여러 가지 악에서 구원하셔서 선한 마음으로 인도해 주옵소서.\n'
        '또한 세상의 악에 물들지 않도록 지켜 주옵소서.\n'
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
}