import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pray_training/pray_list.dart';
import 'package:sqflite/sqflite.dart';

import '../bottom_navi.dart';
import '../params.dart';

class PrayForRepentance extends StatefulWidget {
  final Future<Database> db;

  PrayForRepentance(this.db);

  @override
  State<StatefulWidget> createState() => _PrayForRepentance();
}

class _PrayForRepentance extends State<PrayForRepentance> {
  // late TextEditingController dataController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // dataController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Scaffold(
      appBar: AppBar(
        title: Text('14. 회개기도'),
      ),
      drawer: PrayList(),
      bottomNavigationBar: BottomNavi(14),
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
    Params params = await getParams('repentance');

    String? target = params.param1 == null ? "다른 사람(이름)" : params.param1.toString();
    String? accident = params.param3 == null ? "죄(구체적으로)" : params.param3.toString();
    target = target == "" ? '다른 사람(이름)' : target;
    accident = accident == "" ? '죄(구체적으로)' : accident;

    List<TextSpan> textSpanList = [];
    textSpanList.add(TextSpan(text : '1) 하나님은 거룩한 분이십니다.\n'));
    textSpanList.add(TextSpan(text : '하나님 아버지의 이름이 나를 통하여 거룩히 여김 받으시기를 원합니다.\n'));
    textSpanList.add(TextSpan(text : '그러나 오랫동안 하나님의 이름을 거룩히 여기지 못하였음을 회개합니다.\n'));
    textSpanList.add(TextSpan(text : '나는 하나님의 이름을 욕되게 한 일들이 많이 있습니다.\n'));
    textSpanList.add(TextSpan(text : '나의 말들과 행동, 그리고 마음의 생각이 하나님의 이름을 욕되게 하였습니다.\n'));
    textSpanList.add(TextSpan(text : '십계명의 제3계명인 "여호와의 이름을 망령되이 일컫지 말라" 하신 것을 어겼습니다.\n'));
    textSpanList.add(TextSpan(text : '이러한 나의 죄를 예수 그리스도의 십자가의 은혜로 사하여 주옵소서.\n'));
    textSpanList.add(TextSpan(text : '\n'));
    textSpanList.add(TextSpan(text : '2) 하나님의 나라가 내게 이루어지기를 원합니다.\n'));
    textSpanList.add(TextSpan(text : '그리하여 내 심령에 의와 평강과 희락(하나님 믿는 기쁨)이 항상 있게 하옵소서.\n'));
    textSpanList.add(TextSpan(text : '내가 하나님의 통치를 받으며 하나님의 백성답게 하나님 나라의 법을 지키며 살게 하옵시고, 하나님 나라의 영광을 위하여 일하게 하옵소서.\n'));
    textSpanList.add(TextSpan(text : '그리고 나를 통하여 하나님 나라가 세상 모든 사람들에게 전파되기를 원합니다.\n'));
    textSpanList.add(TextSpan(text : '그동안 나의 심령 속에 하나님의 나라가 임한 증거가 없었습니다.\n'));
    textSpanList.add(TextSpan(text : '(롬 14:17) "하나님의 나라는 먹는 것과 마시는 것이 아니요 오직 성령 안에서 의와 평강과 희락이라"고 하였는데 \'의와 평강과 희락\'이 없었습니다.\n'));
    textSpanList.add(TextSpan(text : '이런 것보다는 세상의 부귀와 향락을 더 좋아했음을 회개합니다.\n'));
    textSpanList.add(TextSpan(text : '용서하여 주옵소서.\n'));
    textSpanList.add(TextSpan(text : '이제는 성령님이 주시는 \'의와 평강과 희락\'이 심령에 항상 있게 하사 마음의 천국을 이루고 살게 하옵소서.\n'));
    textSpanList.add(TextSpan(text : '그리고 영원한 하나님 나라를 창조하시고 사람의 믿음을 보시고 은혜로 주심을 감사합니다\n'));
    textSpanList.add(TextSpan(text : '그 나라에 들어가게 하옵소서.\n'));
    textSpanList.add(TextSpan(text : '\n'));
    textSpanList.add(TextSpan(text : '3) 하나님의 뜻이 하늘에서 이루어진 것 같이 땅에서 나에게 이루어지기를 원합니다\n'));
    textSpanList.add(TextSpan(text : '그리고 나를 통하여 하나님의 뜻이 세상에 이루어지기를 원합니다.\n'));
    textSpanList.add(TextSpan(text : '그동안 하나님의 뜻을 이루어 드리지 않고 나의 뜻을 이루기 위해서 살았습니다\n'));
    textSpanList.add(TextSpan(text : '교회 생활도 나의 뜻을 이루기 위해서 했고, 기도도 나의 뜻을 이루기 위해서 하였습니다.\n'));
    textSpanList.add(TextSpan(text : '입으로는 하나님의 뜻을 이룬다고 하면서도 실제로는 나의 뜻을 이루기 위해서 분주하게 살았습니다\n'));
    textSpanList.add(TextSpan(text : '하나님! 용서해 주옵소서.\n'));
    textSpanList.add(TextSpan(text : '나의 믿음 없는 것과 욕심이 죄를 범하였습니다.\n'));
    textSpanList.add(TextSpan(text : '진심으로 회개합니다.\n'));
    textSpanList.add(TextSpan(text : '남은 생애는 하나님의 뜻을 이루기 위해서 살겠습니다.\n'));
    textSpanList.add(TextSpan(text : '\n'));
    textSpanList.add(TextSpan(text : '4) 하나님께서 나에게 평생 동안 일용할 양식을 공급해 주시기를 원합니다.\n'));
    textSpanList.add(TextSpan(text : '하나님께서 일용할 양식을 구하라고 하셨는데 구하지 않은 것을 회개합니다.\n'));
    textSpanList.add(TextSpan(text : '게으름과 믿음 없는 행동을 보였습니다.\n'));
    textSpanList.add(TextSpan(text : '그러면서 항상 환경에 불만, 불평, 원망을 하며 살았습니다.\n'));
    textSpanList.add(TextSpan(text : '뿐만 아니라 주변 사람들에게도 불만, 불평만 하였습니다.\n'));
    textSpanList.add(TextSpan(text : '구약 성경에 이스라엘 백성들이 광야에서 불만, 불평의 죄를 지어 벌을 받은 것을 알면서도 같은 죄를 범하였습니다.\n'));
    textSpanList.add(TextSpan(text : '마음과 입으로 범죄하였사오니 용서하여 주옵소서.\n'));
    textSpanList.add(TextSpan(text : '그 외에도 하나님 앞에 부끄러운 죄들이 많이 있습니다.\n'));
    textSpanList.add(TextSpan(text : '너무 많아서 죄송합니다.\n'));
    textSpanList.add(TextSpan(text : '기도하지 않은 죄, 교회 사명을 감당하지 않은 죄, 가정에 충실하지 못한 죄, 부모와 자녀들에게 잘못한 죄, 십자가 지고 가지 못한 죄, 자아를 죽이지 못한 죄, 음란한 죄 등 많이 있습니다.\n'));
    textSpanList.add(TextSpan(text : '이 모든 죄를 회개하며 용서를 구합니다.\n'));
    textSpanList.add(TextSpan(text : '모두 사하여 주옵소서.\n'));
    textSpanList.add(TextSpan(text : '그리고 다시는 같은 죄를 범하지 않도록 믿음을 주옵소서.\n'));
    textSpanList.add(TextSpan(text : '\n'));
    textSpanList.add(TextSpan(text : '5) 하나님! '));
    textSpanList.add(TextSpan(text: target, style: TextStyle(color: Colors.blue), recognizer: TapGestureRecognizer()..onTapDown = (p) => {Navigator.pushNamed(context, '/conf/repentance')} ));
    textSpanList.add(TextSpan(text : '의 '));
    textSpanList.add(TextSpan(text: accident, style: TextStyle(color: Colors.blue), recognizer: TapGestureRecognizer()..onTapDown = (p) => {Navigator.pushNamed(context, '/conf/repentance')} ));
    textSpanList.add(TextSpan(text : '를 용서합니다.\n'));
    textSpanList.add(TextSpan(text : '나에게 상처를 주고 힘들게 하였던 사람들을 용서합니다.\n'));
    textSpanList.add(TextSpan(text : '예수님의 이름으로 용서합니다.\n'));
    textSpanList.add(TextSpan(text : '그리고 그를 축복합니다.\n'));
    textSpanList.add(TextSpan(text : '그가 하나님을 경외하고 복 받기를 원합니다.\n'));
    textSpanList.add(TextSpan(text : '지금까지는 다른 사람의 죄를 용서하지 못했습니다.\n'));
    textSpanList.add(TextSpan(text : '하나님의 말씀을 안다고 하면서도 실제로는 무지하였습니다\n'));
    textSpanList.add(TextSpan(text : '나의 죄가 사함 받지 못하는 이유를 알게 되었습니다.\n'));
    textSpanList.add(TextSpan(text : '그래서 마음의 상처가 치유되지 않고, 곤고하고, 성품이 변화되지 않고, 사소한 일로 시험 들고, 복을 못 받고, 자주 넘어지고, 세상 사는 것이 힘이 든 것을 알았습니다.\n'));
    textSpanList.add(TextSpan(text : '또 나의 죄가 그들의 죄보다 더 크다는 것을 알았습니다.\n'));
    textSpanList.add(TextSpan(text : '이 시간에 진심으로 회개합니다.\n'));
    textSpanList.add(TextSpan(text : '나의 죄를 그리스도의 십자가의 보혈로 사하여 주옵소서.\n'));
    textSpanList.add(TextSpan(text : '\n'));
    textSpanList.add(TextSpan(text : '6) 하나님! 다른 사람의 죄를 용서해 준 것 같이 나의 죄를 사하여 주옵소서.\n'));
    textSpanList.add(TextSpan(text : '특히 마귀의 무기인 거짓과 욕심으로 짓는 죄를 용서하여 주옵소서.\n'));
    textSpanList.add(TextSpan(text : '그리고 정직과 감사로 살게 하옵소서.\n'));
    textSpanList.add(TextSpan(text : '하나님은 죄를 사하는 권세가 있는 줄 믿습니다.\n'));
    textSpanList.add(TextSpan(text : '예수님의 십자가의 보혈로 씻어 주옵소서.\n'));
    textSpanList.add(TextSpan(text : '그리하여 나의 마음에 평안과 기쁨과 소망을 주옵소서.\n'));
    textSpanList.add(TextSpan(text : '\n'));
    textSpanList.add(TextSpan(text : '7) 하나님! 내가 시험에 들지 않기를 원합니다.\n'));
    textSpanList.add(TextSpan(text : '마귀에게 시험당하지 않기를 원합니다.\n'));
    textSpanList.add(TextSpan(text : '그동안 하나님께서 지켜주심으로 욥처럼 마귀에게 시험하라고 허락하지 않아 현재 내가 존재하는 것을 알았습니다\n'));
    textSpanList.add(TextSpan(text : '그런데 내가 잘해서 시험이 없는 줄로 착각하고 살았습니다.\n'));
    textSpanList.add(TextSpan(text : '내가 교만과 오만한 마음으로 살았던 것을 회개합니다.\n'));
    textSpanList.add(TextSpan(text : '앞으로도 하나님께서 마귀로부터 지켜 주옵소서.\n'));
    textSpanList.add(TextSpan(text : '세상에 시험당하지 않기를 원합니다\n'));
    textSpanList.add(TextSpan(text : '물질이나 명예로 시험당하지 않기를 원합니다.\n'));
    textSpanList.add(TextSpan(text : '신앙생활에 시험이 들지 않기를 원합니다.\n'));
    textSpanList.add(TextSpan(text : '교회 생활에 시험 들지 않기를 원합니다.\n'));
    textSpanList.add(TextSpan(text : '가정에서 시험에 들지 않기를 원합니다.\n'));
    textSpanList.add(TextSpan(text : '내가 시험에 들지 않도록 지켜 주옵소서.\n'));
    textSpanList.add(TextSpan(text : '\n'));
    textSpanList.add(TextSpan(text : '8) 하나님! 나를 악에서 구원하여 주옵소서.\n'));
    textSpanList.add(TextSpan(text : '나의 마음속에는 악이 가득합니다.\n'));
    textSpanList.add(TextSpan(text : '사탄이 마음속에 악을 넣었습니다.\n'));
    textSpanList.add(TextSpan(text : '나의 마음속에는 불평, 불만, 미움, 시기, 질투, 욕심, 원망, 정죄, 비판, 욕, 저주, 거짓, 불신앙, 불충, 불성실, 불순종, 인색함, 음란, 음행, 간음, 낙심, 슬픔, 우울함, 실망, 자살, 교만, 오만, 거역, 이기심, 나태, 게으름, 무사안일, 혈기, 신경질, 자랑, 더러운 마음, 배신 등의 악이 가득했습니다.\n'));
    textSpanList.add(TextSpan(text : '이러한 죄를 회개합니다.\n'));
    textSpanList.add(TextSpan(text : '그리고 이 악에서 구원받기를 원합니다.\n'));
    textSpanList.add(TextSpan(text : '그러므로 이 악에서 나를 구원하여 선한 마음으로 인도하여 주옵소서.\n'));
    textSpanList.add(TextSpan(text : '나는 연약하오니 하나님께서 악을 이길 수 있는 힘을 공급하여 주옵소서.\n'));
    textSpanList.add(TextSpan(text : '\n'));
    textSpanList.add(TextSpan(text : '9) 하나님의 나라와 권세와 영광이 영원히, 영원히 하나님 아버지께 있사오며,\n'));
    textSpanList.add(TextSpan(text : '\n'));
    textSpanList.add(TextSpan(text : '10) 예수님의 이름으로 기도드립니다.\n'));
    textSpanList.add(TextSpan(text : '\n'));
    textSpanList.add(TextSpan(text : '아멘.'));

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
}