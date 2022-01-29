import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pray_training/pray_list.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../bottom_navi.dart';

class PrayForTired extends StatefulWidget {
  List<Map<String, dynamic>> list;
  Function callback;

  PrayForTired(this.list, this.callback);

  @override
  State<StatefulWidget> createState() => _PrayForTired();
}

class _PrayForTired extends State<PrayForTired> {
  late List<Map<String,dynamic>> list;
  int index = -1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    list = widget.list;
    index = getIndex(list, 'tired');
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('18. 삶에 지칠 때 드리는 기도'),
      ),
      drawer: PrayList(),
      bottomNavigationBar: BottomNavi(list, index),
      body: Column(
          children: <Widget>[
          Expanded(
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
          OutlinedButton(
              onPressed: (){
                _saveWinList(index);
                Fluttertoast.showToast(msg: '기도승리');
                if (index < 26) {
                  Navigator.pushReplacementNamed(context, '/' + list[index+1].keys.first);
                }
              },
              child: Text("기도승리"),
              style: OutlinedButton.styleFrom(
                  fixedSize: Size(300,10)
              )
          )
        ]
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
        '4) 내 삶의 모든 필요를 아시는 주님, 이 시간에 나의 짐들을 주님 앞에 내려놓기 원합니다.\n'
        '예수님께서 \"수고하고 무거운 짐을 진 자들아 다 내게로 오라 내가 너희를 편히 쉬게 하리라\"라고 하셨으니 그 말씀을 믿고 기도합니다.\n'
        '현재 내가 감당해야 할 삶의 무거운 짐들이 나를 힘들게 하고 지치게 합니다.\n'
        '내 심령이 걱정과 염려로 혼란 가운데 있습니다.\n'
        '사랑하는 주님! 나의 약함을 도와주옵소서.\n'
        '주안에서 새 힘을 얻게 하시고 세상에 짓눌리지 않게 하옵소서.\n'
        '주님께 온전히 모든 것을 맡기며 아뢰지 않고 나의 힘으로 해결하려고 하는 어리석은 행동을 하지 않도록 지켜 주옵소서.\n'
        '내가 여러가지 세상일과 어려운 문제들에 매여 종노릇 하지 않게 하시고 주님이 주시는 참된 평안으로 쉼을 얻게 하옵소서.\n'
        '세상에 낙심되고 지칠 때, 나보다 더 어려운 환경 속에서도 꿋꿋이 주님을 의지하여 감사하며 살아가는 믿음의 사람들을 보며 배우게 하옵소서.\n'
        '\n'
        '5) 하나님! 다른 사람의 죄를 용서합니다.\n'
        '나의 삶 가운데서 나에게 상처를 주고 힘들게 했던 사람을 용서합니다.\n'
        '예수님의 이름으로 용서합니다.\n'
        '그를 축복합니다.\n'
        '그 사람과의 좋은 관계를 통해 서로에게 힘을 주는 사람들이 되게 하옵소서.\n'
        '\n'
        '6) 하나님! 다른 사람의 죄를 용서해 준 것 같이 나의 죄를 용서하여 주옵소서.\n'
        '하나님만이 죄를 사하는 권세가 있는 줄 믿습니다.\n'
        '\n'
        '7) 하나님! 내가 시험에 들지 않기를 원합니다.\n'
        '내 삶 가운데서 사탄의 시험에 버려두지 마옵소서.\n'
        '\n'
        '8) 하나님! 나를 악에서 구원하여 주옵소서.\n'
        '나의 마음속에 있는 여러 가지 악에서 구원하셔서 선한 마음으로 인도해 주옵소서.\n'
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

  _saveWinList(int index) async {
    final prefs = await SharedPreferences.getInstance();
    const key = 'winList';
    List<String>? value = prefs.getStringList(key) ?? [];
    value.add(index.toString());
    prefs.setStringList(key, value);
    widget.callback(value);
  }
}