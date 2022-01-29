import 'package:flutter/material.dart';
import 'package:pray_training/pray_list.dart';

import '../bottom_navi.dart';

class PrayForThanks extends StatefulWidget {
  List<Map<String, dynamic>> list;

  PrayForThanks(this.list);

  @override
  State<StatefulWidget> createState() => _PrayForThanks();
}

class _PrayForThanks extends State<PrayForThanks> {
  late List<Map<String,dynamic>> list;
  int index = -1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    list = widget.list;
    index = getIndex(list, 'thanks');
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('19. 감사할 때 드리는 기도'),
      ),
      drawer: PrayList(),
      bottomNavigationBar: BottomNavi(list, index),
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
        '나의 심령에 의와 평강와 희락이 항상 있게 하옵소서.\n'
        '\n'
        '3) 하나님의 뜻이 하늘에서 이루어진 것 같이 나를 통하여 이 땅에서 이루어지기를 원합니다.\n'
        '\n'
        '4) 나의 모든 것을 통해서 주님께 감사하는 삶을 살게 하옵소서.\n'
        '나의 영혼을 구원하여 주신 것을 감사드립니다.\n'
        '세상에 좋은 사람들이 많이 있는데 부족하고 천한 죄인을 불러주셔서 하나님을 알게 하시고 죄를 사하여 주시고 구원하여 주셔서 감사합니다.\n'
        '섬길 수 있는 교회를 주심에 감사하며, 마음껏 찬양하고 기도하며 예배드릴 수 있는 환경을 주심에 감사드립니다.\n'
        '함께 신앙생활 할 수 있는 지체들이 있게 하심을 감사하며, 구원받은 것도 감사한데 일꾼 삼아 주시니 더욱 감사합니다.\n'
        '그리고 성도들과 주변의 사람들을 통해 날마다 배우게 하심을 감사드립니다.\n'
        '하루의 양식과 꾸지 않을 만큼의 물질을 주신 것에 감사하고, 자녀들이 건강하게 자라게 하심을 감사드립니다.\n'
        '돕는 배필을 주심에 감사하고 일할 수 있는 직장을 주심에 감사드립니다.\n'
        '육신의 안식처를 주심에 감사하고, 하나님 나라의 소망을 주심을 감사드립니다.\n'
        '나에게 피해를 주었던 사람들을 통해서도 나의 모습을 돌아보고 회개하게 하심을 감사하고, 내가 어디를 가든지 어떤 일을 하든지 주님이 주신 것 이상을 바라지 않게 하심을 감사합니다.\n'
        '시련이나 육신의 아픔 중에 있을 때에라도 감사할 조건들을 찾을 수 있는 사람이 되게 하시고, 늘 감사가 나의 입에서 떠나지 않도록 하옵소서.\n'
        '\n'
        '5) 하나님! 다른 사람의 죄를 용서합니다.\n'
        '나에게 상처를 주고 힘들게 했던 사람을 용서합니다.\n'
        '그를 축복합니다.\n'
        '\n'
        '6) 하나님! 다른 사람의 죄를 용서해 준 것 같이 나의 죄를 용서하여 주옵소서.\n'
        '하나님만이 죄를 사하는 권세가 있는 줄 믿습니다.\n'
        '\n'
        '7) 하나님! 내가 시험에 들지 않기를 원합니다.\n'
        '하나님의 선하신 뜻을 헤아리지 못하고 한순간의 불평, 불만의 내뱉음으로 인해 내 앞의 축복을 쏟아버리게 하는 사탄의 시험에 들지 않게 하옵소서.\n'
        '\n'
        '8) 하나님! 나를 악에서 구원하여 주옵소서.\n'
        '나의 마음속에 있는 불평, 불만의 악에서 구원하셔서 감사하는 마음으로 넘치게 하옵소서.\n'
        '또한 세상의 수많은 악에 물들지 않도록 지켜 주옵소서.\n'
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
}