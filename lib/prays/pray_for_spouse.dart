import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pray_training/params.dart';
import 'package:pray_training/pray_list.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

import '../bottom_navi.dart';
import '../pray_body.dart';

class PrayForSpouse extends StatefulWidget {
  final Future<Database> db;
  List<Map<String,dynamic>> list;
  List<String> winList;
  Function callback;

  PrayForSpouse(this.db, this.list, this.winList, this.callback);

  @override
  State<StatefulWidget> createState() => _PrayForSpouse();
}

class _PrayForSpouse extends State<PrayForSpouse> {
  late TextEditingController dataController;
  late List<Map<String,dynamic>> list;
  int index = -1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // params = getParams('spouse');
    dataController = TextEditingController();
    list = widget.list;
    index = getIndex(list, 'spouse');
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Scaffold(
      appBar: AppBar(
        title: Text('21. 부부간에 불화가 있을 때 드리는 기도'),
      ),
      drawer: PrayList(),
      bottomNavigationBar: BottomNavi(list, index),
      body: PrayBody(widget.winList, 'spouse', getPray(), widget.callback),
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
            param3: maps[i]['param3']);
      }
    });

    return p;
  }

  Future<List<TextSpan>> getPray() async {
    // final Object args = params!.then((value) => value.param1);
    Params params = await getParams('spouse');
    // final args = await params.the
    String? param = params.param1 ?? '남편(아내)';
    String ext1 = param == '남편' ? '을' : '를';
    String ext2 = param == '남편' ? '이' : '가';
    String ext3 = param == '남편' ? '으로' : '로';

    final String prayContent =
        '1) 하나님은 거룩하신 분이십니다.\n'
            '하나님 아버지의 이름이 나를 통하여 거룩히 여김 받으시기를 원합니다.\n'
            '또한 나의 '+param+ext1+' 통하여 거룩히 여김 받으시기를 원합니다.\n'
            '\n'
            '2) 하나님의 나라가 지금 이시간에 나에게 이루어지기를 원합니다.\n'
            '나와 '+param+'의 심령에 의와 평강과 희락이 항상 있게 하옵소서.\n'
            '\n'
            '3) 하나님의 뜻이 하늘에서 이루어진 것 같이 나와 '+param+ext1+' 통하여 이땅에 이루어지기를 원합니다.\n'
            '\n'
            '4) 하나님, 지금 우리 부부 사이에 서로를 이해하지 못하고, 각자의 이기적인 마음 때문에 짜증과 불평과 성내는 마음이 자리잡고 있습니다.\n'
            '서로의 잘못을 인정하지 못하고 내 안의 분노를 다스리지 못하고 있습니다.\n'
            '모든 죄인들을 품으신 주님의 그 사랑을 받은 자들로서 행하지 못하고 악을 품고 있습니다.\n'
            '하나님! 용서하여 주옵소서.\n'
            '하나님 아버지! 부부로 짝 지어주신 하나님의 뜻을 올바로 깨닫게 하셔서 우리 부부가 서로 돕는 자가 되게 하옵소서.\n'
            '서로를 신뢰하게 하옵소서.\n'
            '서로에게 지나친 기대를 하기보다는 섬기는 자가 되게 하여 주옵소서.\n'
            '남편에게 주께 하듯 하고, 아내를 자신의 몸과 같이 사랑하라고 하신 말씀을 깨닫게 하옵소서.\n'
            '파괴적인 말과 습관적인 행동으로 인해 서로에게 상처를 주지 않게 하옵소서.\n'
            '또한 상처와 실망으로 인해 우리 부부의 사랑이 사라지거나 흔들리지 않도록 지켜 주옵소서.\n'
            '우리 부부사이의 불화를 조성하게 하는 사탄의 역사를 예수님의 이름으로 결박하사 물리쳐 주옵소서.\n'
            '성령 하나님이 우리들의 마음속에 들어오셔서 통치하여 주시고, 서로 돕고 사랑하고 이해하고 용서하는 부부가 되게 하옵소서.\n'
            '환경에 관계없이 조그만 일에도 머리숙여 감사할 수 있는 마음을 주시며 사소한 일도 서로를 배려하고 이해하는 마음을 가지게 하옵소서.\n'
            '우리 부부의 갈등으로 자녀들이 상처 받지 않게 하옵소서.\n'
            '우리가 좋은 가정을 꾸며서 자녀들이보고 배우게 하옵소서.\n'
            '\'내가 죽어야 가정이산다.\',\'내가 가정의 십자가를 지고 가야한다.\'는 말씀을 마음에 새기며 예수님처럼 오래 참고 살아가게 하옵소서.\n'
            '우리 부부가 행복하여 하나님을 기쁘게 하는 부부가 되게 하여 주시기를 기도합니다.\n'
            '\n'
            '5) 하나님! '+param+'의 죄를 용서합니다.\n'
            '나에게 상처를 주고 힘들게 했던 '+param+ext1+' 용서합니다.\n'
            '예수님의 이름으로 용서합니다.\n'
            +param+ext2+' 하나님의 뜻을 이루는 자가 되도록 축복하여 주옵소서.\n'
            '하나님이 나를 온전히 말없이 용서하여 주시는 것처럼 나도 용서하게 하옵소서.\n'
            '\n'
            '6) 하나님! '+param+'의 죄를 용서해 주었으니 나의 죄를 용서하여 주옵소서.\n'
            '하나님만이 죄를 사하는 권세가 있는 줄 믿습니다.\n'
            '\n'
            '7) 하나님! 내가 '+param+ext3+' 인해 시험에 들지 않기를 원합니다.\n'
            '우리 부부를 사탄의 시험에 버려두지 마옵소서.\n'
            '\n'
            '8) 하나님! 우리 부부를 악에서 구원하여 주옵소서.\n'
            '우리의 마음속에 있는 여러가지 악에서 구원하셔서 선한 마음으로 인도해 주옵소서.\n'
            '또한 세상의 악에 물들지 않도록 지켜주옵소서.\n'
            '\n'
            '9) 하나님의 나라와 권세와 영광이 영원히 하나님 아버지께 있사오며,\n'
            '\n'
            '10) 예수님의 이름으로 기도드립니다. 아멘\n';

    final wordToStyle = param;
    final wordStyle = TextStyle(color: Colors.blue);
    final wordTarget = TapGestureRecognizer()..onTapDown = (p) => {Navigator.pushNamed(context, '/conf/spouse')};
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
      spans.add(TextSpan(text: spanText, style: style)); //, recognizer: recognizer));

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