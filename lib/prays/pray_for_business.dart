import 'package:flutter/material.dart';
import 'package:pray_training/pray_list.dart';

import '../bottom_navi.dart';

class PrayForBusiness extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('23. 사업을 위한 기도'),
      ),
      drawer: PrayList(),
      bottomNavigationBar: BottomNavi(23),
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
        '하나님 아버지의 이름이 우리 사업장을 통하여 거룩히 여김 받으시기를 원합니다.\n'
        '그러므로 우리 사업장이 하나님의 이름을 거룩히 할 일만 행하게 하옵소서.\n'
        '\n'
        '2) 하나님의 나라가 우리 사업장에 이루어지기를 원합니다.\n'
        '그리하여 우리 사업장에 의와 평강과 희락이 항상 있게 하옵소서.\n'
        '우리 사업장이 하나님의 통치를 받으며 하나님 나라의 법을 지키게 하옵시고, 하나님 나라의 영광을 위하여 일하게 하옵소서.\n'
        '그리고 우리 사업장을 통하여 하나님의 나라가 세상 모든 사람들에게 전파되기를 원합니다.\n'
        '\n'
        '3) 하나님의 뜻이 하늘에서 이루어진 것 같이 땅에서 우리 사업장에 이루어지기를 원합니다.\n'
        '또 우리 사업장을 통하여 하나님의 선하신 뜻이 이루어지기를 기도합니다.\n'
        '하나님의 뜻이 우리 사업장을 통하여 온 땅에 전파되기를 원합니다.\n'
        '\n'
        '4) 하나님께서 우리 사업장에 평생 동안 일할 수 있도록 모든 것을 공급해 주시기를 원합니다.\n'
        '우리 사업장에 현재 필요한 것들이 많이 있습니다.\n'
        '우수한 인재들과 자금을 공급하여 주옵소서.\n'
        '그리하여 하나님 나라를 확장하는 데 물질로 공헌하게 하옵소서.\n'
        '나를 위한 사업이 아니라 하나님을 위한 사업이 되도록 하겠습니다.\n'
        '이 사업장을 통하여 하나님이 큰일을 행하시고, 여기서 얻어지는 이익을 하나님의 나라를 확장하고 하나님의 교회를 세우며 전도와 선교하는 데 사용하게 하옵소서.\n'
        '모든 것이 주께로부터 왔사오니 하나님이 영광을 받으시옵소서.\n'
        '이 사업장을 통하여 교회에 유익이 되고 복음 전파의 큰일을 감당하게 하옵소서.\n'
        '하나님은 주인이시고 나는 청지기일 뿐입니다.\n'
        '그리고 우리 사업장에 있는 사람들이 모두 하나님을 믿고 구원받기를 원합니다.\n'
        '그들이 각각 섬기는 교회에서 일꾼들이 되기를 원합니다.\n'
        '이 사업장이 성장하면서 많은 사람들을 구원시키는 장소가 되게 하옵소서.\n'
        '\n'
        '5) 하나님! 다른 사람의 죄를 용서합니다.\n'
        '우리 사업장에 상처를 주고 힘들게 하였던 사람들을 용서합니다.\n'
        '예수님의 이름으로 용서합니다.\n'
        '그리고 그들을 축복합니다.\n'
        '그들이 하나님을 경외하고 복 받기를 원합니다.\n'
        '\n'
        '6) 하나님! 다른 사람의 죄를 용서해 준 것 같이 우리 사업장의 죄를 사하여 주옵소서.\n'
        '하나님만이 죄를 사하는 권세가 있는 줄 믿습니다.\n'
        '\n'
        '7) 하나님! 우리 사업장이 시험에 들지 않기를 원합니다.\n'
        '마귀에게 시험당하지 않기를 원합니다.\n'
        '그러므로 마귀에게 시험을 허락지 마옵소서.\n'
        '또 세상에 시험당하지 않기를 원합니다.\n'
        '사업하면서 신앙생활에 지장이 없기를 원합니다.\n'
        '언제나 신앙생활이 먼저 되게 하옵소서.\n'
        '기도가 먼저 되게 하옵소서.\n'
        '맡겨진 사역이 먼저 되게 하옵소서.\n'
        '하나님 중심, 교회 중심, 가정 중심 순으로 살아가게 하옵소서.\n'
        '사업의 욕심 때문에 시험 드는 일이 없기를 원합니다.\n'
        '사업을 하는 데 있어 어리석은 생각이나 미련함이 없기를 원합니다.\n'
        '사업장에서 사고나 불행한 일이 생기지 않기를 원합니다.\n'
        '우리 사업장에서 시험이 없기를 기도합니다.\n'
        '\n'
        '8) 하나님! 우리 사업장을 악에서 구원하여 주옵소서.\n'
        '우리 사업장에 하나님의 법을 지키지 않는 악이 들어오지 못하게 하옵소서.\n'
        '그리하여 하나님의 법을 지키는 선한 사업장이 되게 하옵소서.\n'
        '우리 사업장이 세상의 악에 물들지 않도록 지켜 주옵소서.\n'
        '악은 모양이라도 보지 않게 하옵소서.\n'
        '우리 사업장은 연약하오니 하나님께서 악을 이길 수 있는 힘을 공급하여 주옵소서.\n'
        '\n'
        '9) 하나님의 나라와 권세와 영광이 영원히 하나님 아버지께 있사오며,\n'
        '\n'
        '10) 예수님의 이름으로 기도드립니다. 아멘.\n';

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