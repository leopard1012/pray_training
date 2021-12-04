import 'package:flutter/material.dart';
import 'package:pray_training/pray_list.dart';
import 'package:sqflite/sqflite.dart';

import '../params.dart';

class PrayForPerson extends StatefulWidget {
  final Future<Database> db;

  PrayForPerson(this.db);

  @override
  State<StatefulWidget> createState() => _PrayForPerson();
}

class _PrayForPerson extends State<PrayForPerson> {
  late TextEditingController dataController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dataController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Scaffold(
      appBar: AppBar(
        title: Text('06. param을 위한 기도'),
      ),
      drawer: PrayList(),
      body: Center(
        child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(0),
                child: TextField(
                  controller: dataController,
                  decoration: const InputDecoration(labelText: 'param'),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Params param = Params(pray: 'person',
                      param1: dataController.value.text,
                      param2: 'param2',
                      param3: 'param3');
                  _insertData(param);
                },
                child: const Text('저장하기'),
              ),

              SingleChildScrollView(
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
            ]
        ),
      ),
    );
  }

  void _insertData(Params param) async {
    final Database database = await widget.db;
    await database.insert('params', param.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
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
    Params params = await getParams('person');

    String? target = params.param1 == null ? "OOO" : params.param1.toString();
    String? withPray = params.param2 == null ? "(OOO를 위한 중보기도)" : params.param2.toString();
    String? accident = params.param3 == null ? "()" : params.param3.toString();

    final String prayContent =
        '1) 하나님 아버지는 거룩하십니다.\n'
        '하나님 아버지의 이름이 '+target+' 통하여 거룩히 여김 받으시기를 원합니다.\n'
    '그리고 '+target+' 하나님의 이름을 거룩히 여기는 일을 찾아서 하기를 원합니다.\n'
    '\n'
    '2) 하나님의 나라가 '+target+' 이루어지기를 원합니다.'
    '그리하여'+target+' 심령에 의와 평강과 희락이 항상 있어 마음의 천국이 이루어지게 하옵소서.'
    '그리고 '+target+' 하나님의 통치를 받으며 하나님 나라의 법을 소중히 여기고 지키며 살게 하옵시고, 하나님 나라의 영광을 위하여 일하게 하옵소서.'
    '그리고 '+target+' 통하여 하나님 나라가 세상 모든 사람 전파되기를 원합니다.'
    ''
    '3) 하나님의 뜻이 하늘에서 이루어진 것 같이 땅에서 '+target+' 이루어지기를 원합니다.'
    '또 '+target+' 하나님의 뜻인 전도와 선과 의를 행하며 이웃에게 피해를 주지 않고 도움이 되는 삶을 살기를 기도합니다.'
    '하나님의 뜻이 '+target+' 통하여 온 땅에 전파되기를 원합니다.'
    ''
    '4) 하나님께서 '+target+' 평생 동안 일용할 양식을 공급해 주시기를 원합니다.'
    '또 세상에서 살아가는데 필요한 것을 공급하여 주시기를 원합니다.'
    ' '+target+' 하는 일들을 축복하여 주옵소서.'
    '그리고 큰 믿음과 건강을 주옵시며, 항상 하나님을 기쁘게 하는 사람 되게 하옵소서.'
    ''
    +withPray+
    ' '+target+' 풍성한 물질을 주셔서 하나님을 위하여 언제나 즐거운 마음으로 풍성하게 드리게 하옵시며, 모범적으로 충성하고 헌신하는 사람이 되게 하옵소서.'
    '목사님에게 순종하며 섬기는 믿음을 주옵시고, 성도를 사랑하며 겸손히 섬기는 신앙을 주옵소서.'
    '가정에 충실하고 믿음의 사람이 되어 가정을 신앙으로 이끌게 하옵소서.'
    '예수님의 가르침대로 온유하고 겸손한 사람이 되어 사람들에게 좋은 본이 되게 하옵소서.'
    '그리고 세상에서 믿음으로 살며 존경과 신뢰를 얻는 사람이 되게 하옵소서.'
    '지혜와 명철함을 주옵시고, 사랑과 오래 참음의 은사들을 공급하여 주옵소서.'
    '또 풍성하여 이웃들에게 나누어 주며 살게 하옵소서.'
    '또한 '+target+' 주변 사람들이 모두 구원받기를 원합니다.'
    '그들을 구우너하시어 하나님의 일꾼으로 사용하여 주옵소서.'
    ''
    '5) 하나님! 다른 사람의 죄를 용서합니다.'
    '나에게 상처를 주고 힘들게 하였던 '+target+' 용서합니다.'
    ' '+accident+' 일로 나에게 상처를 주었습니다.'
    '하지만 예수님의 말씀에 순종하여 용서합니다.'
    '그리고 '+target+' 축복합니다.'
    ' '+target+' 하나님을 경외하고 복 받기를 원합니다.'
    ''
    '6) 하나님! 다른 사람의 죄를 용서하여 준 것 같이 나의 죄를 사하여 주옵소서.'
    '하나님만이 죄를 사하는 권세가 있는줄 믿습니다.'
    ''
    '7) 하나님! '+target+' 시험에 들지 않기를 원합니다.'
    '마귀에게 시험당하지 않기를 원합니다.'
    '세상에서 시험당하지 않기를 원합니다.'
    '물질이나 명예로 시험당하지 않기를 원합니다.'
    '사람들로 인해 시험 들지 않기를 원합니다.'
    '신앙생활에 시험이 들지 않기를 원합니다.'
    '사업장의 생활과 교인들로 인하여 시험 들지 않기를 원합니다.'
    '가정에서 시험에 들지 않기를 원합니다.'
    ' '+target+' 시험에 들지 않도록 지켜 주옵소서.'
    ''
    '8) 하나님! '+target+' 를 악에서 구원하여 주옵소서.'
    '우리에게는 악이 가득합니다.'
    '사탄이 망므속에 악을 넣었습니다.'
    '그래서 불평, 불만, 미움, 시기, 질투, 욕심, 원망, 정죄, 비판, 욕, 저주, 거짓, 불신앙, 불충, 불성실, 불순종, 인색함, 음란, 음행, 간음, 낙심, 슬픔, 우울함, 실망, 자살, 교만, 오만, 거역, 이기심, 나태, 게으름, 무사안일, 혈기, 신경질, 자랑, 더러운 마음, 배신 등의 악이 가득합니다.'
    '이러한 악에서  '+target+' 구원받기를 원합니다.'
    '악을 주는 사탄의 세력을 쫓아 주옵소서.'
    '그리고 악에서  '+target+' 구원하여 교회로 인도하여 주옵소서.'
    ' '+target+' 세상의 악에 물들지 않도록 지켜 주옵소서.'
    ' '+target+' 연약하오니 하나님께서 악을 물리치고 이길 수 있는 힘을 공급하여 주옵소서.'
    ''
    '9) 하나님의 나라와 권세와 영광이 영원히, 영원히 하나님 아버지께 있사오며,'
    ''
    '10) 예수님의 이름으로 기도드립니다. 아멘.';

    // final wordToStyle1 = target;
    // final wordToStyle2 = withPray;
    // final wordToStyle3 = accident;
    final wordToStyle = [target, withPray, accident];
    final wordStyle = TextStyle(color: Colors.blue);
    final spans = _getSpans(prayContent, wordToStyle, wordStyle);

    return spans;
  }

  List<TextSpan> _getSpans(String text, List<String> matchWordList, TextStyle style) {
    // 여러개 어떻게 style 넣을 건지 확인필요
    matchWordList.forEach((matchWord) {
      List<TextSpan> spans = [];
      int spanBoundary = 0;
      do {
        // 전체 String 에서 키워드 검색
        final startIndex = text.indexOf(matchWord, spanBoundary);

        // 전체 String 에서 해당 키워드가 더 이상 없을때 마지막 KeyWord부터 끝까지의 TextSpan 추가
        if (startIndex == -1) {
          spans.add(TextSpan(text: text.substring(spanBoundary)));
          continue;
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
    });

    return spans;
  }
}