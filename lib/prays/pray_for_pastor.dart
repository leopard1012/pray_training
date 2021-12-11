import 'package:flutter/material.dart';
import 'package:pray_training/pray_list.dart';

class PrayForPastor extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('01. 나라를 위한 기도'),
      ),
      drawer: PrayList(),
      body: Center(
        child: SingleChildScrollView(
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
        '1) 하나님 아버지는 거룩하신 분이십니다.\n'
            '하나님 아버지의 이름이 담임목사님과 가정을 통하여 거룩히 여김 받으시기를 원합니다.\n'
            '그러므로 우리 담임목사님과 가정이 하나님의 이름을 거룩하게 할 일만 행하게 하옵소서.\n'
            '\n'
            '2) 하나님의 나라가 담임목사님과 가정에 이루어지기를 원합니다.\n'
            '그리하여 의와 평강과 희락이 있는 가정이 되어 행복하게 하옵소서.\n'
            '우리 담임목사님과 가정이 하나님의 통치를 받으며 하나님 나라의 법을 지키며 기쁘게 살게 하옵시고, 하나님 나라의 영광을 위하여 일하게 하옵소서.\n'
            '그리고 우리 담임목사님과 가정을 통하여 하나님의 나라가 세상 모든 사람들에게 전파되기를 원합니다.\n'
            '\n'
            '3) 하나님의 뜻이 하늘에서 이루어진 것 같이 땅에서 우리 담임목사님과 가정에 이루어지기를 원합니다.\n'
            '또한 우리 담임목사님과 가족을 통하여 하나님의 선하신 뜻이 이루어지기를 기도합니다.\n'
            '하나님의 뜻이 우리 담임목사님과 가정을 통하여 온 당에 전파되기를 원합니다.\n'
            '\n'
            '4) 하나님께서 우리 담임목사님의 가정에 평생 동안 일용할 양식을 공급해 주시기를 원합니다.\n'
            '또 세상에서 살아가는데 필요한 것을 풍족하게 공급해 주시기를 원합니다.\n'
            '우리 담임목사님의 가정에 현재 필요한 것들이 많이 있습니다.\n'
            '하나님게서 공급하여 주옵소서.\n'
            '또 풍성하여 이웃들에게 나우어 주며 살게 하옵소서.\n'
            '또한 우리 담임목사님과 가정의 주변 사람들이 모두 구원받기를 원합니다.\n'
            '그들을 구원하시어 하나님의 일꾼으로 사용해 주옵소서.\n'
            '그리고 담임목사님에게 크신 능력을 주어 큰 일꾼으로 사용하여 주옵소서.\n'
            '이 시대에 하나님의 뜻을 이루어 드리는 종으로 사용하여 주옵소서.\n'
            '\n'
            '5) 하나님! 다른 사람들의 죄를 용서해 주시기를 원합니다.\n'
            '우리 담임목사님과 가정에 상처를 주고 힘들게 했던 사람들을 용서해 주시기 원합니다.\n'
            '예수님의 이름으로 용서해 주옵소서.\n'
            '그리고 ' + 'param' + ' 축복해 주옵소서.'
            '그들이 하나님을 경외하고 복 받기를 원합니다.\n'
            '\n'
            '6) 하나님! 다른 사람들의 죄를 용서해 준 것 같이 우리 담임목사님과 가정의 죄도 십자가의 보혈로 사하여 주옵소서.\n'
            '하나님만이 죄를 사하는 권세가 있는 줄 믿습니다.\n'
            '\n'
            '7) 하나님! 우리 담임목사님과 가정이 시험에 들지 않기를 원합니다.\n'
            '마귀에게 시험당하지 않기를 원합니다.\n'
            '그러므로 마귀에게 시험 당함을 허락지 마옵소서.\n'
            '또 세상에 시험당하지 않기를 원합니다.\n'
            '가난이나 물질, 질병, 불행한 사고, 세상 명예, 돈, 권력으로부터 시험당하지 않기를 원합니다.\n'
            '교회생활에 시험 들지 않기를 원합니다.\n'
            '\n'
            '부교역자나 중진, 집사, 성도들로부터 시험 들지 않기를 원합니다.\n'
            '또 가정 식구들로부터 시험 들지 않게 하옵소서.\n'
            '\n'
            '8) 하나님! 우리 담임목사님과 가정을 악에서 구원하여 주옵소서.\n'
            '우리에게는 하나님의 법을 지키지 않는 악한 마음이 있습니다.\n'
            '이 악에서 우리 담임목사님과 가정을 구원해 주옵소서.\n'
            '그리하여 하나님의 법을 지키는 선한 가정이 되게 하옵소서.\n'
            '우리 담임목사님과 가정이 세상의 악에 물들지 않도록 지켜 주옵소서.\n'
            '악은 모양이라도 보지 않게 하옵소서.\n'
            '우리 담임목사님과 가정은 연약하오니 하나님게서 악을 이길 수 있는 힘과 능력을 공급하여 주옵소서.\n'
            '\n'
            '9) 하나님의 나라와 권세와 영광히 영원히, 영원히 하나님 아버지께 있사오며,\n'
            '\n'
            '10) 예수님의 이름으로 기도드립니다. 아멘.';

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