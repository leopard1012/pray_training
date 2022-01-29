import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pray_training/pray_list.dart';
import 'package:sqflite/sqflite.dart';

import '../bottom_navi.dart';
import '../params.dart';

class PrayForPersonal2 extends StatefulWidget {
  final Future<Database> db;
  List<Map<String,dynamic>> list;

  PrayForPersonal2(this.db, this.list);

  @override
  State<StatefulWidget> createState() => _PrayForPersonal2();
}

class _PrayForPersonal2 extends State<PrayForPersonal2> {
  // late TextEditingController dataController;
  late List<Map<String,dynamic>> list;
  int index = -1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // dataController = TextEditingController();
    list = widget.list;
    index = getIndex(list, 'personal_2');
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Scaffold(
      appBar: AppBar(
        title: Text('13. 개인 기도 2'),
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
    Params params = await getParams('personal_2');

    String? target = params.param1 == null ? "다른 사람(이름)" : params.param1.toString();
    String? accident = params.param3 == null ? "죄(구체적으로)" : params.param3.toString();
    target = target == "" ? '다른 사람(이름)' : target;
    accident = accident == "" ? '죄(구체적으로)' : accident;

    List<TextSpan> textSpanList = [];
    textSpanList.add(TextSpan(text: '1) 하나님은 거룩하신 분이십니다.\n'));
    textSpanList.add(TextSpan(text: '하나님 아버지의 이름이 나를 통하여 거룩히 여김 받으시기를 원합니다.\n'));
    textSpanList.add(TextSpan(text: '그동안 나의 이름을 세상에 알리려고 행하였던 모든 죄를 회개합니다.\n'));
    textSpanList.add(TextSpan(text: '이제부터 나는 십자가에 죽고 하나님이 부르시는 그날까지 하나님의 이름을 거룩히 여기는 일을 찾아서 하기를 원합니다.\n'));
    textSpanList.add(TextSpan(text: '\n'));
    textSpanList.add(TextSpan(text: '2) 하나님의 나라가 내게 이루어지기를 원합니다.\n'));
    textSpanList.add(TextSpan(text: '그리하여 하나님의 나라가 제일 소중함을 알게 하옵소서.\n'));
    textSpanList.add(TextSpan(text: '세상 것이 없어도 그리스도의 제자들에게 주었던, \'의와 평강과 희락(하나님 믿는 기쁨)\'이 항상 있게 하옵소서.\n'));
    textSpanList.add(TextSpan(text: '그리하면 세상에서 자유를 누리고 천국과 같이 살 수 있습니다.\n'));
    textSpanList.add(TextSpan(text: '몸은 세상에 있으나 하나님 나라의 백성이므로 하나님의 법을 지키게 하옵시고, 이 복된 하나님의 나라를 세상 사람들에게 전파하게 하옵소서.\n'));
    textSpanList.add(TextSpan(text: '세상 어떤 것으로도 \'의와 평강과 희락\'을 빼앗기지 않게 하옵소서.\n'));
    textSpanList.add(TextSpan(text: '세상의 가난과 고난으로도 빼앗기지 않고 지키기를 원합니다.\n'));
    textSpanList.add(TextSpan(text: '이것은 세상의 어떤 보화보다 더 귀한 것인 줄 압니다.\n'));
    textSpanList.add(TextSpan(text: '세상 끝날까지 하나님의 나라가 항상 임재해 있기를 원합니다.\n'));
    textSpanList.add(TextSpan(text: '하나님의 나라가 없으면 세상 것을 소유했어도 나의 마음은 지옥과 같습니다.\n'));
    textSpanList.add(TextSpan(text: '이 하나님 나라를 주신 하나님께 감사를 드립니다.\n'));
    textSpanList.add(TextSpan(text: '영원한 하나님 나라를 창조하시고 믿음을 보시고 은혜로 주심을 감사드립니다.\n'));
    textSpanList.add(TextSpan(text: '\n'));
    textSpanList.add(TextSpan(text: '3) 하나님의 뜻이 하늘에서 이루어진 것 같이 나를 통하여 이루어지기를 원합니다.\n'));
    textSpanList.add(TextSpan(text: '나의 지혜, 재능, 은사, 물질, 능력, 직장, 사업, 가정 등 하나님이 나에게 주신 모든 것을 통하여 하나님의 뜻이 이 땅에 이루어지기를 원합니다.\n'));
    textSpanList.add(TextSpan(text: '그러므로 나의 마음속에 하나님의 뜻을 가득 채워 주옵소서.\n'));
    textSpanList.add(TextSpan(text: '그동안 나의 욕심을 따라 나의 뜻을 이루기 위해서 살았음을 회개합니다.\n'));
    textSpanList.add(TextSpan(text: '앞으로 남은 생애는 나에게 주신 모든 것으로 하나님의 뜻을 이루기 위해서 살겠습니다.\n'));
    textSpanList.add(TextSpan(text: '\n'));
    textSpanList.add(TextSpan(text: '4) 하나님께서 나에게 평생 동안 일용할 양식을 공급하여 주시기를 원합니다.\n'));
    textSpanList.add(TextSpan(text: '지금까지 하나님께서 일용할 양식을 공급해 주신 것에 감사드립니다.\n'));
    textSpanList.add(TextSpan(text: '앞으로도 계속해서 공급하여 주실 것을 믿습니다.\n'));
    textSpanList.add(TextSpan(text: '큰 믿음과 건강을 주옵시고 항상 하나님을 기쁘게 하는 사람이 되게 하옵소서.\n'));
    textSpanList.add(TextSpan(text: '또한 영적인 사람이 되게 하옵시며, 언제나 하나님을 신뢰하고 의지하고 기도하며 살아가게 하옵소서.\n'));
    textSpanList.add(TextSpan(text: '기도가 중요함을 아오니 기도를 쉬는 죄를 범하지 않게 하옵시며, 기도의 사람이라는 칭호를 받을 만큼 기도하게 하옵소서.\n'));
    textSpanList.add(TextSpan(text: '나에게 지혜와 총명을 주셔서 다윗처럼 하나님을 경외하게 하옵소서.\n'));
    textSpanList.add(TextSpan(text: '제일 먼저 하나님을 사랑하고 부모를 사랑하게 하옵소서.\n'));
    textSpanList.add(TextSpan(text: '언제나 머리가 되게 하옵시고 교회와 세상의 리더가 되어 하나님의 뜻대로 모든 것을 변화시키는 사람이 되게 하옵소서.\n'));
    textSpanList.add(TextSpan(text: '주고, 섬기고, 대접하고, 사랑할 줄 아는 사람이 되게 하옵시고 또한 풍성한 물질을 주셔서 하나님을 위하여 언제나 풍성하게 드리게 하옵시며, 모범적으로 충성하고 헌신하는 사람이 되게 하옵소서.\n'));
    textSpanList.add(TextSpan(text: '목사님께 순종하며 섬기는 믿음을 주옵시고, 가정에 충실하고 믿음의 사람이 되어 가정을 신앙으로 이끌게 하옵소서.\n'));
    textSpanList.add(TextSpan(text: '부모와 형제, 자매에게 신실한 사람이 되게 하옵시고, 세상에서 믿음으로 살고 존경과 신뢰를 얻는 사람이 되게 하옵소서.\n'));
    textSpanList.add(TextSpan(text: '온유와 오래 참음의 은사들을 공급하여 주옵시고, 풍성하여 이웃들에게 나누어 주며 살게 하옵소서.\n'));
    textSpanList.add(TextSpan(text: '또한 나의 주변 사람들을 전도하여 구원시키는 일에 열심 있게 하시며, 전도의 능력을 받아 많은 사람을 하나님께로 인도하는 전도의 사람이 되게 하옵소서.\n'));
    textSpanList.add(TextSpan(text: '그리고 목자가 되어 성도들을 양육하고 교회를 세워나가는 참된 일꾼이 되기를 원합니다.\n'));
    textSpanList.add(TextSpan(text: '나를 통하여 많은 목장들이 세워지고 제자들이 세워지게 하시며 많은 교회를 세우게 하옵소서.\n'));
    textSpanList.add(TextSpan(text: '죽는 날까지 복음을 전하는 사람이 되며 이 일을 위해서 목숨을 걸게 하옵소서.\n'));
    textSpanList.add(TextSpan(text: '다니엘과 같이 기도하며 하나님의 뜻을 이루어 드리는 하나님의 사람이 되기를 원합니다.\n'));
    textSpanList.add(TextSpan(text: '\n'));
    textSpanList.add(TextSpan(text: '5) 하나님! '));
    textSpanList.add(TextSpan(text: target, style: TextStyle(color: Colors.blue), recognizer: TapGestureRecognizer()..onTapDown = (p) => {Navigator.pushNamed(context, '/conf/personal_2')} ));
    textSpanList.add(TextSpan(text: '의 '));
    textSpanList.add(TextSpan(text: accident, style: TextStyle(color: Colors.blue), recognizer: TapGestureRecognizer()..onTapDown = (p) => {Navigator.pushNamed(context, '/conf/personal_2')} ));
    textSpanList.add(TextSpan(text: '를 용서합니다.\n'));
    textSpanList.add(TextSpan(text: '나에게 상처를 주고 힘들게 하였던 사람들을 용서합니다.\n'));
    textSpanList.add(TextSpan(text: '나를 멸시하고 모욕한 사람들을 용서합니다.\n'));
    textSpanList.add(TextSpan(text: '하나님 말씀에 순종하여 진심으로 용서합니다.\n'));
    textSpanList.add(TextSpan(text: '지금까지 다른 사람의 죄를 용서하지 못했습니다.\n'));
    textSpanList.add(TextSpan(text: '내가 의인인 줄로 착각하였습니다.\n'));
    textSpanList.add(TextSpan(text: '내가 하나님 앞에 더 큰 죄인이라는 것을 알게 되었습니다.\n'));
    textSpanList.add(TextSpan(text: '그러므로 모두를 용서합니다.\n'));
    textSpanList.add(TextSpan(text: '진심으로 용서합니다.\n'));
    textSpanList.add(TextSpan(text: '용서하는 마음 주심을 감사합니다.\n'));
    textSpanList.add(TextSpan(text: '그리고 그들을 축복합니다.\n'));
    textSpanList.add(TextSpan(text: '그들이 하나님을 경외하고 영혼이 잘되고 복 받기를 원합니다.\n'));
    textSpanList.add(TextSpan(text: '\n'));
    textSpanList.add(TextSpan(text: '6) 하나님! 다른 사람의 죄를 용서해 준 것 같이 나의 죄를 사하여 주옵소서.\n'));
    textSpanList.add(TextSpan(text: '나의 죄가 크오니 용서하여 주옵소서.\n'));
    textSpanList.add(TextSpan(text: '죄가 없는 줄 알고 살았던 것을 용서하여 주옵소서.\n'));
    textSpanList.add(TextSpan(text: '내가 하나님의 말씀을 거역한 것이 더 많았습니다.\n'));
    textSpanList.add(TextSpan(text: '나도 다른 사람을 무시했습니다.\n'));
    textSpanList.add(TextSpan(text: '또 다른 사람에게 상처를 주었습니다.\n'));
    textSpanList.add(TextSpan(text: '그러므로 회개합니다.\n'));
    textSpanList.add(TextSpan(text: '예수 그리스도의 십자가의 보혈로 사하여 주옵소서.\n'));
    textSpanList.add(TextSpan(text: '하나님만이 죄를 사하는 권세가 있는 줄 믿습니다.\n'));
    textSpanList.add(TextSpan(text: '그리하여 나의 마음에 평안과 기쁨과 소망을 주옵소서.\n'));
    textSpanList.add(TextSpan(text: '\n'));
    textSpanList.add(TextSpan(text: '7) 하나님! 내가 시험에 들지 않기를 원합니다.\n'));
    textSpanList.add(TextSpan(text: '마귀에게 시험당하지 않기를 원합니다.\n'));
    textSpanList.add(TextSpan(text: '그동안 하나님께서 지켜 주셔서 욥과 같은 시험은 없었나이다.\n'));
    textSpanList.add(TextSpan(text: '앞으로도 마귀에게 시험하라고 허락하지 마옵시고 하나님의 특별한 사랑과 은혜로 지켜 주옵소서.\n'));
    textSpanList.add(TextSpan(text: '지금까지 지켜 주심을 감사드립니다.\n'));
    textSpanList.add(TextSpan(text: '현재의 건강, 교회에 출석할 수 있는 믿음, 맡겨진 사역, 가족, 물질, 직장, 사업 모든 것을 하나님께서 마귀에게 시험하라고 허락지 않으시고 지켜 주셨음을 알았습니다.\n'));
    textSpanList.add(TextSpan(text: '그러므로 하나님께 감사, 또 감사를 드립니다.\n'));
    textSpanList.add(TextSpan(text: '앞으로도 계속 하나님을 성심으로 섬기겠사오니 지켜 주옵소서.\n'));
    textSpanList.add(TextSpan(text: '물질이나 명예로 시험당하지 않기를 원합니다.\n'));
    textSpanList.add(TextSpan(text: '하나님이 쳐다보지도 않는 물질이나 명예를 얻으려고 했던 것들을 용서하옵소서.\n'));
    textSpanList.add(TextSpan(text: '그리고 세상에서 시험에 들지 않기를 원합니다.\n'));
    textSpanList.add(TextSpan(text: '신앙생활에 시험이 들지 않기를 원합니다.\n'));
    textSpanList.add(TextSpan(text: '교회 생활에 시험 들지 않기를 원합니다.\n'));
    textSpanList.add(TextSpan(text: '가정에서 시험에 들지 않기를 원합니다.\n'));
    textSpanList.add(TextSpan(text: '내가 시험에 들지 않도록 지켜 주옵소서.\n'));
    textSpanList.add(TextSpan(text: '\n'));
    textSpanList.add(TextSpan(text: '8) 하나님! 나를 악에서 구원하여 주옵소서.\n'));
    textSpanList.add(TextSpan(text: '나의 마음속에는 악이 가득합니다.\n'));
    textSpanList.add(TextSpan(text: '사탄이 마음속에 악을 넣었습니다.\n'));
    textSpanList.add(TextSpan(text: '그래서 나의 마음속에는 불평, 불만, 미움, 시기, 질투, 욕심, 원망, 정죄, 비판, 욕, 저주, 거짓, 불신앙, 불충, 불성실, 불순종, 인색함, 음란, 음행, 간음, 낙심, 슬픔, 우울함, 실망, 자살, 교만, 오만, 거역, 이기심, 나태, 게으름, 무사안일, 혈기, 신경질, 자랑, 더러운 마음, 배신 등의 악이 가득합니다.\n'));
    textSpanList.add(TextSpan(text: '또 사탄이 마음속에 견고한 진을 만들어 버린 것도 있습니다.\n'));
    textSpanList.add(TextSpan(text: '이러한 악에서 나를 구원하여 선한 마음으로 인도하여 주옵소서.\n'));
    textSpanList.add(TextSpan(text: '그래서 언제나 하나님을 마음에 모시고 하나님의 나라를 이루고 선만을 생각하고 선을 행하는 하나님의 사람이 되게 하옵소서.\n'));
    textSpanList.add(TextSpan(text: '나를 악에서 구원하실 분은 하나님이십니다.\n'));
    textSpanList.add(TextSpan(text: '\n'));
    textSpanList.add(TextSpan(text: '9) 하나님의 나라와 권세와 영광이 영원히, 영원히 하나님 아버지께 있사오며,\n'));
    textSpanList.add(TextSpan(text: '\n'));
    textSpanList.add(TextSpan(text: '10) 예수님의 이름으로 기도드립니다.\n'));
    textSpanList.add(TextSpan(text: '\n'));
    textSpanList.add(TextSpan(text: '아멘'));

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