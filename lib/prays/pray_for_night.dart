import 'package:flutter/material.dart';
import 'package:pray_training/pray_list.dart';

import '../bottom_navi.dart';

class PrayForNight extends StatefulWidget {
  List<Map<String, dynamic>> list;

  PrayForNight(this.list);

  @override
  State<StatefulWidget> createState() => _PrayForNight();
}

class _PrayForNight extends State<PrayForNight> {
  late List<Map<String,dynamic>> list;
  int index = -1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    list = widget.list;
    index = getIndex(list, 'night');
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('25. 하루를 마감하며 드리는 기도'),
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
        '하루하루를 사는 나의 삶 속에서 모든 말과 행동을 통하여 하나님의 이름이 거룩히 여김 받으시기 원합니다.\n'
        '\n'
        '2) 하나님의 나라가 나에게 이루어지기를 원합니다.\n'
        '나의 심령에 의와 평강과 희락이 항상 있게 하옵소서.\n'
        '하나님의 통치를 받으며 살게 하옵소서.\n'
        '\n'
        '3) 하나님의 뜻이 하늘에서 이루어진 것 같이 나를 통하여 이 땅에서 이루어지기를 원합니다.\n'
        '\n'
        '4) 오늘 하루를 주님의 돌보심 가운데 아무런 사고 없이 지켜 주시고 가정으로 돌아오게 하심을 감사드립니다.\n'
        '영적으로 육적으로 여러 가지 일들을 경험하여 깨닫게 하시고 하나님이 함께해 주셔서 이 밤에 기도할 수 있게 하시니 감사합니다.\n'
        '또한 나의 가족들이 각자의 생활 터전에서 열심히 일하고 무사히 돌아오게 하심을 감사드립니다.\n'
        '매 순간마다 수많은 사고와 재난의 소식이 들려오는 가운데 나와 가족이 살아 숨 쉬는 것이 주님의 은혜임을 깨닫습니다.\n'
        '하루를 보내면서 여러 가지 일로 시달린 나의 마음을 이해해 주시고 품어 주시며, 남을 통해 받은 상처들을 말씀으로 치유해 주시니 감사합니다.\n'
        '이 밤에 평안한 안식의 시간을 주심을 감사드립니다.\n'
        '지친 우리의 몸과 마음이 주님이 주신 단잠을 통해 회복되게 하여 주옵소서.\n'
        '우리가 잠들어 있는 순간에도 천군 천사가 우리 가정을 지켜 주옵소서.\n'
        '(시 127:2)\"여호와께서 그 사랑하시는 자에게는 잠을 주시는 도다.\"라고 하였사오니 누우면 잠을 주시어 좋은 꿈을 꾸게 하옵소서.\n'
        '오늘 하루도 하나님의 은혜를 진심으로 감사드립니다.\n'
        '내일은 하나님이 준비해 놓으신 새로운 세계가 되기를 원합니다.\n'
        '\n'
        '5) 하나님! 다른 사람의 죄를 용서합니다.\n'
        '오늘도 나에게 말로 상처를 주고 힘들게 했던 사람을 용서합니다.\n'
        '예수님의 이름으로 용서합니다.\n'
        '그리고 그를 축복합니다.\n'
        '그가 하나님을 경외하고 복 받기를 원합니다.\n'
        '\n'
        '6) 하나님! 다른 사람의 죄를 용서해 준 것 같이 나의 죄를 사하여 주옵소서.\n'
        '나 또한 다른 사람에게 아무렇지 않게 상처 주는 일들을 하였음을 고백합니다.\n'
        '용서하여 주옵소서.\n'
        '하나님만이 죄를 사하는 권세가 있는 줄 믿습니다.\n'
        '\n'
        '7) 하나님! 내가 시험에 들지 않도록 인도하여 주옵소서.\n'
        '이 밤에도 사탄으로부터 지켜 주시기를 원합니다.\n'
        '\n'
        '8) 하나님! 이 밤에도 나의 마음속에 있는 여러 가지 악에서 구원해 주옵소서.\n'
        '마음을 정결케 하시고 꿈에서라도 악에 빠지지 않게 하옵소서.\n'
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