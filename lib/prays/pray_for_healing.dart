import 'package:flutter/material.dart';
import 'package:pray_training/pray_list.dart';

import '../bottom_navi.dart';

class PrayForHealing extends StatefulWidget {
  List<Map<String, dynamic>> list;

  PrayForHealing(this.list);

  @override
  State<StatefulWidget> createState() => _PrayForHealing();
}

class _PrayForHealing extends State<PrayForHealing> {
  late List<Map<String,dynamic>> list;
  int index = -1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    list = widget.list;
    index = getIndex(list, 'healing');
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('20. 몸이 아플 때 드리는 기도'),
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
        '나의 심령에 의와 평강과 희락이 항상 있게 하옵소서.\n'
        '\n'
        '3) 하나님의 뜻이 하늘에서 이루어진 것 같이 나를 통하여 이 땅에서 이루어지기를 원합니다.\n'
        '\n'
        '4) 생명을 주신 하나님, 주님이 주신 몸을 잘 관리하지 못함으로 인해 고통받고 있습니다.\n'
        '죄로 인해 건강을 해친 것이 아닌지 깨닫게 하여 주시고, 죄로 인한 것이라면 회개하오니 용서하여 주옵소서.\n'
        '그리고 나의 질병을 치료하여 주옵소서.\n'
        '사탄이 틈타서 질병이 생긴 것이라면 깨닫게 하시며 주님께서 말씀으로 물리쳐 주셔서 건강하게 하옵소서.\n'
        '그리고 나도 기도로 이기게 하옵소서.\n'
        '불순종으로 질병이 생겼으면 나로 깨닫게 하시며 회개하고 순종하게 하옵소서.\n'
        '하나님이 주신 육체의 관리를 잘못하여 질병이 생겼으면 깨닫게 하시고 치료하여 주옵소서.\n'
        '하나님은 치료의 하나님이심을 믿습닏다.\n'
        '하나님은 문둥병자를 치료하시고 죽은 자를 살리시는 치료의 하나님이심을 믿습니다.\n'
        '이 시간에 나의 병을 깨끗하게 하실 수 있나이다.\n'
        '깨끗하게 치료하여 주옵소서.\n'
        '\n'
        '믿습니다! 믿습니다! 믿습니다! 아멘!\n'
        '나의 육신의 연약함으로 내 주변의 식구들을 너무 오랫동안 힘들게 하지 않도록 인도하여 주옵소서.\n'
        '내가 질병으로 짜증이나 불만, 불평의 말들을 하지 않도록 하옵소서.\n'
        '또한 육신의 연약함이 영적인 침체를 가져오지 않게 하옵소서.\n'
        '이제 이후로는 부지런히 일하며 영, 육간의 균형을 지혜롭게 관리하게 하셔서 질병으로부터 자유할 수 있도록 지켜 주옵소서.\n'
        '모든 연약한 자를 치유하신 주님의 사랑의 손길이 나에게도 임하시길 기도합니다.\n'
        '치유 받은 후로는 열심히 전도하며 하나님의 증인이 되겠습니다.\n'
        '\n'
        '5) 하나님! 다른 사람의 죄를 용서합니다.\n'
        '나에게 상처를 주고 힘들게 했던 사람을 용서합니다.\n'
        '예수님의 이름으로 용서합니다.\n'
        '그리고 그를 축복합니다.\n'
        '그가 하나님을 경외하고 복 받기를 원합니다.\n'
        '\n'
        '6) 하나님! 다른 사람의 죄를 용서해 준 것 같이 나의 죄를 사하여 주옵소서.\n'
        '하나님만이 죄를 사하는 권세가 있는 줄 믿습니다.\n'
        '\n'
        '7) 하나님! 내가 시험에 들지 않도록 사탄으로부터 지켜 주시기를 원합니다.\n'
        '육신의 연약함을 이용해 사탄이 틈타지 못하도록 지켜 주옵소서.\n'
        '\n'
        '8) 하나님! 나의 마음속에 있는 여러 가지 악에서 구원하셔서 선한 마음으로 인도해 주옵소서.\n'
        '또한 세상의 악에 물들지 않도록 지켜주옵소서.\n'
        '나는 연약하오니 하나님께서 악을 이길 수 있는 힘을 공급하여 주옵소서.\n'
        '악에 빠지지 않게 하옵소서.\n'
        '\n'
        '9) 하나님의 나라와 권세와 영광이 영원히 하나님 아버지께 있사오며,\n'
        '\n'
        '10) 예수님의 이름으로 기도드립니다. 아멘\n';

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