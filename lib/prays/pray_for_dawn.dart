import 'package:flutter/material.dart';
import 'package:pray_training/pray_list.dart';

import '../bottom_navi.dart';

class PrayForDawn extends StatefulWidget {
  List<Map<String, dynamic>> list;

  PrayForDawn(this.list);

  @override
  State<StatefulWidget> createState() => _PrayForDawn();
}

class _PrayForDawn extends State<PrayForDawn> {
  late List<Map<String,dynamic>> list;
  int index = -1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    list = widget.list;
    index = getIndex(list, 'dawn');
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('24. 하루를 시작하며 드리는 기도'),
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

        '2) 하나님의 나라가 오늘 하루도 나에게 이루어지기를 원합니다.\n'
        '나의 심령에 의와 평강과 희락이 항상 있게 하옵소서.\n'
        '또한 하나님의 통치가 있기를 원합니다.\n'
        '\n'

        '3) 하나님의 뜻이 하늘에서 이루어진 것 같이 오늘 하루도 나의 생활 속에서 이루어지기를 원합니다.\n'
        '\n'

        '4) 오늘도 새로운 날을 주심을 감사드립니다.\n'
        '나의 삶의 터전에서 기쁨과 감사함으로 생활하게 하옵소서.\n'
        '여러 사람들의 만남과 여러 가지 사건을 통해서 일어나는 일들을 지혜롭고 은혜롭게, 그리고 사람을 살리는 쪽으로 결정하며 살아가게 하옵소서.\n'
        '내 가정에서 직장(학교)에서 오늘 나에게 주신 시간들을 보람되게 보낼 수 있도록 인도하여 주옵소서.\n'
        '나에게 맡겨진 일들을 주님이 주시는 지혜로 성실히 감당하게 하옵소서.\n'
        '오늘 하루 나의 입술을 통해 나오는 말들이 다른 사람을 비판하고 저주하는 말이 아니라 축복의 말이 되게 하옵소서.\n'
        '내 주변의 믿지 않는 사람들이 나를 통해 구원받기를 원합니다.\n'
        '허락되는 대로 복음을 전하게 하시며 사람들을 구원하게 하옵소서.\n'
        '오늘도 내 삶의 현장에 귀한 영혼을 보내주셔서 하나님의 영혼 구원의 뜻을 이루는 데 사용하여 주옵소서.\n'
        '사탄의 권세를 이기고 세상을 정복하는 하루가 되도록 능력을 주시어 사용하옵소서.\n'
        '그리고 하나님의 은혜로 오늘 하루가 기쁘고 즐거운 날이 되기를 원합니다.\n'
        '\n'

        '5) 하나님! 다른 사람의 죄를 용서합니다. 나에게 상처를 주고 힘들게 했던 사람을 용서합니다.\n'
        '예수님의 이름으로 용서합니다.\n'
        '그리고 그를 축복합니다.\n'
        '그가 하나님을 경외하고 복 받기를 원합니다.\n'
        '\n'

        '6) 하나님! 다른 사람의 죄를 용서해 준 것 같이 나의 죄를 사하여 주옵소서.\n'
        '하나님만이 죄를 사하는 권세가 있는 줄 믿습니다.\n'
        '\n'

        '7) 하나님! 오늘도 내가 시험에 들지 않기를 원합니다.\n'
        '마귀에게 시험당하지 않기를 원합니다.\n'
        '물질이나 명예, 가정에서 신앙생활에서 시험에 들지 않도록 지켜 주옵소서.\n'
        '\n'

        '8) 하나님! 오늘 하루도 나를 악에서 구원하여 주옵소서.\n'
        '나의 마음속에 있는 여러 가지 악에서 구원하셔서 선한 마음으로 인도해 주옵소서.\n'
        '또한 세상의 악에 물들지 않도록 지켜 주옵소서.\n'
        '나는 연약하오니 하나님께서 악을 이길 수 있는 힘을 공급하여 주옵소서.\n'
        '\n'

        '9) 하나님의 나라와 권세와 영광이 영원히 하나님 아버지께 있사오며,\n'
        '\n'

        '10) 예수님의 이름으로 기도드립니다.\n'
        '\n'

        '아멘.\n';

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