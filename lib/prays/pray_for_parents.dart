import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pray_training/pray_list.dart';
import 'package:sqflite/sqflite.dart';

import '../bottom_navi.dart';
import '../params.dart';

class PrayForParents extends StatefulWidget {
  final Future<Database> db;
  List<Map<String,dynamic>> list;

  PrayForParents(this.db, this.list);

  @override
  State<StatefulWidget> createState() => _PrayForParents();
}

class _PrayForParents extends State<PrayForParents> {
  // late TextEditingController dataController;
  late List<Map<String,dynamic>> list;
  int index = -1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // dataController = TextEditingController();
    list = widget.list;
    index = getIndex(list, 'parents');
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Scaffold(
      appBar: AppBar(
        title: Text('10. 부모님을 위한 기도'),
      ),
      drawer: PrayList(),
      bottomNavigationBar: BottomNavi(list, index),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(8.0),
          scrollDirection: Axis.vertical,
          child: FutureBuilder(
              future: getPray(),
              builder: (BuildContext context,
                  AsyncSnapshot<List<TextSpan>> snapshot) {
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
    Params params = await getParams('parents');

    String? target = params.param1 == null ? "(아버지/어머니)" : params.param1.toString();
    String? withPray = params.param2 == null ? "(부모를 위한 중보기도)" : params.param2.toString();
    target = target == "" ? '(아버지/어머니)' : target;
    withPray = withPray == "" ? '(부모를 위한 중보기도)' : withPray;

    List<TextSpan> textSpanList = [];
    textSpanList.add(TextSpan(text: '1) 하나님 아버지는 거룩하신 분입니다.\n'));
    textSpanList.add(TextSpan(text: '하나님 아버지의 이름이 '));
    textSpanList.add(TextSpan(text: target, style: TextStyle(color: Colors.blue),
        recognizer: TapGestureRecognizer()..onTapDown = (p) => {Navigator.pushNamed(context, '/conf/parents')} ));
    textSpanList.add(TextSpan(text: '을(를) 통하여 거룩히 여김 받으시기를 원합니다.\n'));
    textSpanList.add(TextSpan(text: '그러므로 '));
    textSpanList.add(TextSpan(text: target, style: TextStyle(color: Colors.blue), recognizer: TapGestureRecognizer()..onTapDown = (p) => {Navigator.pushNamed(context, '/conf/parents')} ));
    textSpanList.add(TextSpan(text: '이(가) 하나님의 이름을 거룩히 할 일만 행하기를 원합니다.\n'));
    textSpanList.add(TextSpan(text: '\n'));
    textSpanList.add(TextSpan(text: '2) 하나님 나라를 창조하시고 사람의 믿음을 보시고 은혜로 주심을 감사합니다.\n'));
    textSpanList.add(TextSpan(text: '하나님의 나라가 '));
    textSpanList.add(TextSpan(text: target, style: TextStyle(color: Colors.blue), recognizer: TapGestureRecognizer()..onTapDown = (p) => {Navigator.pushNamed(context, '/conf/parents')} ));
    textSpanList.add(TextSpan(text: '에게 이루어지기를 원합니다.\n'));
    textSpanList.add(TextSpan(text: '그리하여 '));
    textSpanList.add(TextSpan(text: target, style: TextStyle(color: Colors.blue), recognizer: TapGestureRecognizer()..onTapDown = (p) => {Navigator.pushNamed(context, '/conf/parents')} ));
    textSpanList.add(TextSpan(text: '에게 의와 평강과 희락이 항상 있게 하옵소서.\n'));
    textSpanList.add(TextSpan(text: '그리고 '));
    textSpanList.add(TextSpan(text: target, style: TextStyle(color: Colors.blue), recognizer: TapGestureRecognizer()..onTapDown = (p) => {Navigator.pushNamed(context, '/conf/parents')} ));
    textSpanList.add(TextSpan(text: '이(가) 하나님의 통치를 받으며 하나님의 백성답게 하나님 나라의 법을 지키며 살게 하옵시고, 하나님 나라의 영광을 위하여 일하게 하옵소서.\n'));
    textSpanList.add(TextSpan(text: '그리고 '));
    textSpanList.add(TextSpan(text: target, style: TextStyle(color: Colors.blue), recognizer: TapGestureRecognizer()..onTapDown = (p) => {Navigator.pushNamed(context, '/conf/parents')} ));
    textSpanList.add(TextSpan(text: '을(를) 통하여 하나님 나라가 세상 모든 사람들에게 전파되기를 원합니다.\n'));
    textSpanList.add(TextSpan(text: '\n'));
    textSpanList.add(TextSpan(text: '3) 하나님의 뜻이 하늘에서 이루어진 것 같이 땅에서 '));
    textSpanList.add(TextSpan(text: target, style: TextStyle(color: Colors.blue), recognizer: TapGestureRecognizer()..onTapDown = (p) => {Navigator.pushNamed(context, '/conf/parents')} ));
    textSpanList.add(TextSpan(text: '에게 이루어지기를 원합니다.\n'));
    textSpanList.add(TextSpan(text: '또 '));
    textSpanList.add(TextSpan(text: target, style: TextStyle(color: Colors.blue), recognizer: TapGestureRecognizer()..onTapDown = (p) => {Navigator.pushNamed(context, '/conf/parents')} ));
    textSpanList.add(TextSpan(text: '을(를) 통하여 하나님의 선하신 뜻이 이루어지기를 기도합니다.\n'));
    textSpanList.add(TextSpan(text: '하나님의 뜻이 '));
    textSpanList.add(TextSpan(text: target, style: TextStyle(color: Colors.blue), recognizer: TapGestureRecognizer()..onTapDown = (p) => {Navigator.pushNamed(context, '/conf/parents')} ));
    textSpanList.add(TextSpan(text: '을(를) 통하여 온 땅에 전파되기를 원합니다.\n'));
    textSpanList.add(TextSpan(text: '\n'));
    textSpanList.add(TextSpan(text: '4) 하나님께서 '));
    textSpanList.add(TextSpan(text: target, style: TextStyle(color: Colors.blue), recognizer: TapGestureRecognizer()..onTapDown = (p) => {Navigator.pushNamed(context, '/conf/parents')} ));
    textSpanList.add(TextSpan(text: '에게 평생 동안 일용할 양식을 공급해 주시기를 원합니다.\n'));
    textSpanList.add(TextSpan(text: '또 세상에서 살아가는데 필요한 것을 공급해 주시기를 원합니다.\n'));
    textSpanList.add(TextSpan(text: '\n'));
    textSpanList.add(TextSpan(text: withPray, style: TextStyle(color: Colors.blue), recognizer: TapGestureRecognizer()..onTapDown = (p) => {Navigator.pushNamed(context, '/conf/parents')} ));
    textSpanList.add(TextSpan(text: '\n'));
    textSpanList.add(TextSpan(text: target, style: TextStyle(color: Colors.blue), recognizer: TapGestureRecognizer()..onTapDown = (p) => {Navigator.pushNamed(context, '/conf/parents')} ));
    textSpanList.add(TextSpan(text: '에게 현재 필요한 것들이 많이 있습니다.\n'));
    textSpanList.add(TextSpan(text: '하나님께서 공급하여 주옵소서.\n'));
    textSpanList.add(TextSpan(text: '또 풍성하여 이웃들에게 나누어 주며 살게 하옵소서.\n'));
    textSpanList.add(TextSpan(text: '또한 '));
    textSpanList.add(TextSpan(text: target, style: TextStyle(color: Colors.blue), recognizer: TapGestureRecognizer()..onTapDown = (p) => {Navigator.pushNamed(context, '/conf/parents')} ));
    textSpanList.add(TextSpan(text: ' 주변의 사람들이 모두 구원받기를 원합니다.\n'));
    textSpanList.add(TextSpan(text: '그들을 구원하시어 하나님의 일꾼으로 사용하여 주옵소서.\n'));
    textSpanList.add(TextSpan(text: '그리고 노년에 영혼이 잘되게 하시며 육신은 건강하게 사시다가 하나님 나라에 가게 하옵소서.\n'));
    textSpanList.add(TextSpan(text: '또 항상 말씀을 묵상하고 기도하시다가 하나님의 부름을 받게 하옵소서.\n'));
    textSpanList.add(TextSpan(text: '하나님이 부르시는 그날을 생각하며 전도하고 충성하게 하옵소서.\n'));
    textSpanList.add(TextSpan(text: '하나님 나라에 가서 영광 얻을 일을 많이 하게 하옵소서.\n'));
    textSpanList.add(TextSpan(text: '\n'));
    textSpanList.add(TextSpan(text: '5) 하나님! '));
    textSpanList.add(TextSpan(text: target, style: TextStyle(color: Colors.blue), recognizer: TapGestureRecognizer()..onTapDown = (p) => {Navigator.pushNamed(context, '/conf/parents')} ));
    textSpanList.add(TextSpan(text: '의 죄를 용서합니다.\n'));
    textSpanList.add(TextSpan(text: '나에게 상처를 주고 힘들게 하였던 '));
    textSpanList.add(TextSpan(text: target, style: TextStyle(color: Colors.blue), recognizer: TapGestureRecognizer()..onTapDown = (p) => {Navigator.pushNamed(context, '/conf/parents')} ));
    textSpanList.add(TextSpan(text: '을(를) 용서합니다.\n'));
    textSpanList.add(TextSpan(text: '예수님의 이름으로 용서합니다.\n'));
    textSpanList.add(TextSpan(text: '그리고 '));
    textSpanList.add(TextSpan(text: target, style: TextStyle(color: Colors.blue), recognizer: TapGestureRecognizer()..onTapDown = (p) => {Navigator.pushNamed(context, '/conf/parents')} ));
    textSpanList.add(TextSpan(text: '을(를) 축복합니다.\n'));
    textSpanList.add(TextSpan(text: '영혼이 잘되고 하나님을 경외하고 복 받기를 원합니다.\n'));
    textSpanList.add(TextSpan(text: '\n'));
    textSpanList.add(TextSpan(text: '6) 하나님! 다른 사람의 죄를 용서해 준 것 같이 나의 죄를 용서하여 주옵소서.\n'));
    textSpanList.add(TextSpan(text: '나도 하나님 앞에 죄인입니다.\n'));
    textSpanList.add(TextSpan(text: '하나님만이 죄를 사하는 권세가 있는 줄 믿습니다.\n'));
    textSpanList.add(TextSpan(text: '그리고 '));
    textSpanList.add(TextSpan(text: target, style: TextStyle(color: Colors.blue), recognizer: TapGestureRecognizer()..onTapDown = (p) => {Navigator.pushNamed(context, '/conf/parents')} ));
    textSpanList.add(TextSpan(text: '의 죄도 용서하여 주옵소서.\n'));
    textSpanList.add(TextSpan(text: '\n'));
    textSpanList.add(TextSpan(text: '7) 하나님! '));
    textSpanList.add(TextSpan(text: target, style: TextStyle(color: Colors.blue), recognizer: TapGestureRecognizer()..onTapDown = (p) => {Navigator.pushNamed(context, '/conf/parents')} ));
    textSpanList.add(TextSpan(text: '이(가) 시험에 들지 않기를 원합니다.\n'));
    textSpanList.add(TextSpan(text: '마귀에게 시험당하지 않기를 원합니다.\n'));
    textSpanList.add(TextSpan(text: '그러므로 마귀에게 시험을 허락지 마옵소서.\n'));
    textSpanList.add(TextSpan(text: '믿음에서 떠나는 시험을 허락하지 마옵소서.\n'));
    textSpanList.add(TextSpan(text: '또 세상에서 시험당하지 않기를 원합니다.\n'));
    textSpanList.add(TextSpan(text: '가난이나 물질, 질병, 불행한 사고, 세상 명예, 돈, 권력으로 시험당하지 않기를 원합니다.\n'));
    textSpanList.add(TextSpan(text: '교회 생활에 시험 들지 않기를 원합니다.\n'));
    textSpanList.add(TextSpan(text: '목회자나 성도, 교회에서 맡겨진 일들로부터 시험 들지 않기를 원합니다.\n'));
    textSpanList.add(TextSpan(text: target, style: TextStyle(color: Colors.blue), recognizer: TapGestureRecognizer()..onTapDown = (p) => {Navigator.pushNamed(context, '/conf/parents')} ));
    textSpanList.add(TextSpan(text: '에게 시험이 없기를 기도합니다.\n'));
    textSpanList.add(TextSpan(text: '\n'));
    textSpanList.add(TextSpan(text: '8) 하나님! '));
    textSpanList.add(TextSpan(text: target, style: TextStyle(color: Colors.blue), recognizer: TapGestureRecognizer()..onTapDown = (p) => {Navigator.pushNamed(context, '/conf/parents')} ));
    textSpanList.add(TextSpan(text: '을(를) 악에서 구원하여 주옵소서.\n'));
    textSpanList.add(TextSpan(text: target, style: TextStyle(color: Colors.blue), recognizer: TapGestureRecognizer()..onTapDown = (p) => {Navigator.pushNamed(context, '/conf/parents')} ));
    textSpanList.add(TextSpan(text: '에게 하나님의 법을 지키지 않는 악이 있습니다.\n'));
    textSpanList.add(TextSpan(text: '때때로 불순종과 급한 성품 그리고 말로 인한 악에서 '));
    textSpanList.add(TextSpan(text: target, style: TextStyle(color: Colors.blue), recognizer: TapGestureRecognizer()..onTapDown = (p) => {Navigator.pushNamed(context, '/conf/parents')} ));
    textSpanList.add(TextSpan(text: '을(를) 구원하여 주옵소서.\n'));
    textSpanList.add(TextSpan(text: target, style: TextStyle(color: Colors.blue), recognizer: TapGestureRecognizer()..onTapDown = (p) => {Navigator.pushNamed(context, '/conf/parents')} ));
    textSpanList.add(TextSpan(text: '이(가) 세상의 욕심의 악에 물들지 않도록 지켜 주옵소서.\n'));
    textSpanList.add(TextSpan(text: '악은 모양이라도 보지 않게 하옵소서.\n'));
    textSpanList.add(TextSpan(text: target, style: TextStyle(color: Colors.blue), recognizer: TapGestureRecognizer()..onTapDown = (p) => {Navigator.pushNamed(context, '/conf/parents')} ));
    textSpanList.add(TextSpan(text: '은(는) 연약하오니 하나님께서 악을 이길 수 있는 힘을 공급하여 주옵소서.\n'));
    textSpanList.add(TextSpan(text: '\n'));
    textSpanList.add(TextSpan(text: '9) 하나님의 나라와 권세와 영광이 영원히, 영원히 하나님 아버지께 있사오며,\n'));
    textSpanList.add(TextSpan(text: '\n'));
    textSpanList.add(TextSpan(text: '10) 예수님의 이름으로 기도드립니다.\n'));
    textSpanList.add(TextSpan(text: '\n'));
    textSpanList.add(TextSpan(text: '아멘.'));

    return textSpanList;
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