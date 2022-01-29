import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pray_training/pray_list.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../bottom_navi.dart';

class PrayForMoney extends StatefulWidget {
  List<Map<String, dynamic>> list;
  Function callback;

  PrayForMoney(this.list, this.callback);

  @override
  State<StatefulWidget> createState() => _PrayForMoney();
}

class _PrayForMoney extends State<PrayForMoney> {
  late List<Map<String,dynamic>> list;
  int index = -1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    list = widget.list;
    index = getIndex(list, 'money');
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('22. 물질적인 어려움에 있을 때 드리는 기도'),
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
        '4) 늘 우리에게 일용할 양식을 주시는 주님, 지금 우리 가정이 물질로 인해 어려움을 겪고 있습니다.\n'
        '혹시라도 물질을 궁핍함으로 인해 낙심하며 불평하는 마음이 생기지 않도록 지켜 주옵소서.\n'
        '하나님께 인색함이나 십일조, 약속한 헌물 등 드려야 할 것을 드리지 않음으로 인해 고난이 왔다면 깨닫게 하시며 회개의 영을 부어주셔서 회개하게 하시고, 다시는 같은 죄를 범하지 않게 하옵소서.\n'
        '연단으로 물질의 고난이 임했다면 훈련을 잘 받고 속히 연단이 끝나고 물질로 충성하게 하옵소서.\n'
        '모든 만물이 주님의 것임을 믿사오니 다른 사람에게 빚을 져야 하는 순간이 오지 않도록 지금의 위기를 벗어날 수 있는 길을 열어 주옵소서.\n'
        '빚으로 인해 자녀들이 부끄러움을 갖지 않도록 하옵소서.\n'
        '경멸이나 불신, 열등감을 갖지 않게 하옵소서.\n'
        '또한 물질로 인해 가정이 흔들리는 일이 없게 지켜 주옵소서.\n'
        '물질이 우리에게 하나님 보다 우선시되지 않게 하옵시고, 지금의 어려움을 지혜롭게 극복할 수 있도록 도와주옵소서.\n'
        '물질을 낭비하지 않고 합당하게 사용하는 방법을 깨닫게 하시고, 이후로 우리에게 주신 물질을 잘 관리하여 지혜롭게 하나님의 뜻을 이루는 데 사용하게 하옵소서.\n'
        '물질을 풍성할 때나 또한 지금처럼 어려울 때도 물질에 얽매이지 않고 자유할 수 있게 하옵소서.\n'
        '\n'
        '5) 하나님! 다른 사람의 죄를 용서합니다.\n'
        '물질의 어려움으로 고민하는 나의 마음에 상처를 주고 서운하게 했던 사람을 용서합니다.\n'
        '예수님의 이름으로 용서합니다.\n'
        '그리고 축복합니다.\n'
        '그 사람이 하나님을 경외하고 우리와 같은 물질적인 어려움을 겪는 일이 생기지 않기를 원합니다.\n'
        '\n'
        '6) 하나님! 다른 사람의 죄를 용서해 준 것 같이 나의 죄를 사하여 주옵소서.\n'
        '나도 죄인입니다.\n'
        '하나님만이 죄를 사하는 권세가 있는 줄 믿습니다.\n'
        '\n'
        '7) 하나님! 내가 이 물질로 인하여 시험에 들지 않도록 하옵소서.\n'
        '물질의 어려움을 이용하는 사탄으로부터 지켜 주시기를 원합니다.\n'
        '\n'
        '8) 하나님! 나의 마음속에 있는 물질의 욕심으로 인한 여러 가지 악에서 구원하여 주옵소서.\n'
        '세상의 악에 물들지 않도록 지켜주옵소서.\n'
        '나는 연약하오니 하나님께서 악을 이길 수 있는 힘을 공급하여 주옵소서.\n'
        '악에 빠지지 않게 하옵소서.\n'
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