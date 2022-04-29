
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

import '../params.dart';

class PrayFull extends StatefulWidget {
  final Future<Database> db;

  PrayFull(this.db);

  @override
  State<StatefulWidget> createState() => _PrayFull();
}

class _PrayFull extends State<PrayFull> {
  ScrollController _scrollController = ScrollController();
  bool animatedActive = false;
  int step = 1;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '기도훈련집(전체)',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
          brightness: Brightness.dark,
          primarySwatch: Colors.blue
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('기도훈련집(전체)'),
          centerTitle: true,
          leading:  IconButton(
              onPressed: () {
                Navigator.pop(context); //뒤로가기
              },
              icon: Icon(Icons.home_filled)),
        ),
        floatingActionButton: FloatingActionButton(
            onPressed: () async {
              animatedActive = !animatedActive;
              double targetPos;
              if (animatedActive) {
                targetPos = _scrollController.position.maxScrollExtent;

              } else {
                targetPos = _scrollController.offset;
              }
              _scrollController.animateTo(
                  targetPos,
                  duration: Duration(seconds: ((targetPos - _scrollController.offset) / (20*step)).round()),
                  curve: Curves.linear
              );
            },
            child: const Icon(
              Icons.swap_vert_outlined,
            ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(8.0),
          controller: _scrollController,
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
          param3: maps[i]['param3'],
          param4: maps[i]['param4'],
          param5: maps[i]['param5'],
        );
      }
    });

    return p;
  }

  Future<List<TextSpan>> getPray() async {
    Params params2 = await getParams('church');
    Params params3 = await getParams('pastor');
    Params params4 = await getParams('cell');
    Params params5 = await getParams('believer');
    Params params6 = await getParams('person');
    Params params7 = await getParams('home');
    Params params8 = await getParams('husband');
    Params params9 = await getParams('wife');
    Params params10 = await getParams('parents');
    Params params11 = await getParams('children');
    Params params27 = await getParams('disease');

    String? withPray2 = params2.param1 ?? '(교회를 위한 중보기도)';
    String? target3 = params3.param1 ?? '그들(이름)';
    String? withPray4 = params4.param1 ?? '(목장을 위한 중보기도)';
    String? param5 = params5.param1 ?? '태신자';
    String? target6 = params6.param1 == null ? "OOO" : params6.param1.toString();
    String? withPray6 = params6.param2 == null ? "(OOO를 위한 중보기도)" : params6.param2.toString();
    String? accident6 = params6.param3 == null ? "()" : params6.param3.toString();
    String? param7 = params7.param1 ?? '그들(이름)';
    String? target8 = params8.param1 == null ? "OOO" : params8.param1.toString();
    String? withPray8 = params8.param2 == null ? "(남편을 위한 중보기도)" : params8.param2.toString();
    String? target9 = params9.param1 == null ? "OOO" : params9.param1.toString();
    String? withPray9 = params9.param2 == null ? "(아내를 위한 중보기도)" : params9.param2.toString();
    String? target10 = params10.param1 == null ? "(아버지/어머니)" : params10.param1.toString();
    String? withPray10 = params10.param2 == null ? "(부모를 위한 중보기도)" : params10.param2.toString();
    String? target11 = params11.param1 == null ? "OOO" : params11.param1.toString();
    String? withPray11 = params11.param2 == null ? "(자녀를 위한 중보기도)" : params11.param2.toString();
    String? target27 = params27.param1 == null ? "다른 사람(이름)" : params27.param1.toString();
    String? accident27 = params27.param2 == null ? "죄(구체적으로)" : params27.param2.toString();
    String? patient27 = params27.param3 == null ? "이 환자" : params27.param3.toString();
    String? sin27 = params27.param4 == null ? "(구체적으로 죄를 말하며 회개하십시오)" : params27.param4.toString();
    String? disease27 = params27.param5 == null ? "위암(병명)" : params27.param5.toString();

    withPray2 = withPray2 == "" ? '(교회를 위한 중보기도)' : withPray2;
    target3 = target3 == "" ? '그들(이름)' : target3;
    withPray4 = withPray4 == "" ? '(목장을 위한 중보기도)' : withPray4;
    param5 = param5 == "" ? '태신자' : param5;
    target6 = target6 == "" ? 'OOO' : target6;
    withPray6 = withPray6 == "" ? '(OOO를 위한 중보기도)' : withPray6;
    accident6 = accident6 == "" ? '()' : accident6;
    param7 = param7 == "" ? '그들(이름)' : param7;
    target8 = target8 == "" ? 'OOO' : target8;
    withPray8 = withPray8 == "" ? '(남편을 위한 중보기도)' : withPray8;
    target9 = target9 == "" ? 'OOO' : target9;
    withPray9 = withPray9 == "" ? '(아내를 위한 중보기도)' : withPray9;
    target10 = target10 == "" ? '(아버지/어머니)' : target10;
    withPray10 = withPray10 == "" ? '(부모를 위한 중보기도)' : withPray10;
    target11 = target11 == "" ? 'OOO' : target11;
    withPray11 = withPray11 == "" ? '(자녀를 위한 중보기도)' : withPray11;
    target27 = target27 == "" ? '다른 사람(이름)' : target27;
    accident27 = accident27 == "" ? '죄(구체적으로)' : accident27;
    patient27 = patient27 == "" ? '이 환자' : patient27;
    sin27 = sin27 == "" ? '(구체적으로 죄를 말하며 회개하십시오)' : sin27;
    disease27 = disease27 == "" ? '"위암(병명)' : disease27;

    List<TextSpan> textSpanList = [];
    textSpanList.add(TextSpan(text: '2. 교회를 위한 기도\n\n', style: TextStyle(color: Colors.black, fontSize: 30)));
    textSpanList.add(TextSpan(text: '1) 하나님 아버지는 거룩하십니다.\n'
        '하나님 아버지의 이름이 우리 교회를 통하여 거룩히 여김 받으시기를 원합니다.\n'
        '그리고 우리 교회가 하나님의 이름을 거룩하게 할 일만 하게 하옵소서.\n'
        '\n'
        '2) 하나님의 나라가 우리 교회에 이루어지기를 원합니다.\n'
        '그리하여 의와 평강과 희락이 넘치는 교회가 되어 교회 천국이 이루어지게 하옵소서.\n'
        '또한 우리 교회를 통치하셔서 하나님의 말씀대로 세워지게 하옵시고 하나님이 기뻐하는 교회가 되게 하옵소서.\n'
        '그리고 우리 교회를 통하여 하나님의 나라가 이웃과 지역사회와 세상 모든 사람들에게 전파되기를 원합니다.\n'
        '\n'
        '3) 하나님의 뜻이 하늘에서 이루어진 것 같이 땅에서 우리 교회를 통하여 이루어지기를 원합니다.\n'
        '또 우리 교회가 하나님의 뜻을 알고 이루어 드리기를 기도합니다.\n'
        '하나님의 뜻이 우리 교회를 통하여 모든 민족에게 증거되기를 원합니다.\n'
        '\n'
        '4) 하나님께서 우리 교회에 필요한 것을 공급해 주시기를 원합니다.\n'
        '우리 교회 담임목사님의 건강을 지켜 주옵소서.\n'
        '하나님의 뜻을 이루어 드리는 능력의 사자로 사용하여 주옵소서.\n'
        '또 우리 교회의 목표가 이루어지게 하옵소서.\n'));
    textSpanList.add(TextSpan(text: withPray2, style: TextStyle(color: Colors.blue) ));
    textSpanList.add(TextSpan(text: '\n우리 교회가 지역의 영혼들을 많이 구원하는 교회가 되기를 원합니다.\n'
        '그리고 영적 추수할 리더를 만들고 번식하는 교회가 되게 하옵소서.\n'
        '우리 교회 부교역자들과 중진들이 담임목사님을 도와서 하나님의 뜻을 이루게 하옵소서.\n'
        '또한 그들이 성령 충만하고 말씀에 충만하여 능력으로 하나님의 큰 뜻을 이루게 하옵소서.\n'
        '우리 교인들이 하나님을 잘 섬기고 복 받는 사람들이 되기를 원합니다.\n'
        '\n'
        '5) 하나님! 다른 사람의 죄를 용서해 주시기 원합니다.\n'
        '우리 교회에 상처를 주고 힘들게 했던 사람들을 용서합니다.\n'
        '예수님의 이름으로 용서합니다.\n'
        '그리고 그들의 영혼을 축복해 주옵소서.\n'
        '그들이 하나님을 경외하고 복 받기를 원합니다.\n'
        '\n'
        '6) 하나님! 다른 사람의 죄를 용서해 준 것 같이 우리 교회의 죄를 사하여 주옵소서.\n'
        '하나님만이 죄를 사하는 권세가 있는 줄 믿습니다.\n'
        '\n'
        '7) 하나님! 우리 교회가 시험에 들지 않기를 원합니다.\n'
        '마귀에게 시험당하지 않기를 원합니다.\n'
        '세상으로부터 시험당하지 않기를 원합니다.\n'
        '신앙 생활에 시험 들지 않기를 원합니다.\n'
        '교회생활에 시험 들지 않기를 원합니다.\n'
        '물질로 시험 당하지 않기를 원합니다.\n'
        '사람들로 인하여 시험 들지 않기를 원합니다.\n'
        '여러 가지 시험에 들지 않도록 하옵소서.\n'
        '그리고 시험을 주는 마귀를 우리 교회에서 내쫓아 주옵시고, 다시는 들어오지 않게 하옵소서.\n'
        '천군 천사로 우리 교회를 지켜 주옵소서.\n'
        '\n'
        '8) 하나님! 우리 교회를 악에서 구원하여 주옵소서.\n'
        '우리 교회가 하나님의 법을 어기는 악을 행하지 않게 하옵소서.\n'
        '우리 교회가 하나님의 말씀대로 행하여 선과 의를 행하게 하옵소서.\n'
        '우리 교회는 연약하오니 하나님께서 악을 이길 수 있는 힘과 능력을 공급하여 주옵소서.\n'
        '언제나 악에서 지켜주시고 악이 들어올 때 구원하여 주옵소서.\n'
        '\n'
        '9) 하나님의 나라와 권세와 영광이 영원히, 영원히 하나님 아버지께 있사오며,\n'
        '\n'
        '10) 예수님의 이름으로 기도드립니다. 아멘.\n\n\n'));

    textSpanList.add(TextSpan(text: '3. 담임목사님을 위한 기도\n\n', style: TextStyle(color: Colors.black, fontSize: 30)));
    textSpanList.add(TextSpan(text: '1) 하나님 아버지는 거룩하신 분이십니다.\n'
        '하나님 아버지의 이름이 담임목사님과 가정을 통하여 거룩히 여김 받으시기를 원합니다.\n'
        '그러므로 우리 담임목사님과 가정이 하나님의 이름을 거룩하게 할 일만 행하게 하옵소서.\n'
        '\n'
        '2) 하나님의 나라가 담임목사님과 가정에 이루어지기를 원합니다.\n'
        '그리하여 의와 평강과 희락이 있는 가정이 되어 행복하게 하옵소서.\n'
        '우리 담임목사님과 가정이 하나님의 통치를 받으며 하나님 나라의 법을 지키며 기쁘게 살게 하옵시고, 하나님 나라의 영광을 위하여 일하게 하옵소서.\n'
        '그리고 우리 담임목사님과 가정을 통하여 하나님의 나라가 세상 모든 사람들에게 전파되기를 원합니다.\n'
        '\n'
        '3) 하나님의 뜻이 하늘에서 이루어진 것 같이 땅에서 우리 담임목사님과 가정에 이루어지기를 원합니다.\n'
        '또한 우리 담임목사님과 가족을 통하여 하나님의 선하신 뜻이 이루어지기를 기도합니다.\n'
        '하나님의 뜻이 우리 담임목사님과 가정을 통하여 온 땅에 전파되기를 원합니다.\n'
        '\n'
        '4) 하나님께서 우리 담임목사님의 가정에 평생 동안 일용할 양식을 공급해 주시기를 원합니다.\n'
        '또 세상에서 살아가는데 필요한 것을 풍족하게 공급해 주시기를 원합니다.\n'
        '우리 담임목사님의 가정에 현재 필요한 것들이 많이 있습니다.\n'
        '하나님께서 공급하여 주옵소서.\n'
        '또 풍성하여 이웃들에게 나누어 주며 살게 하옵소서.\n'
        '또한 우리 담임목사님과 가정의 주변 사람들이 모두 구원받기를 원합니다.\n'
        '그들을 구원하시어 하나님의 일꾼으로 사용해 주옵소서.\n'
        '그리고 담임목사님에게 크신 능력을 주어 큰 일꾼으로 사용하여 주옵소서.\n'
        '이 시대에 하나님의 뜻을 이루어 드리는 종으로 사용하여 주옵소서.\n'
        '\n'
        '5) 하나님! 다른 사람들의 죄를 용서해 주시기를 원합니다.\n'
        '우리 담임목사님과 가정에 상처를 주고 힘들게 했던 사람들을 용서해 주시기 원합니다.\n'
        '예수님의 이름으로 용서해 주옵소서.\n'
        '그리고 '));
    textSpanList.add(TextSpan(text: target3, style: TextStyle(color: Colors.blue) ));
    textSpanList.add(TextSpan(text: '을(를) 축복해 주옵소서.'
        '그들이 하나님을 경외하고 복 받기를 원합니다.\n'
        '\n'
        '6) 하나님! 다른 사람들의 죄를 용서해 준 것 같이 우리 담임목사님과 가정의 죄도 십자가의 보혈로 사하여 주옵소서.\n'
        '하나님만이 죄를 사하는 권세가 있는 줄 믿습니다.\n'
        '\n'
        '7) 하나님! 우리 담임목사님과 가정이 시험에 들지 않기를 원합니다.\n'
        '마귀에게 시험당하지 않기를 원합니다.\n'
        '그러므로 마귀에게 시험 당함을 허락지 마옵소서.\n'
        '또 세상에 시험당하지 않기를 원합니다.\n'
        '가난이나 물질, 질병, 불행한 사고, 세상 명예, 돈, 권력으로부터 시험당하지 않기를 원합니다.\n'
        '교회생활에 시험 들지 않기를 원합니다.\n'
        '\n'
        '부교역자나 중진, 집사, 성도들로부터 시험 들지 않기를 원합니다.\n'
        '또 가정 식구들로부터 시험 들지 않게 하옵소서.\n'
        '\n'
        '8) 하나님! 우리 담임목사님과 가정을 악에서 구원하여 주옵소서.\n'
        '우리에게는 하나님의 법을 지키지 않는 악한 마음이 있습니다.\n'
        '이 악에서 우리 담임목사님과 가정을 구원해 주옵소서.\n'
        '그리하여 하나님의 법을 지키는 선한 가정이 되게 하옵소서.\n'
        '우리 담임목사님과 가정이 세상의 악에 물들지 않도록 지켜 주옵소서.\n'
        '악은 모양이라도 보지 않게 하옵소서.\n'
        '우리 담임목사님과 가정은 연약하오니 하나님께서 악을 이길 수 있는 힘과 능력을 공급하여 주옵소서.\n'
        '\n'
        '9) 하나님의 나라와 권세와 영광히 영원히, 영원히 하나님 아버지께 있사오며,\n'
        '\n'
        '10) 예수님의 이름으로 기도드립니다. 아멘.\n\n\n'));

    textSpanList.add(TextSpan(text: '4. 목장과 목장원을 위한 기도\n\n', style: TextStyle(color: Colors.black, fontSize: 30)));
    textSpanList.add(TextSpan(text: '1) 하나님은 거룩하신 분이십니다.\n'
        '하나님 아버지의 이름이 우리 목장과 목장원을 통하여 거룩히 여김 받으시기를 원합니다.\n'
        '그리고 우리 목장원들이 하나님의 이름을 거룩히 여길 일만 행하게 하옵소서.\n'
        '하나님의 이름을 망령되이 일컫는 일을 행하지 않게 하옵소서.\n'
        '\n'
        '2) 하나님의 나라가 우리 목장과 목장원에 이루어지기를 원합니다.\n'
        '우리 목장원들의 마음에 의와 평강과 기쁨이 이루어져 마음의 천국이 이루어지게 하옵소서.\n'
        '그리고 하나님께서 통치하셔서 하나님의 말씀을 깨닫게 하시고 말씀에 복종하는 삶을 살게 하옵소서.\n'
        '또 목장원들 가정에 하나님의 나라가 이루어지게 하옵소서.\n'
        '그리고 우리 목장과 목장원을 통하여 하나님의 나라가 이웃과 세상 모든 사람들에게 전파되기를 원합니다.\n'
        '\n'
        '3) 하나님의 뜻이 하늘에서 이루어진 것 같이 땅에서 우리 목장과 목장원을 통하여 이루어지기를 원합니다.\n'
        '우리 목장과 목장원이 하나님의 뜻인 사람을 구원하는 일을 최우선으로 하게 하옵소서.\n'
        '가정 식구들을 전도하고 이웃을 전도하여 하나님의 뜻을 이루어 드리기를 소원합니다.\n'
        '이 일에 마음이 뜨거워져서 열정적으로 전도하게 하옵소서.\n'
        '또한 예수님의 전도법과 관계법을 실천하여 자신이 변화되게 하옵소서.\n'
        '\n'
        '4) 하나님께서 우리 목장과 목장원에게 필요한 것을 공급해 주시기를 원합니다.\n'
        '우리 목장의 목자에게 은혜와 능력을 주옵시고, 목장원들에게 성령 충만과 말씀 충만을 주옵소서.\n'
        '우리 목장이 전도하여 크게 부흥하게 하옵소서.\n'
        '전 목장원이 매일 전도하게 하옵소서.\n'
        '그리고 목장원들이 서로 뜨겁게 기도하고 도와주며 사랑하게 하옵소서.\n'
        '또한 건강하게 하옵시고 생활도 안정되게 하옵소서.\n'
        '\n'));
    textSpanList.add(TextSpan(text: withPray4, style: TextStyle(color: Colors.blue) ));
    textSpanList.add(TextSpan(text: '\n우리 목장이 지역의 영혼들을 많이 구원하는 목장이 되기를 원합니다.\n'
        '그리고 영적 추수할 리더를 만들고 번식하는 목장이 되게 하옵소서.\n'
        '\n'
        '5) 하나님! 다른 사람의 죄를 용서해 주시기 원합니다.\n'
        '우리 목자와 목장원들에게 상처를 주고 힘들게 하였던 '+'사람을'+' 용서합니다.\n'
        '예수님의 이름으로 용서합니다.\n'
        '그리고 그를 축복해 주옵소서.\n'
        '그가 하나님을 경외하고 복 받기를 원합니다.\n'
        '\n'
        '6) 하나님! 다른 사람의 죄를 용서하여 준 것 같이 목자의 죄와 목장원의 죄를 사하여 주옵소서.\n'
        '하나님만이 죄를 사하는 권세가 있는 줄 믿습니다.\n'
        '\n'
        '7) 하나님! 우리 목장과 목장원이 시험에 들지 않기를 원합니다.\n'
        '마귀에게 시험당하지 않기를 원합니다.\n'
        '세상으로부터 시험당하지 않기를 원합니다.\n'
        '신앙생활에 시험 들지 않기를 원합니다.\n'
        '목장생활에 시험 들지 않기를 원합니다.\n'
        '물질로 시험당하지 않기를 원합니다.\n'
        '사람들로 인하여 시험이 없기를 원합니다.\n'
        '가정 식구들도 시험이 없기를 원합니다.\n'
        '시험을 주는 마귀를 우리 목장에서 내쫓아 주옵시고 다시는 들어오지 않게 하옵소서.\n'
        '천군 천사로 우리 목장을 지켜 주옵소서.\n'
        '\n'
        '8) 하나님! 우리 목장과 목장원을 악에서 구원하여 주옵소서.\n'
        '우리 목장과 목장원이 하나님의 법을 어기는 악을 버리게 하옵소서.\n'
        '이 악은 우리를 멸망 받게 하나이다.\n'
        '그러므로 악에서 구원받아 선한 마음으로 살며 하나님의 법을 순종하고 복종하게 하옵소서.\n'
        '우리 목장과 목장원에게 악은 모양이라도 버릴 수 있는 믿음을 주옵소서.\n'
        '우리 목장원은 연약하오니 하나님께서 악을 이길 수 있는 힘을 공급하여 주옵시고 악에서 구원하옵소서.\n'
        '\n'
        '9) 하나님의 나라와 권세와 영광이 영원히, 영원히 하나님 아버지께 있사오며,\n'
        '\n'
        '10) 예수님의 이름으로 기도드립니다. 아멘.\n\n\n'));

    textSpanList.add(TextSpan(text: '5. 태신자를 위한 기도\n\n', style: TextStyle(color: Colors.black, fontSize: 30)));
    textSpanList.add(TextSpan(text: '1) 하나님 아버지는 거룩하십니다.\n'));
    textSpanList.add(TextSpan(text: '하나님 아버지의 이름이 '));
    textSpanList.add(TextSpan(text: param5, style: TextStyle(color: Colors.blue) ));
    textSpanList.add(TextSpan(text: '을(를) 통하여 거룩히 여김 받으시기를 원합니다.\n'));
    textSpanList.add(TextSpan(text: '그리고 '));
    textSpanList.add(TextSpan(text: param5, style: TextStyle(color: Colors.blue) ));
    textSpanList.add(TextSpan(text: '이(가) 하나님의 이름을 거룩히 여기는 일들을 하기 원합니다.\n'));
    textSpanList.add(TextSpan(text: '\n'));
    textSpanList.add(TextSpan(text: '2) 하나님의 나라가 '));
    textSpanList.add(TextSpan(text: param5, style: TextStyle(color: Colors.blue) ));
    textSpanList.add(TextSpan(text: '에게 이루어지기를 원합니다.\n'));
    textSpanList.add(TextSpan(text: '그리하여'));
    textSpanList.add(TextSpan(text: param5, style: TextStyle(color: Colors.blue) ));
    textSpanList.add(TextSpan(text: '의 심령에 의와 평강과 희락이 항상 있어 마음의 천국이 이루어지게 하옵소서.\n'));
    textSpanList.add(TextSpan(text: param5, style: TextStyle(color: Colors.blue) ));
    textSpanList.add(TextSpan(text: '이(가) 하나님의 통치를 받으며 하나님의 백성답게 하나님 나라의 법을 깨닫고 지키며 살게 하옵시고, 하나님 나라의 영광을 위하여 일하게 하옵소서.\n'));
    textSpanList.add(TextSpan(text: '그리고 '));
    textSpanList.add(TextSpan(text: param5, style: TextStyle(color: Colors.blue) ));
    textSpanList.add(TextSpan(text: '을(를) 통하여 하나님 나라가 세상 모든 사람들에게 전파되기를 원합니다.\n'));
    textSpanList.add(TextSpan(text: '\n'));
    textSpanList.add(TextSpan(text: '3) 하나님의 뜻이 하늘에서 이루어진 것 같이 땅에서 '));
    textSpanList.add(TextSpan(text: param5, style: TextStyle(color: Colors.blue) ));
    textSpanList.add(TextSpan(text: '에게 이루어지기를 원합니다.\n'));
    textSpanList.add(TextSpan(text: '또한 '));
    textSpanList.add(TextSpan(text: param5, style: TextStyle(color: Colors.blue) ));
    textSpanList.add(TextSpan(text: '이(가) 하나님의 뜻을 깨닫고 이루어 드리기를 기도합니다.\n'));
    textSpanList.add(TextSpan(text: param5, style: TextStyle(color: Colors.blue) ));
    textSpanList.add(TextSpan(text: '이(가) 하나님의 뜻대로 구원받은 백성이 되고 다른 사람을 구원할 수 있게 하옵소서.\n'));
    textSpanList.add(TextSpan(text: '그리고 하나님의 뜻이 '));
    textSpanList.add(TextSpan(text: param5, style: TextStyle(color: Colors.blue) ));
    textSpanList.add(TextSpan(text: '을(를) 통하여 온 땅에 전파되기를 원합니다.\n'));
    textSpanList.add(TextSpan(text: '\n'));
    textSpanList.add(TextSpan(text: '4) 하나님께서 '));
    textSpanList.add(TextSpan(text: param5, style: TextStyle(color: Colors.blue) ));
    textSpanList.add(TextSpan(text: '에게 평생 동안 일용할 양식을 공급해 주시기를 원합니다.\n'));
    textSpanList.add(TextSpan(text: '또 세상에서 살아가는데 필요한 것을 공급해주시기를 원합니다.\n'));
    textSpanList.add(TextSpan(text: param5, style: TextStyle(color: Colors.blue) ));
    textSpanList.add(TextSpan(text: '에게 지금 필요한 것들이 많이 있습니다.\n'));
    textSpanList.add(TextSpan(text: '하나님께서 공급하여 주옵소서\n'));
    textSpanList.add(TextSpan(text: '또 풍성하여 이웃들에게 나누어 주며 살게 하옵소서.\n'));
    textSpanList.add(TextSpan(text: '또한 '));
    textSpanList.add(TextSpan(text: param5, style: TextStyle(color: Colors.blue) ));
    textSpanList.add(TextSpan(text: ' 주변의 사람들이 모두 구원받기를 원합니다.\n'));
    textSpanList.add(TextSpan(text: '그들을 구원하시어 하나님의 일꾼으로 사용하여 주옵소서.\n'));
    textSpanList.add(TextSpan(text: '그리고 교회의 일꾼이 되며 리더가 되어 전도하고 목장을 부흥시키게 하옵소서.\n'));
    textSpanList.add(TextSpan(text: '\n'));
    textSpanList.add(TextSpan(text: '5) 하나님! '));
    textSpanList.add(TextSpan(text: param5, style: TextStyle(color: Colors.blue) ));
    textSpanList.add(TextSpan(text: '이(가) 다른 사람의 죄를 용서하기를 원합니다.\n'));
    textSpanList.add(TextSpan(text: param5, style: TextStyle(color: Colors.blue) ));
    textSpanList.add(TextSpan(text: '에게 상처를 주고 힘들게 했던 사람들을 용서해 주시기 원합니다.\n'));
    textSpanList.add(TextSpan(text: '예수님의 이름으로 용서하는 마음을 주옵소서.\n'));
    textSpanList.add(TextSpan(text: '그리고 그들의 영혼을 축복하게 하옵소서.\n'));
    textSpanList.add(TextSpan(text: param5, style: TextStyle(color: Colors.blue) ));
    textSpanList.add(TextSpan(text: '이(가) 하나님을 경외하고 복받기를 원합니다.\n'));
    textSpanList.add(TextSpan(text: '\n'));
    textSpanList.add(TextSpan(text: '6) 하나님! 다른 사람의 죄를 용서해 준 것 같이 '));
    textSpanList.add(TextSpan(text: param5, style: TextStyle(color: Colors.blue) ));
    textSpanList.add(TextSpan(text: '의 죄도 용서하여 주옵소서.\n'));
    textSpanList.add(TextSpan(text: param5, style: TextStyle(color: Colors.blue) ));
    textSpanList.add(TextSpan(text: '도 하나님 앞에서 죄인입니다.\n'));
    textSpanList.add(TextSpan(text: '하나님이 용서하셔야 구원을 받사오니 용서하여 주옵소서.\n'));
    textSpanList.add(TextSpan(text: '하나님만이 죄를 사하는 권세가 있는 줄 믿습니다.\n'));
    textSpanList.add(TextSpan(text: '\n'));
    textSpanList.add(TextSpan(text: '7) 하나님!'));
    textSpanList.add(TextSpan(text: param5, style: TextStyle(color: Colors.blue) ));
    textSpanList.add(TextSpan(text: '이(가) 시험에 들지 않기를 원합니다.\n'));
    textSpanList.add(TextSpan(text: '마귀에게 시험당하지 않기를 원합니다.\n'));
    textSpanList.add(TextSpan(text: '세상에 시험당하지 않기를 원합니다.\n'));
    textSpanList.add(TextSpan(text: '물질이나 명예로 시험당하지 않기를 원합니다.\n'));
    textSpanList.add(TextSpan(text: '가정에서 시험 들지 않기를 원합니다.\n'));
    textSpanList.add(TextSpan(text: param5, style: TextStyle(color: Colors.blue) ));
    textSpanList.add(TextSpan(text: '이(가) 시험 들지 않도록 지켜 주옵소서.\n'));
    textSpanList.add(TextSpan(text: '\n'));
    textSpanList.add(TextSpan(text: '8) 하나님! '));
    textSpanList.add(TextSpan(text: param5, style: TextStyle(color: Colors.blue) ));
    textSpanList.add(TextSpan(text: '을(를) 악에서 구원해 주옵소서.\n'));
    textSpanList.add(TextSpan(text: param5, style: TextStyle(color: Colors.blue) ));
    textSpanList.add(TextSpan(text: '의 마음속에 있는 여러가지 악에서 구원하여 선한 마음으로 인도하여 주옵소서.\n'));
    textSpanList.add(TextSpan(text: param5, style: TextStyle(color: Colors.blue) ));
    textSpanList.add(TextSpan(text: '을(를) 악에서 빠져나오게 하사 선을 행하게 하옵소서.\n'));
    textSpanList.add(TextSpan(text: param5, style: TextStyle(color: Colors.blue) ));
    textSpanList.add(TextSpan(text: '에게 악이 무엇인지를 알게 하옵소서.\n'));
    textSpanList.add(TextSpan(text: '그리고 악에 물들지 않도록 지켜 주옵소서.\n'));
    textSpanList.add(TextSpan(text: param5, style: TextStyle(color: Colors.blue) ));
    textSpanList.add(TextSpan(text: '은(는) 연약하오니 하나님께서 악을 이길 수 있는 힘을 공급하여 주옵소서.\n'));
    textSpanList.add(TextSpan(text: '\n'));
    textSpanList.add(TextSpan(text: '9) 하나님의 나라와 권세와 영광이 영원히, 영원히 하나님 아버지께 있사오며,\n'));
    textSpanList.add(TextSpan(text: '\n'));
    textSpanList.add(TextSpan(text: '10) 예수님의 이름으로 기도드립니다. 아멘.\n\n\n'));

    textSpanList.add(TextSpan(text: '6. 사람을 위한 기도\n\n', style: TextStyle(color: Colors.black, fontSize: 30)));
    textSpanList.add(TextSpan(text: '1) 하나님 아버지는 거룩하십니다.\n하나님 아버지의 이름이 '));
    textSpanList.add(TextSpan(text: target6, style: TextStyle(color: Colors.blue) )); //, recognizer: TapGestureRecognizer()..onTapDown = (p) => {Navigator.pushNamed(context, '/conf/person')} ));
    textSpanList.add(TextSpan(text: '을(를) 통하여 거룩히 여김 받으시기를 원합니다.\n'));
    textSpanList.add(TextSpan(text: '그리고 '));
    textSpanList.add(TextSpan(text: target6, style: TextStyle(color: Colors.blue) )); //, recognizer: TapGestureRecognizer()..onTapDown = (p) => {Navigator.pushNamed(context, '/conf/person')} ));
    textSpanList.add(TextSpan(text: '이(가) 하나님의 이름을 거룩히 여기는 일을 찾아서 하기를 원합니다.\n'));
    textSpanList.add(TextSpan(text: '\n'));
    textSpanList.add(TextSpan(text: '2) 하나님의 나라가 '));
    textSpanList.add(TextSpan(text: target6, style: TextStyle(color: Colors.blue) )); //, recognizer: TapGestureRecognizer()..onTapDown = (p) => {Navigator.pushNamed(context, '/conf/person')} ));
    textSpanList.add(TextSpan(text: '에게 이루어지기를 원합니다.\n'));
    textSpanList.add(TextSpan(text: '그리하여'));
    textSpanList.add(TextSpan(text: target6, style: TextStyle(color: Colors.blue) )); //, recognizer: TapGestureRecognizer()..onTapDown = (p) => {Navigator.pushNamed(context, '/conf/person')} ));
    textSpanList.add(TextSpan(text: '의 심령에 의와 평강과 희락이 항상 있어 마음의 천국이 이루어지게 하옵소서.\n'));
    textSpanList.add(TextSpan(text: '그리고 '));
    textSpanList.add(TextSpan(text: target6, style: TextStyle(color: Colors.blue) )); //, recognizer: TapGestureRecognizer()..onTapDown = (p) => {Navigator.pushNamed(context, '/conf/person')} ));
    textSpanList.add(TextSpan(text: '이(가) 하나님의 통치를 받으며 하나님 나라의 법을 소중히 여기고 지키며 살게 하옵시고, 하나님 나라의 영광을 위하여 일하게 하옵소서.\n'));
    textSpanList.add(TextSpan(text: '그리고 '));
    textSpanList.add(TextSpan(text: target6, style: TextStyle(color: Colors.blue) )); //, recognizer: TapGestureRecognizer()..onTapDown = (p) => {Navigator.pushNamed(context, '/conf/person')} ));
    textSpanList.add(TextSpan(text: '을(를) 통하여 하나님 나라가 세상 모든 사람들에게 전파되기를 원합니다.\n'));
    textSpanList.add(TextSpan(text: '\n'));
    textSpanList.add(TextSpan(text: '3) 하나님의 뜻이 하늘에서 이루어진 것 같이 땅에서 '));
    textSpanList.add(TextSpan(text: target6, style: TextStyle(color: Colors.blue) )); //, recognizer: TapGestureRecognizer()..onTapDown = (p) => {Navigator.pushNamed(context, '/conf/person')} ));
    textSpanList.add(TextSpan(text: '에게 이루어지기를 원합니다.\n'));
    textSpanList.add(TextSpan(text: '또 '));
    textSpanList.add(TextSpan(text: target6, style: TextStyle(color: Colors.blue) )); //, recognizer: TapGestureRecognizer()..onTapDown = (p) => {Navigator.pushNamed(context, '/conf/person')} ));
    textSpanList.add(TextSpan(text: '이(가) 하나님의 뜻인 전도와 선과 의를 행하며 이웃에게 피해를 주지 않고 도움이 되는 삶을 살기를 기도합니다.\n'));
    textSpanList.add(TextSpan(text: '하나님의 뜻이 '));
    textSpanList.add(TextSpan(text: target6, style: TextStyle(color: Colors.blue) )); //, recognizer: TapGestureRecognizer()..onTapDown = (p) => {Navigator.pushNamed(context, '/conf/person')} ));
    textSpanList.add(TextSpan(text: '을(를) 통하여 온 땅에 전파되기를 원합니다.\n'));
    textSpanList.add(TextSpan(text: '\n'));
    textSpanList.add(TextSpan(text: '4) 하나님께서 '));
    textSpanList.add(TextSpan(text: target6, style: TextStyle(color: Colors.blue) )); //, recognizer: TapGestureRecognizer()..onTapDown = (p) => {Navigator.pushNamed(context, '/conf/person')} ));
    textSpanList.add(TextSpan(text: '에게 평생 동안 일용할 양식을 공급해 주시기를 원합니다.\n'));
    textSpanList.add(TextSpan(text: '또 세상에서 살아가는데 필요한 것을 공급하여 주시기를 원합니다.\n'));
    textSpanList.add(TextSpan(text: target6, style: TextStyle(color: Colors.blue) )); //, recognizer: TapGestureRecognizer()..onTapDown = (p) => {Navigator.pushNamed(context, '/conf/person')} ));
    textSpanList.add(TextSpan(text: '이(가) 하는 일들을 축복하여 주옵소서.\n'));
    textSpanList.add(TextSpan(text: '그리고 큰 믿음과 건강을 주옵시며, 항상 하나님을 기쁘게 하는 사람 되게 하옵소서.\n'));
    textSpanList.add(TextSpan(text: '\n'));
    textSpanList.add(TextSpan(text: withPray6, style: TextStyle(color: Colors.blue) )); //, recognizer: TapGestureRecognizer()..onTapDown = (p) => {Navigator.pushNamed(context, '/conf/person')} ));
    textSpanList.add(TextSpan(text: '\n'));
    textSpanList.add(TextSpan(text: target6, style: TextStyle(color: Colors.blue) )); //, recognizer: TapGestureRecognizer()..onTapDown = (p) => {Navigator.pushNamed(context, '/conf/person')} ));
    textSpanList.add(TextSpan(text: '에게 풍성한 물질을 주셔서 하나님을 위하여 언제나 즐거운 마음으로 풍성하게 드리게 하옵시며, 모범적으로 충성하고 헌신하는 사람이 되게 하옵소서.\n'));
    textSpanList.add(TextSpan(text: '목사님에게 순종하며 섬기는 믿음을 주옵시고, 성도를 사랑하며 겸손히 섬기는 신앙을 주옵소서.\n'));
    textSpanList.add(TextSpan(text: '가정에 충실하고 믿음의 사람이 되어 가정을 신앙으로 이끌게 하옵소서.\n'));
    textSpanList.add(TextSpan(text: '예수님의 가르침대로 온유하고 겸손한 사람이 되어 사람들에게 좋은 본이 되게 하옵소서.\n'));
    textSpanList.add(TextSpan(text: '그리고 세상에서 믿음으로 살며 존경과 신뢰를 얻는 사람이 되게 하옵소서.\n'));
    textSpanList.add(TextSpan(text: '지혜와 명철함을 주옵시고, 사랑과 오래 참음의 은사들을 공급하여 주옵소서.\n'));
    textSpanList.add(TextSpan(text: '또 풍성하여 이웃들에게 나누어 주며 살게 하옵소서.\n'));
    textSpanList.add(TextSpan(text: '또한 '));
    textSpanList.add(TextSpan(text: target6, style: TextStyle(color: Colors.blue) )); //, recognizer: TapGestureRecognizer()..onTapDown = (p) => {Navigator.pushNamed(context, '/conf/person')} ));
    textSpanList.add(TextSpan(text: '의 주변 사람들이 모두 구원받기를 원합니다.\n'));
    textSpanList.add(TextSpan(text: '그들을 구원하시어 하나님의 일꾼으로 사용하여 주옵소서.\n'));
    textSpanList.add(TextSpan(text: '\n'));
    textSpanList.add(TextSpan(text: '5) 하나님! 다른 사람의 죄를 용서합니다.\n'));
    textSpanList.add(TextSpan(text: '나에게 상처를 주고 힘들게 하였던 '));
    textSpanList.add(TextSpan(text: target6, style: TextStyle(color: Colors.blue) )); //, recognizer: TapGestureRecognizer()..onTapDown = (p) => {Navigator.pushNamed(context, '/conf/person')} ));
    textSpanList.add(TextSpan(text: '을(를) 용서합니다.\n'));
    textSpanList.add(TextSpan(text: target6, style: TextStyle(color: Colors.blue) )); //, recognizer: TapGestureRecognizer()..onTapDown = (p) => {Navigator.pushNamed(context, '/conf/person')} ));
    textSpanList.add(TextSpan(text: '이(가) '));
    textSpanList.add(TextSpan(text: accident6, style: TextStyle(color: Colors.blue) )); //, recognizer: TapGestureRecognizer()..onTapDown = (p) => {Navigator.pushNamed(context, '/conf/person')} ));
    textSpanList.add(TextSpan(text: ' 일로 나에게 상처를 주었습니다.\n'));
    textSpanList.add(TextSpan(text: '하지만 예수님의 말씀에 순종하여 용서합니다.\n'));
    textSpanList.add(TextSpan(text: '그리고 '));
    textSpanList.add(TextSpan(text: target6, style: TextStyle(color: Colors.blue) )); //, recognizer: TapGestureRecognizer()..onTapDown = (p) => {Navigator.pushNamed(context, '/conf/person')} ));
    textSpanList.add(TextSpan(text: '을(를) 축복합니다.\n'));
    textSpanList.add(TextSpan(text: target6, style: TextStyle(color: Colors.blue) )); //, recognizer: TapGestureRecognizer()..onTapDown = (p) => {Navigator.pushNamed(context, '/conf/person')} ));
    textSpanList.add(TextSpan(text: '이(가) 하나님을 경외하고 복 받기를 원합니다.\n'));
    textSpanList.add(TextSpan(text: '\n'));
    textSpanList.add(TextSpan(text: '6) 하나님! 다른 사람의 죄를 용서하여 준 것 같이 나의 죄를 사하여 주옵소서.\n'));
    textSpanList.add(TextSpan(text: '하나님만이 죄를 사하는 권세가 있는줄 믿습니다.\n'));
    textSpanList.add(TextSpan(text: '\n'));
    textSpanList.add(TextSpan(text: '7) 하나님! \n'));
    textSpanList.add(TextSpan(text: target6, style: TextStyle(color: Colors.blue) )); //, recognizer: TapGestureRecognizer()..onTapDown = (p) => {Navigator.pushNamed(context, '/conf/person')} ));
    textSpanList.add(TextSpan(text: '이(가) 시험에 들지 않기를 원합니다.\n'));
    textSpanList.add(TextSpan(text: '마귀에게 시험당하지 않기를 원합니다.\n'));
    textSpanList.add(TextSpan(text: '세상에서 시험당하지 않기를 원합니다.\n'));
    textSpanList.add(TextSpan(text: '물질이나 명예로 시험당하지 않기를 원합니다.\n'));
    textSpanList.add(TextSpan(text: '사람들로 인해 시험 들지 않기를 원합니다.\n'));
    textSpanList.add(TextSpan(text: '신앙생활에 시험이 들지 않기를 원합니다.\n'));
    textSpanList.add(TextSpan(text: '사업장의 생활과 교인들로 인하여 시험 들지 않기를 원합니다.\n'));
    textSpanList.add(TextSpan(text: '가정에서 시험에 들지 않기를 원합니다.\n'));
    textSpanList.add(TextSpan(text: target6, style: TextStyle(color: Colors.blue) )); //, recognizer: TapGestureRecognizer()..onTapDown = (p) => {Navigator.pushNamed(context, '/conf/person')} ));
    textSpanList.add(TextSpan(text: '이(가) 시험에 들지 않도록 지켜 주옵소서.\n'));
    textSpanList.add(TextSpan(text: '\n'));
    textSpanList.add(TextSpan(text: '8) 하나님! '));
    textSpanList.add(TextSpan(text: target6, style: TextStyle(color: Colors.blue) )); //, recognizer: TapGestureRecognizer()..onTapDown = (p) => {Navigator.pushNamed(context, '/conf/person')} ));
    textSpanList.add(TextSpan(text: '을(를) 악에서 구원하여 주옵소서.\n'));
    textSpanList.add(TextSpan(text: '우리에게는 악이 가득합니다.\n'));
    textSpanList.add(TextSpan(text: '사탄이 마음속에 악을 넣었습니다.\n'));
    textSpanList.add(TextSpan(text: '그래서 불평, 불만, 미움, 시기, 질투, 욕심, 원망, 정죄, 비판, 욕, 저주, 거짓, 불신앙, 불충, 불성실, 불순종, 인색함, 음란, 음행, 간음, 낙심, 슬픔, 우울함, 실망, 자살, 교만, 오만, 거역, 이기심, 나태, 게으름, 무사안일, 혈기, 신경질, 자랑, 더러운 마음, 배신 등의 악이 가득합니다.\n'));
    textSpanList.add(TextSpan(text: '이러한 악에서  '));
    textSpanList.add(TextSpan(text: target6, style: TextStyle(color: Colors.blue) )); //, recognizer: TapGestureRecognizer()..onTapDown = (p) => {Navigator.pushNamed(context, '/conf/person')} ));
    textSpanList.add(TextSpan(text: '이(가) 구원받기를 원합니다.\n'));
    textSpanList.add(TextSpan(text: '악을 주는 사탄의 세력을 쫓아 주옵소서.\n'));
    textSpanList.add(TextSpan(text: '그리고 악에서  '));
    textSpanList.add(TextSpan(text: target6, style: TextStyle(color: Colors.blue) )); //, recognizer: TapGestureRecognizer()..onTapDown = (p) => {Navigator.pushNamed(context, '/conf/person')} ));
    textSpanList.add(TextSpan(text: '을(를) 구원하여 교회로 인도하여 주옵소서.\n'));
    textSpanList.add(TextSpan(text: target6, style: TextStyle(color: Colors.blue) )); //, recognizer: TapGestureRecognizer()..onTapDown = (p) => {Navigator.pushNamed(context, '/conf/person')} ));
    textSpanList.add(TextSpan(text: '이(가) 세상의 악에 물들지 않도록 지켜 주옵소서.\n'));
    textSpanList.add(TextSpan(text: target6, style: TextStyle(color: Colors.blue) )); //, recognizer: TapGestureRecognizer()..onTapDown = (p) => {Navigator.pushNamed(context, '/conf/person')} ));
    textSpanList.add(TextSpan(text: '은(는) 연약하오니 하나님께서 악을 물리치고 이길 수 있는 힘을 공급하여 주옵소서.\n'));
    textSpanList.add(TextSpan(text: '\n'));
    textSpanList.add(TextSpan(text: '9) 하나님의 나라와 권세와 영광이 영원히, 영원히 하나님 아버지께 있사오며,\n'));
    textSpanList.add(TextSpan(text: '\n'));
    textSpanList.add(TextSpan(text: '10) 예수님의 이름으로 기도드립니다. 아멘.\n\n\n'));

    textSpanList.add(TextSpan(text: '7. 가정을 위한 기도\n\n', style: TextStyle(color: Colors.black, fontSize: 30)));
    textSpanList.add(TextSpan(text: '1) 하나님 아버지는 거룩하십니다.\n'
        '하나님 아버지의 이름이 우리 가정을 통하여 거룩히 여김 받으시기를 원합니다.\n'
        '그러므로 우리 가정이 하나님의 이름을 거룩하게 할 일만 행하게 하옵소서.\n'
        '하나님의 이름을 욕되게 하는 일이 없기를 원합니다.\n'
        '\n'
        '2) 하나님의 나라가 우리 가정에 이루어지기를 원합니다.\n'
        '그리하여 우리 가정 식구들의 마음에 하나님 나라를 이루고 살게 하옵소서\n'
        '또한 우리 가정에 의와 평강과 희락이 이루어져 가정 천국을 이루게 하옵소서.\n'
        '우리 가족이 하나님의 통치를 받으며 하나님의 백성답게 하나님 나라의 법을 지키며 살게 하옵시고, 우리 가족이 하나님의 법을 어기는 일이 없기를 원합니다.\n'
        '그리고 우리 가족이 하나님 나라의 영광을 위하여 일하게 하옵소서.\n'
        '우리 가족을 통하여 하나님의 나라가 세상 모든 사람들에게 전파되기를 원합니다.\n'
        '\n'
        '3) 하나님의 뜻이 하늘에서 이루어진 것 같이 땅에서 우리 가정에 이루어지기를 원합니다.\n'
        '또한 우리 가정이 하나님의 선하신 뜻을 깨닫고 행하기를 기도합니다.\n'
        '하나님의 뜻이 우리 가정을 통하여 온 땅에 전파되기를 원합니다.\n'
        '\n'
        '4) 하나님께서 우리 가정에 평생 동안 일용할 양식을 공급해 주시기를 원합니다.\n'
        '또 세상에서 살아가는데 필요한 것을 공급해 주시기를 원합니다.\n'
        '우리 가정에 현재 필요한 것들이 많이 있습니다.\n'
        '하나님께서 공급하여 주옵소서.\n'
        '또 풍성하여 이웃들에게 나누어 주며 살게 하옵소서.\n'
        '그리고 우리 가정 식구들이 모두 죄인 된 것을 알고 회개하며 죄사함 받고 구원받게 하옵소서.\n'
        '또 교회의 법에 복종하며 불만 불평하지 말고 충성하며 헌신하게 하옵소서.\n'
        '복 받을 일을 하고 입술이나 말로 죄를 지어 복을 잃어버리지 않게 하옵소서.\n'
        '우리 가정을 통하여 주변 사람들이 하나님의 살아계심을 느끼고 예수 그리스도를 영접하고 믿기를 원합니다.\n'
        '우리 가정 식구들을 통하여 전도가 되도록 하옵소서.\n'
        '\n'
        '5) 하나님! 다른 사람의 죄를 용서합니다.\n'
        '우리 가정에 상처를 주고 힘들게 했던 사람들을 용서합니다.\n'
        '예수님의 이름으로 용서합니다.\n'
        '그리고 '));
    textSpanList.add(TextSpan(text: param7, style: TextStyle(color: Colors.blue) ));
    textSpanList.add(TextSpan(text: '을(를) 축복합니다.\n'
        '그들이 하나님을 경외하고 복 받기를 원합니다.\n'
        '\n'
        '6) 하나님! 다른 사람의 죄를 용서해 준 것 같이 우리 가정의 죄를 사하여 주옵소서.\n'
        '하나님만이 죄를 사하는 권세가 있는 줄 믿습니다.\n'
        '\n'
        '7) 하나님! 우리 가정이 시험에 들지 않기를 원합니다.\n'
        '마귀에게 시험당하지 않기를 원합니다.\n'
        '그러므로 마귀에게 시험 당함을 허락지 마옵소서.\n'
        '또 세상에 시험 당하지 않기를 원합니다.\n'
        '가난이나 물질, 질병, 불행한 사고, 세상 명예, 돈, 권력으로 시험당하지 않기를 원합니다.\n'
        '교회 생활에 시험 들지 않기를 원합니다.\n'
        '목회자나 성도, 교회에서 맡겨진 일들로부터 시험 들지 않기를 원합니다.\n'
        '\n'
        '8) 하나님! 우리 가정을 악에서 구원하여 주옵소서.\n'
        '우리 가정에 하나님의 법을 지키지 않는 악이 있습니다.\n'
        '우리 식구들 중에 악을 버리지 못하고 하나님이 싫어하는 행위를 하는 사람이 있습니다.\n'
        '이 악에서 우리 가정을 구원하여 주옵소서.\n'
        '그리하여 하나님의 법을 지키는 선한 가정이 되게 하옵소서.\n'
        '우리 가정이 세상의 악에 물들지 않도록 지켜 주옵소서.\n'
        '악은 모양이라도 보지 않게 하옵소서.\n'
        '우리 가정은 연약하오니 하나님께서 악을 이길 수 있는 힘을 공급하여 주옵소서.\n'
        '\n'
        '9) 하나님의 나라와 권세와 영광이 영원히, 영원히 하나님 아버지께 있사오며,\n'
        '\n'
        '10) 예수님의 이름으로 기도드립니다. 아멘.\n\n\n'));

    textSpanList.add(TextSpan(text: '8. 남편을 위한 기도\n\n', style: TextStyle(color: Colors.black, fontSize: 30)));
    textSpanList.add(TextSpan(text: '1) 하나님 아버지는 거룩하십니다.\n하나님 아버지의 이름이 남편('));
    textSpanList.add(TextSpan(text: target8, style: TextStyle(color: Colors.blue) )); //, recognizer: TapGestureRecognizer()..onTapDown = (p) => {Navigator.pushNamed(context, '/conf/husband')} ));
    textSpanList.add(TextSpan(text: ')을(를) 통하여 거룩히 여김 받으시기를 원합니다.\n'));
    textSpanList.add(TextSpan(text: '그리고 남편이'));
    textSpanList.add(TextSpan(text: ' 하나님의 이름을 거룩히 여기는 일을 찾아서 하기를 원합니다.\n'));
    textSpanList.add(TextSpan(text: '\n'));
    textSpanList.add(TextSpan(text: '2) 하나님의 나라가 '));
    textSpanList.add(TextSpan(text: '남편에게 이루어지기를 원합니다.'));
    textSpanList.add(TextSpan(text: '그리하여'));
    textSpanList.add(TextSpan(text: ' 남편의 심령에 의와 평강과 희락이 항상 있게 하옵소서.\n'));
    textSpanList.add(TextSpan(text: '항상 의로운 일만 행하게 하시며 마음에 평강이 있어서 여유 있게 웃으며 살게 하시고, 기쁨이 있어서 다른 사람을 즐겁게 하게 하옵소서.\n'));
    textSpanList.add(TextSpan(text: '남편이 하나님의 통치를 받아 하나님 나라의 법을 지키며 살게 하옵시고, 하나님의 법을 어기는 것은 버리게 하옵소서.\n'));
    textSpanList.add(TextSpan(text: '그리고 하나님 나라의 영광을 위하여 일하게 하옵소서.\n'));
    textSpanList.add(TextSpan(text: '또한 남편을 통하여 하나님의 나라가 세상 모든 사람들에게 전파되기를 원합니다.\n\n'));
    textSpanList.add(TextSpan(text: '3) 하나님의 뜻이 하늘에서 이루어진 것 같이 땅에서 남편에게 이루어지기를 원합니다.\n'));
    textSpanList.add(TextSpan(text: '또 남편이 하나님의 뜻을 깨닫고 이루어드리기를 기도합니다.\n'));
    textSpanList.add(TextSpan(text: '하나님의 뜻이 남편을 통하여 온 땅에 전파되기를 원합니다.\n\n'));
    textSpanList.add(TextSpan(text: '4) 하나님께서 남편에게 평생동안 일용할 양식을 공급해 주시기를 원합니다.\n'));
    textSpanList.add(TextSpan(text: '또 세상에서 살아가는데 필요한 것을 공급하여 주시기를 원합니다.\n'));
    textSpanList.add(TextSpan(text: '남편이 하는 일들을 축복하여 주옵소서.\n'));
    textSpanList.add(TextSpan(text: '큰 믿음과 건강을 주옵시며, 항상 하나님을 기쁘게 하는 사람이 되게 하옵소서.\n\n'));
    textSpanList.add(TextSpan(text: withPray8, style: TextStyle(color: Colors.blue) )); //, recognizer: TapGestureRecognizer()..onTapDown = (p) => {Navigator.pushNamed(context, '/conf/husband')} ));
    textSpanList.add(TextSpan(text: '\n남편에게 풍성한 물질을 주셔서 하나님을 위하여 언제나 마음껏 드리게 하옵시며 교회에서 모범적으로 충성하고 헌신하는 사람이 되게 하옵소서.'));
    textSpanList.add(TextSpan(text: '\n목사님께 순종하며 섬기는 믿음을 주옵시고, 성도를 사랑하며 겸손히 섬기는 신앙을 주옵소서.'));
    textSpanList.add(TextSpan(text: '\n가정에 충실하고 믿음의 제사장이 되어 가정을 신앙으로 이끌게 하옵소서.'));
    textSpanList.add(TextSpan(text: '\n아내와 자녀에게 좋은 본이 되게 하옵소서.'));
    textSpanList.add(TextSpan(text: '\n세상에서 믿음으로 살고 존경과 신뢰를 얻는 사람이 되게 하옵소서.'));
    textSpanList.add(TextSpan(text: '\n지혜와 명철을 주옵시고, 사랑과 온유와 오래 참음의 은사들을 공급하여 주옵소서.'));
    textSpanList.add(TextSpan(text: '\n또 풍성하여 이웃들에게 나누어 주며 살게 하옵소서.'));
    textSpanList.add(TextSpan(text: '\n남편의 주변 사람들이 남편을 보고 모두 구원받기를 원합니다.'));
    textSpanList.add(TextSpan(text: '\n그들을 구원하시어 하나님의 일꾼으로 사용하여 주옵소서.'));
    textSpanList.add(TextSpan(text: '\n'));
    textSpanList.add(TextSpan(text: '\n5) 하나님! 남편의 죄를 용서합니다.'));
    textSpanList.add(TextSpan(text: '\n나에게 상처를 주고 힘들게 하였던 남편을 용서합니다.'));
    textSpanList.add(TextSpan(text: '\n예수님의 이름으로 용서합니다.'));
    textSpanList.add(TextSpan(text: '\n그리고 남편을 축복합니다.'));
    textSpanList.add(TextSpan(text: '\n남편이 하나님을 경외하고 복 받기를 원합니다.'));
    textSpanList.add(TextSpan(text: '\n'));
    textSpanList.add(TextSpan(text: '\n6) 하나님! 다른 사람의 죄를 용서해 준 것 같이 나의 죄를 사하여 주옵소서.'));
    textSpanList.add(TextSpan(text: '\n나도 하나님 앞에 죄인입니다.'));
    textSpanList.add(TextSpan(text: '\n하나님만이 죄를 사하는 권세가 있는 줄 믿습니다.'));
    textSpanList.add(TextSpan(text: '\n'));
    textSpanList.add(TextSpan(text: '\n7) 하나님! 남편이 시험에 들지 않기를 원합니다.'));
    textSpanList.add(TextSpan(text: '\n마귀에게 시험당하지 않기를 원합니다.'));
    textSpanList.add(TextSpan(text: '\n그러므로 마귀에게 시험을 허락지 마옵소서.'));
    textSpanList.add(TextSpan(text: '\n또 남편이 세상에 시험당하지 않기를 원합니다.'));
    textSpanList.add(TextSpan(text: '\n물질이나 명예로 시험당하지 않기를 원합니다.'));
    textSpanList.add(TextSpan(text: '\n사람들로 인해 시험 들지 않기를 원합니다.'));
    textSpanList.add(TextSpan(text: '\n신앙생활에서 시험 들지 않기를 원합니다.'));
    textSpanList.add(TextSpan(text: '\n교회 생활과 교인들로 인하여 시험 들지 않기를 원합니다.'));
    textSpanList.add(TextSpan(text: '\n가정에서 시험 들지 않기를 원합니다.'));
    textSpanList.add(TextSpan(text: '\n남편이 시험에 들지 않도록 지켜 주옵소서.'));
    textSpanList.add(TextSpan(text: '\n'));
    textSpanList.add(TextSpan(text: '\n8) 하나님! 남편을 악에서 구원하여 주옵소서.'));
    textSpanList.add(TextSpan(text: '\n남편의 마음속에는 악이 가득합니다.'));
    textSpanList.add(TextSpan(text: '\n악을 주는 사탄의 세력을 쫓아 주옵소서.'));
    textSpanList.add(TextSpan(text: '\n그리고 악에서 남편을 구원하여 선한 마음으로 인도하여 주옵소서.'));
    textSpanList.add(TextSpan(text: '\n또한 남편이 세상의 악에 물들지 않도록 지켜 주옵소서.'));
    textSpanList.add(TextSpan(text: '\n남편은 연약하오니 하나님께서 악을 물리치고 이길 수 있는 힘을 공급하여 주옵소서.'));
    textSpanList.add(TextSpan(text: '\n'));
    textSpanList.add(TextSpan(text: '\n9) 하나님의 나라와 권세와 영광이 영원히, 영원히 하나님 아버지께 있사오며,'));
    textSpanList.add(TextSpan(text: '\n'));
    textSpanList.add(TextSpan(text: '\n10) 예수님의 이름으로 기도드립니다.'));
    textSpanList.add(TextSpan(text: '\n'));
    textSpanList.add(TextSpan(text: '\n아멘.\n\n\n'));

    textSpanList.add(TextSpan(text: '9. 아내를 위한 기도\n\n', style: TextStyle(color: Colors.black, fontSize: 30)));
    textSpanList.add(TextSpan(text: '\n1) 하나님 아버지는 거룩하신 분입니다.'));
    textSpanList.add(TextSpan(text: '\n하나님 아버지의 이름이 아내('));
    textSpanList.add(TextSpan(text: target9, style: TextStyle(color: Colors.blue) )); //, recognizer: TapGestureRecognizer()..onTapDown = (p) => {Navigator.pushNamed(context, '/conf/wife')} ));
    textSpanList.add(TextSpan(text: ')을(를) 통하여 거룩히 여김 받으시기를 원합니다.'));
    textSpanList.add(TextSpan(text: '\n그리고 아내가 하나님의 이름을 거룩히 여기는 일을 찾아서 하기를 원합니다.'));
    textSpanList.add(TextSpan(text: '\n'));
    textSpanList.add(TextSpan(text: '\n2) 하나님의 나라가 아내에게 이루어지기를 원합니다.'));
    textSpanList.add(TextSpan(text: '\n그리하여 어려움 중에도 아내의 심령에 의와 평강과 희락이 항상 있어 마음의 천국이 이루어지게 하옵소서.'));
    textSpanList.add(TextSpan(text: '\n늘 하나님이 주시는 은혜로 살아가게 하옵소서.'));
    textSpanList.add(TextSpan(text: '\n몸은 땅에 있어도 마음은 하나님 나라에 두고 살게 하옵소서.'));
    textSpanList.add(TextSpan(text: '\n그리고 아내가 하나님의 통치를 받으며 하나님 나라의 법을 지키며 살게 하옵시고, 하나님 나라의 영광을 위하여 일하게 하옵소서.'));
    textSpanList.add(TextSpan(text: '\n그리고 아내를 통하여 하나님의 나라가 세상 모든 사람들에게 전파되기를 원합니다.'));
    textSpanList.add(TextSpan(text: '\n'));
    textSpanList.add(TextSpan(text: '\n3) 하나님의 뜻이 하늘에서 이루어진 것 같이 땅에서 아내에게 이루어지기를 원합니다.'));
    textSpanList.add(TextSpan(text: '\n또 아내가 하나님의 뜻을 깨닫고 이루어드리기를 기도합니다.'));
    textSpanList.add(TextSpan(text: '\n하나님의 뜻이 아내를 통하여 온 땅에 전파되기를 원합니다.'));
    textSpanList.add(TextSpan(text: '\n'));
    textSpanList.add(TextSpan(text: '\n4) 하나님께서 아내에게 평생 동안 일용할 양식을 공급해 주시기를 원합니다.'));
    textSpanList.add(TextSpan(text: '\n또 세상에 살아가는데 필요한 것을 공급하여 주시기를 원합니다.'));
    textSpanList.add(TextSpan(text: '\n아내가 하는 일들을 축복하여 주옵소서.'));
    textSpanList.add(TextSpan(text: '\n그리고 큰 믿음과 건강을 주옵시며, 항상 하나님을 기쁘게 하는 사람이 되게 하옵소서.'));
    textSpanList.add(TextSpan(text: '\n또 아내의 기도를 들어 주옵소서.'));
    textSpanList.add(TextSpan(text: '\n\n'));
    textSpanList.add(TextSpan(text: withPray9, style: TextStyle(color: Colors.blue) )); //, recognizer: TapGestureRecognizer()..onTapDown = (p) => {Navigator.pushNamed(context, '/conf/wife')} ));
    textSpanList.add(TextSpan(text: '\n아내에게 풍성한 물질을 주셔서 하나님을 위하여 언제나 마음껏 드리게 하옵시며, 모범적으로 충성하고 헌신하는 사람이 되게 하옵소서.'));
    textSpanList.add(TextSpan(text: '\n목사님께 순종하며 섬기는 믿음을 주옵시고, 성도를 사랑하며 겸손히 섬기는 신앙을 주옵소서.'));
    textSpanList.add(TextSpan(text: '\n가정에 충실하고 믿음의 사람이 되어 가정을 신앙으로 이끌게 하옵소서.'));
    textSpanList.add(TextSpan(text: '\n남편과 자녀에게 현모양처가 되게 하옵소서.'));
    textSpanList.add(TextSpan(text: '\n세상에서 믿음으로 살고 존경과 신뢰를 얻는 사람이 되게 하옵소서.'));
    textSpanList.add(TextSpan(text: '\n지혜와 명철을 주옵시고, 사랑과 온유와 오래 참음의 은사들을 공급하여 주옵소서.'));
    textSpanList.add(TextSpan(text: '\n또 풍성하여 이웃들에게 나누어 주며 살게 하옵소서.'));
    textSpanList.add(TextSpan(text: '\n또한 아내의 주변 사람들이 모두 구원받기를 원합니다.'));
    textSpanList.add(TextSpan(text: '\n그들을 구원하시어 하나님의 일꾼으로 사용하여 주옵소서.'));
    textSpanList.add(TextSpan(text: '\n'));
    textSpanList.add(TextSpan(text: '\n5) 하나님! 아내의 죄를 용서합니다'));
    textSpanList.add(TextSpan(text: '\n나에게 상처를 주고 힘들게 했던 아내를 용서합니다.'));
    textSpanList.add(TextSpan(text: '\n예수님의 이름으로 용서합니다.'));
    textSpanList.add(TextSpan(text: '\n그리고 아내를 축복합니다.'));
    textSpanList.add(TextSpan(text: '\n아내가 하나님을 경외하고 복 받기를 원합니다.'));
    textSpanList.add(TextSpan(text: '\n'));
    textSpanList.add(TextSpan(text: '\n6) 하나님! 다른 사람의 죄를 용서해 준 것 같이 나의 죄를 사하여 주옵소서.'));
    textSpanList.add(TextSpan(text: '\n나도 하나님 앞에 죄인입니다.'));
    textSpanList.add(TextSpan(text: '\n하나님만이 죄를 사하는 권세가 있는 줄 믿습니다.'));
    textSpanList.add(TextSpan(text: '\n'));
    textSpanList.add(TextSpan(text: '\n7) 하나님! 아내가 시험에 들지 않기를 원합니다.'));
    textSpanList.add(TextSpan(text: '\n마귀에게 시험을 허락지 마옵소서.'));
    textSpanList.add(TextSpan(text: '\n또 아내가 나에게 시험당하지 않기를 원합니다.'));
    textSpanList.add(TextSpan(text: '\n세상에 시험당하지 않기를 원합니다.'));
    textSpanList.add(TextSpan(text: '\n물질이나 명예로 시험당하지 않기를 원합니다.'));
    textSpanList.add(TextSpan(text: '\n사람들로 인해 시험 들지 않기를 원합니다.'));
    textSpanList.add(TextSpan(text: '\n신앙생활에서 시험이 들지 않기를 원합니다.'));
    textSpanList.add(TextSpan(text: '\n교회 생활과 교인들로 인하여 시험 들지 않기를 원합니다.'));
    textSpanList.add(TextSpan(text: '\n가정에서 시험에 들지 않기를 원합니다.'));
    textSpanList.add(TextSpan(text: '\n아내가 시험에 들지 않도록 지켜 주옵소서.'));
    textSpanList.add(TextSpan(text: '\n'));
    textSpanList.add(TextSpan(text: '\n8) 하나님! 아내를 악에서 구원하여 주옵소서.'));
    textSpanList.add(TextSpan(text: '\n아내의 마음속에는 악이 가득합니다.'));
    textSpanList.add(TextSpan(text: '\n악을 주는 사탄의 세력을 쫓아 주옵소서.'));
    textSpanList.add(TextSpan(text: '\n그리고 악에서 아내를 구원하여 선한 마음으로 인도하여 주옵소서.'));
    textSpanList.add(TextSpan(text: '\n아내가 세상의 악에 물들지 않도록 지켜 주옵소서.'));
    textSpanList.add(TextSpan(text: '\n아내는 연약하오니 하나님께서 악을 물리치고 이길 수 있는 힘을 공급하여 주옵소서.'));
    textSpanList.add(TextSpan(text: '\n'));
    textSpanList.add(TextSpan(text: '\n9) 하나님의 나라와 권세와 영광이 영원히, 영원히 하나님 아버지께 있사오며,'));
    textSpanList.add(TextSpan(text: '\n'));
    textSpanList.add(TextSpan(text: '\n10) 예수님의 이름으로 기도드립니다.'));
    textSpanList.add(TextSpan(text: '\n'));
    textSpanList.add(TextSpan(text: '\n아멘.\n\n\n'));

    textSpanList.add(TextSpan(text: '10. 부모님을 위한 기도\n\n', style: TextStyle(color: Colors.black, fontSize: 30)));
    textSpanList.add(TextSpan(text: '1) 하나님 아버지는 거룩하신 분입니다.\n'));
    textSpanList.add(TextSpan(text: '하나님 아버지의 이름이 '));
    textSpanList.add(TextSpan(text: target10, style: TextStyle(color: Colors.blue) )); //, recognizer: TapGestureRecognizer()..onTapDown = (p) => {Navigator.pushNamed(context, '/conf/parents')} ));
    textSpanList.add(TextSpan(text: '을(를) 통하여 거룩히 여김 받으시기를 원합니다.\n'));
    textSpanList.add(TextSpan(text: '그러므로 '));
    textSpanList.add(TextSpan(text: target10, style: TextStyle(color: Colors.blue) )); //, recognizer: TapGestureRecognizer()..onTapDown = (p) => {Navigator.pushNamed(context, '/conf/parents')} ));
    textSpanList.add(TextSpan(text: '이(가) 하나님의 이름을 거룩히 할 일만 행하기를 원합니다.\n'));
    textSpanList.add(TextSpan(text: '\n'));
    textSpanList.add(TextSpan(text: '2) 하나님 나라를 창조하시고 사람의 믿음을 보시고 은혜로 주심을 감사합니다.\n'));
    textSpanList.add(TextSpan(text: '하나님의 나라가 '));
    textSpanList.add(TextSpan(text: target10, style: TextStyle(color: Colors.blue) )); //, recognizer: TapGestureRecognizer()..onTapDown = (p) => {Navigator.pushNamed(context, '/conf/parents')} ));
    textSpanList.add(TextSpan(text: '에게 이루어지기를 원합니다.\n'));
    textSpanList.add(TextSpan(text: '그리하여 '));
    textSpanList.add(TextSpan(text: target10, style: TextStyle(color: Colors.blue) )); //, recognizer: TapGestureRecognizer()..onTapDown = (p) => {Navigator.pushNamed(context, '/conf/parents')} ));
    textSpanList.add(TextSpan(text: '에게 의와 평강과 희락이 항상 있게 하옵소서.\n'));
    textSpanList.add(TextSpan(text: '그리고 '));
    textSpanList.add(TextSpan(text: target10, style: TextStyle(color: Colors.blue) )); //, recognizer: TapGestureRecognizer()..onTapDown = (p) => {Navigator.pushNamed(context, '/conf/parents')} ));
    textSpanList.add(TextSpan(text: '이(가) 하나님의 통치를 받으며 하나님의 백성답게 하나님 나라의 법을 지키며 살게 하옵시고, 하나님 나라의 영광을 위하여 일하게 하옵소서.\n'));
    textSpanList.add(TextSpan(text: '그리고 '));
    textSpanList.add(TextSpan(text: target10, style: TextStyle(color: Colors.blue) )); //, recognizer: TapGestureRecognizer()..onTapDown = (p) => {Navigator.pushNamed(context, '/conf/parents')} ));
    textSpanList.add(TextSpan(text: '을(를) 통하여 하나님 나라가 세상 모든 사람들에게 전파되기를 원합니다.\n'));
    textSpanList.add(TextSpan(text: '\n'));
    textSpanList.add(TextSpan(text: '3) 하나님의 뜻이 하늘에서 이루어진 것 같이 땅에서 '));
    textSpanList.add(TextSpan(text: target10, style: TextStyle(color: Colors.blue) )); //, recognizer: TapGestureRecognizer()..onTapDown = (p) => {Navigator.pushNamed(context, '/conf/parents')} ));
    textSpanList.add(TextSpan(text: '에게 이루어지기를 원합니다.\n'));
    textSpanList.add(TextSpan(text: '또 '));
    textSpanList.add(TextSpan(text: target10, style: TextStyle(color: Colors.blue) )); //, recognizer: TapGestureRecognizer()..onTapDown = (p) => {Navigator.pushNamed(context, '/conf/parents')} ));
    textSpanList.add(TextSpan(text: '을(를) 통하여 하나님의 선하신 뜻이 이루어지기를 기도합니다.\n'));
    textSpanList.add(TextSpan(text: '하나님의 뜻이 '));
    textSpanList.add(TextSpan(text: target10, style: TextStyle(color: Colors.blue) )); //, recognizer: TapGestureRecognizer()..onTapDown = (p) => {Navigator.pushNamed(context, '/conf/parents')} ));
    textSpanList.add(TextSpan(text: '을(를) 통하여 온 땅에 전파되기를 원합니다.\n'));
    textSpanList.add(TextSpan(text: '\n'));
    textSpanList.add(TextSpan(text: '4) 하나님께서 '));
    textSpanList.add(TextSpan(text: target10, style: TextStyle(color: Colors.blue) )); //, recognizer: TapGestureRecognizer()..onTapDown = (p) => {Navigator.pushNamed(context, '/conf/parents')} ));
    textSpanList.add(TextSpan(text: '에게 평생 동안 일용할 양식을 공급해 주시기를 원합니다.\n'));
    textSpanList.add(TextSpan(text: '또 세상에서 살아가는데 필요한 것을 공급해 주시기를 원합니다.\n'));
    textSpanList.add(TextSpan(text: '\n'));
    textSpanList.add(TextSpan(text: withPray10, style: TextStyle(color: Colors.blue) )); //, recognizer: TapGestureRecognizer()..onTapDown = (p) => {Navigator.pushNamed(context, '/conf/parents')} ));
    textSpanList.add(TextSpan(text: '\n'));
    textSpanList.add(TextSpan(text: target10, style: TextStyle(color: Colors.blue) )); //, recognizer: TapGestureRecognizer()..onTapDown = (p) => {Navigator.pushNamed(context, '/conf/parents')} ));
    textSpanList.add(TextSpan(text: '에게 현재 필요한 것들이 많이 있습니다.\n'));
    textSpanList.add(TextSpan(text: '하나님께서 공급하여 주옵소서.\n'));
    textSpanList.add(TextSpan(text: '또 풍성하여 이웃들에게 나누어 주며 살게 하옵소서.\n'));
    textSpanList.add(TextSpan(text: '또한 '));
    textSpanList.add(TextSpan(text: target10, style: TextStyle(color: Colors.blue) )); //, recognizer: TapGestureRecognizer()..onTapDown = (p) => {Navigator.pushNamed(context, '/conf/parents')} ));
    textSpanList.add(TextSpan(text: ' 주변의 사람들이 모두 구원받기를 원합니다.\n'));
    textSpanList.add(TextSpan(text: '그들을 구원하시어 하나님의 일꾼으로 사용하여 주옵소서.\n'));
    textSpanList.add(TextSpan(text: '그리고 노년에 영혼이 잘되게 하시며 육신은 건강하게 사시다가 하나님 나라에 가게 하옵소서.\n'));
    textSpanList.add(TextSpan(text: '또 항상 말씀을 묵상하고 기도하시다가 하나님의 부름을 받게 하옵소서.\n'));
    textSpanList.add(TextSpan(text: '하나님이 부르시는 그날을 생각하며 전도하고 충성하게 하옵소서.\n'));
    textSpanList.add(TextSpan(text: '하나님 나라에 가서 영광 얻을 일을 많이 하게 하옵소서.\n'));
    textSpanList.add(TextSpan(text: '\n'));
    textSpanList.add(TextSpan(text: '5) 하나님! '));
    textSpanList.add(TextSpan(text: target10, style: TextStyle(color: Colors.blue) )); //, recognizer: TapGestureRecognizer()..onTapDown = (p) => {Navigator.pushNamed(context, '/conf/parents')} ));
    textSpanList.add(TextSpan(text: '의 죄를 용서합니다.\n'));
    textSpanList.add(TextSpan(text: '나에게 상처를 주고 힘들게 하였던 '));
    textSpanList.add(TextSpan(text: target10, style: TextStyle(color: Colors.blue) )); //, recognizer: TapGestureRecognizer()..onTapDown = (p) => {Navigator.pushNamed(context, '/conf/parents')} ));
    textSpanList.add(TextSpan(text: '을(를) 용서합니다.\n'));
    textSpanList.add(TextSpan(text: '예수님의 이름으로 용서합니다.\n'));
    textSpanList.add(TextSpan(text: '그리고 '));
    textSpanList.add(TextSpan(text: target10, style: TextStyle(color: Colors.blue) )); //, recognizer: TapGestureRecognizer()..onTapDown = (p) => {Navigator.pushNamed(context, '/conf/parents')} ));
    textSpanList.add(TextSpan(text: '을(를) 축복합니다.\n'));
    textSpanList.add(TextSpan(text: '영혼이 잘되고 하나님을 경외하고 복 받기를 원합니다.\n'));
    textSpanList.add(TextSpan(text: '\n'));
    textSpanList.add(TextSpan(text: '6) 하나님! 다른 사람의 죄를 용서해 준 것 같이 나의 죄를 용서하여 주옵소서.\n'));
    textSpanList.add(TextSpan(text: '나도 하나님 앞에 죄인입니다.\n'));
    textSpanList.add(TextSpan(text: '하나님만이 죄를 사하는 권세가 있는 줄 믿습니다.\n'));
    textSpanList.add(TextSpan(text: '그리고 '));
    textSpanList.add(TextSpan(text: target10, style: TextStyle(color: Colors.blue) )); //, recognizer: TapGestureRecognizer()..onTapDown = (p) => {Navigator.pushNamed(context, '/conf/parents')} ));
    textSpanList.add(TextSpan(text: '의 죄도 용서하여 주옵소서.\n'));
    textSpanList.add(TextSpan(text: '\n'));
    textSpanList.add(TextSpan(text: '7) 하나님! '));
    textSpanList.add(TextSpan(text: target10, style: TextStyle(color: Colors.blue) )); //, recognizer: TapGestureRecognizer()..onTapDown = (p) => {Navigator.pushNamed(context, '/conf/parents')} ));
    textSpanList.add(TextSpan(text: '이(가) 시험에 들지 않기를 원합니다.\n'));
    textSpanList.add(TextSpan(text: '마귀에게 시험당하지 않기를 원합니다.\n'));
    textSpanList.add(TextSpan(text: '그러므로 마귀에게 시험을 허락지 마옵소서.\n'));
    textSpanList.add(TextSpan(text: '믿음에서 떠나는 시험을 허락하지 마옵소서.\n'));
    textSpanList.add(TextSpan(text: '또 세상에서 시험당하지 않기를 원합니다.\n'));
    textSpanList.add(TextSpan(text: '가난이나 물질, 질병, 불행한 사고, 세상 명예, 돈, 권력으로 시험당하지 않기를 원합니다.\n'));
    textSpanList.add(TextSpan(text: '교회 생활에 시험 들지 않기를 원합니다.\n'));
    textSpanList.add(TextSpan(text: '목회자나 성도, 교회에서 맡겨진 일들로부터 시험 들지 않기를 원합니다.\n'));
    textSpanList.add(TextSpan(text: target10, style: TextStyle(color: Colors.blue) )); //, recognizer: TapGestureRecognizer()..onTapDown = (p) => {Navigator.pushNamed(context, '/conf/parents')} ));
    textSpanList.add(TextSpan(text: '에게 시험이 없기를 기도합니다.\n'));
    textSpanList.add(TextSpan(text: '\n'));
    textSpanList.add(TextSpan(text: '8) 하나님! '));
    textSpanList.add(TextSpan(text: target10, style: TextStyle(color: Colors.blue) )); //, recognizer: TapGestureRecognizer()..onTapDown = (p) => {Navigator.pushNamed(context, '/conf/parents')} ));
    textSpanList.add(TextSpan(text: '을(를) 악에서 구원하여 주옵소서.\n'));
    textSpanList.add(TextSpan(text: target10, style: TextStyle(color: Colors.blue) )); //, recognizer: TapGestureRecognizer()..onTapDown = (p) => {Navigator.pushNamed(context, '/conf/parents')} ));
    textSpanList.add(TextSpan(text: '에게 하나님의 법을 지키지 않는 악이 있습니다.\n'));
    textSpanList.add(TextSpan(text: '때때로 불순종과 급한 성품 그리고 말로 인한 악에서 '));
    textSpanList.add(TextSpan(text: target10, style: TextStyle(color: Colors.blue) )); //, recognizer: TapGestureRecognizer()..onTapDown = (p) => {Navigator.pushNamed(context, '/conf/parents')} ));
    textSpanList.add(TextSpan(text: '을(를) 구원하여 주옵소서.\n'));
    textSpanList.add(TextSpan(text: target10, style: TextStyle(color: Colors.blue) )); //, recognizer: TapGestureRecognizer()..onTapDown = (p) => {Navigator.pushNamed(context, '/conf/parents')} ));
    textSpanList.add(TextSpan(text: '이(가) 세상의 욕심의 악에 물들지 않도록 지켜 주옵소서.\n'));
    textSpanList.add(TextSpan(text: '악은 모양이라도 보지 않게 하옵소서.\n'));
    textSpanList.add(TextSpan(text: target10, style: TextStyle(color: Colors.blue) )); //, recognizer: TapGestureRecognizer()..onTapDown = (p) => {Navigator.pushNamed(context, '/conf/parents')} ));
    textSpanList.add(TextSpan(text: '은(는) 연약하오니 하나님께서 악을 이길 수 있는 힘을 공급하여 주옵소서.\n'));
    textSpanList.add(TextSpan(text: '\n'));
    textSpanList.add(TextSpan(text: '9) 하나님의 나라와 권세와 영광이 영원히, 영원히 하나님 아버지께 있사오며,\n'));
    textSpanList.add(TextSpan(text: '\n'));
    textSpanList.add(TextSpan(text: '10) 예수님의 이름으로 기도드립니다.\n'));
    textSpanList.add(TextSpan(text: '\n'));
    textSpanList.add(TextSpan(text: '아멘.\n\n\n'));

    textSpanList.add(TextSpan(text: '11. 자녀를 위한 기도\n\n', style: TextStyle(color: Colors.black, fontSize: 30)));
    textSpanList.add(TextSpan(text: '1) 하나님 아버지는 거룩하신 분입니다.\n'));
    textSpanList.add(TextSpan(text: '하나님 아버지의 이름이 '));
    textSpanList.add(TextSpan(text: target11, style: TextStyle(color: Colors.blue) )); //, recognizer: TapGestureRecognizer()..onTapDown = (p) => {Navigator.pushNamed(context, '/conf/children')} ));
    textSpanList.add(TextSpan(text: '을(를) 통하여 거룩히 여김 받으시기를 원합니다.\n'));
    textSpanList.add(TextSpan(text: '그러므로 우리 '));
    textSpanList.add(TextSpan(text: target11, style: TextStyle(color: Colors.blue) )); //, recognizer: TapGestureRecognizer()..onTapDown = (p) => {Navigator.pushNamed(context, '/conf/children')} ));
    textSpanList.add(TextSpan(text: '이(가) 하나님의 이름을 거룩히 할 일만 행하기를 원합니다.\n'));
    textSpanList.add(TextSpan(text: '\n'));
    textSpanList.add(TextSpan(text: '2) 하나님의 나라가 '));
    textSpanList.add(TextSpan(text: target11, style: TextStyle(color: Colors.blue) )); //, recognizer: TapGestureRecognizer()..onTapDown = (p) => {Navigator.pushNamed(context, '/conf/children')} ));
    textSpanList.add(TextSpan(text: '에게 이루어지기를 원합니다.\n'));
    textSpanList.add(TextSpan(text: '그리하여 '));
    textSpanList.add(TextSpan(text: target11, style: TextStyle(color: Colors.blue) )); //, recognizer: TapGestureRecognizer()..onTapDown = (p) => {Navigator.pushNamed(context, '/conf/children')} ));
    textSpanList.add(TextSpan(text: '의 마음에 의와 평강과 희락이 항상 있게 하옵시고, 세상 나라가 마음에 들어가지 않게 하옵소서.\n'));
    textSpanList.add(TextSpan(text: '그리고 '));
    textSpanList.add(TextSpan(text: target11, style: TextStyle(color: Colors.blue) )); //, recognizer: TapGestureRecognizer()..onTapDown = (p) => {Navigator.pushNamed(context, '/conf/children')} ));
    textSpanList.add(TextSpan(text: '이(가) 하나님의 통치를 받으며 하나님의 백성답게 하나님 나라의 법을 지키며 살게 하옵시고, 몸은 땅에 있지만 마음은 하나님 나라에 두고 살게 하옵소서.\n'));
    textSpanList.add(TextSpan(text: ''));
    textSpanList.add(TextSpan(text: target11, style: TextStyle(color: Colors.blue) )); //, recognizer: TapGestureRecognizer()..onTapDown = (p) => {Navigator.pushNamed(context, '/conf/children')} ));
    textSpanList.add(TextSpan(text: '이(가) 세상의 영광보다는 하나님 나라의 영광을 위하여 일하게 하옵소서.\n'));
    textSpanList.add(TextSpan(text: '그리고 '));
    textSpanList.add(TextSpan(text: target11, style: TextStyle(color: Colors.blue) )); //, recognizer: TapGestureRecognizer()..onTapDown = (p) => {Navigator.pushNamed(context, '/conf/children')} ));
    textSpanList.add(TextSpan(text: '을(를) 통하여 하나님의 나라가 세상 모든 사람들에게 전파되기를 원합니다.\n'));
    textSpanList.add(TextSpan(text: '\n'));
    textSpanList.add(TextSpan(text: '3) 하나님의 뜻이 하늘에서 이루어진 것 같이 땅에서 '));
    textSpanList.add(TextSpan(text: target11, style: TextStyle(color: Colors.blue) )); //, recognizer: TapGestureRecognizer()..onTapDown = (p) => {Navigator.pushNamed(context, '/conf/children')} ));
    textSpanList.add(TextSpan(text: '에게 이루어지기를 원합니다.\n'));
    textSpanList.add(TextSpan(text: '또 '));
    textSpanList.add(TextSpan(text: target11, style: TextStyle(color: Colors.blue) )); //, recognizer: TapGestureRecognizer()..onTapDown = (p) => {Navigator.pushNamed(context, '/conf/children')} ));
    textSpanList.add(TextSpan(text: '을(를) 통하여 하나님의 선하신 뜻이 땅에서 이루어지기를 기도합니다.\n'));
    textSpanList.add(TextSpan(text: '하나님의 뜻이 '));
    textSpanList.add(TextSpan(text: target11, style: TextStyle(color: Colors.blue) )); //, recognizer: TapGestureRecognizer()..onTapDown = (p) => {Navigator.pushNamed(context, '/conf/children')} ));
    textSpanList.add(TextSpan(text: '을(를) 통하여 온 땅에 전파되기를 원합니다.\n'));
    textSpanList.add(TextSpan(text: '\n'));
    textSpanList.add(TextSpan(text: '4) 하나님께서 '));
    textSpanList.add(TextSpan(text: target11, style: TextStyle(color: Colors.blue) )); //, recognizer: TapGestureRecognizer()..onTapDown = (p) => {Navigator.pushNamed(context, '/conf/children')} ));
    textSpanList.add(TextSpan(text: '에게 평생 동안 일용할 양식을 공급해 주시기를 원합니다.\n'));
    textSpanList.add(TextSpan(text: '또 세상에서 살아가는데 필요한 것을 공급해 주시기를 원합니다.\n'));
    textSpanList.add(TextSpan(text: ''));
    textSpanList.add(TextSpan(text: target11, style: TextStyle(color: Colors.blue) )); //, recognizer: TapGestureRecognizer()..onTapDown = (p) => {Navigator.pushNamed(context, '/conf/children')} ));
    textSpanList.add(TextSpan(text: '이(가) 살아가야 할 모든 생활 속에 축복하여 주옵소서.\n'));
    textSpanList.add(TextSpan(text: '그리고 큰 믿음을 주셔서 사용하시며 건강을 주셔서 항상 하나님을 기쁘게 하는 사람이 되게 하옵소서.\n'));
    textSpanList.add(TextSpan(text: '\n'));
    textSpanList.add(TextSpan(text: withPray11, style: TextStyle(color: Colors.blue) )); //, recognizer: TapGestureRecognizer()..onTapDown = (p) => {Navigator.pushNamed(context, '/conf/children')} ));
    textSpanList.add(TextSpan(text: '\n'));
    textSpanList.add(TextSpan(text: target11, style: TextStyle(color: Colors.blue) )); //, recognizer: TapGestureRecognizer()..onTapDown = (p) => {Navigator.pushNamed(context, '/conf/children')} ));
    textSpanList.add(TextSpan(text: '에게 지혜와 총명함을 주셔서 다윗처럼 하나님을 경외하게 하옵소서.\n'));
    textSpanList.add(TextSpan(text: '하나님을 제일 사랑하고 부모를 사랑하게 하옵시며, 기도의 사람이 되게 하옵소서.\n'));
    textSpanList.add(TextSpan(text: '언제나 머리가 되게 하옵시고, 교회와 세상의 리더가 되어 하나님의 뜻대로 모든 것을 새롭게 하는 사람이 되게 하옵소서.\n'));
    textSpanList.add(TextSpan(text: '주고, 섬기고, 대접하고, 사랑할 줄 아는 사람이 되게 하셔서, 이웃들에게 나누어 주며 살게 하옵소서.\n'));
    textSpanList.add(TextSpan(text: '또한 풍성한 물질을 주셔서 하나님을 위하여 언제나 풍성하게 드리게 하옵시며, 모범적으로 충성하고 헌신하는 사람이 되게 하옵소서.\n'));
    textSpanList.add(TextSpan(text: '목사님께 순종하며 섬기는 믿음을 주옵소서.\n'));
    textSpanList.add(TextSpan(text: '부모와 형제, 자매에게 신실한 사람이 되게 하옵시고, 세상에서 믿음으로 살고 존경과 신뢰를 얻는 사람이 되게 하옵소서.\n'));
    textSpanList.add(TextSpan(text: '또 온유와 오래 참음의 은사들을 공급하여 주옵소서.\n'));
    textSpanList.add(TextSpan(text: '또한 '));
    textSpanList.add(TextSpan(text: target11, style: TextStyle(color: Colors.blue) )); //, recognizer: TapGestureRecognizer()..onTapDown = (p) => {Navigator.pushNamed(context, '/conf/children')} ));
    textSpanList.add(TextSpan(text: '의 주변 사람들이 모두 구원받기를 원합니다.\n'));
    textSpanList.add(TextSpan(text: '그들을 구원하시어 하나님의 일꾼으로 사용하여 주옵소서.\n'));
    textSpanList.add(TextSpan(text: '\n'));
    textSpanList.add(TextSpan(text: '5) 하나님! '));
    textSpanList.add(TextSpan(text: target11, style: TextStyle(color: Colors.blue) )); //, recognizer: TapGestureRecognizer()..onTapDown = (p) => {Navigator.pushNamed(context, '/conf/children')} ));
    textSpanList.add(TextSpan(text: '의 죄를 용서합니다.\n'));
    textSpanList.add(TextSpan(text: '나에게 상처를 주고 힘들게 하였던 '));
    textSpanList.add(TextSpan(text: target11, style: TextStyle(color: Colors.blue) )); //, recognizer: TapGestureRecognizer()..onTapDown = (p) => {Navigator.pushNamed(context, '/conf/children')} ));
    textSpanList.add(TextSpan(text: '을(를) 용서합니다.\n'));
    textSpanList.add(TextSpan(text: '예수님의 이름으로 용서합니다.\n'));
    textSpanList.add(TextSpan(text: '그리고 '));
    textSpanList.add(TextSpan(text: target11, style: TextStyle(color: Colors.blue) )); //, recognizer: TapGestureRecognizer()..onTapDown = (p) => {Navigator.pushNamed(context, '/conf/children')} ));
    textSpanList.add(TextSpan(text: '을(를) 축복합니다.\n'));
    textSpanList.add(TextSpan(text: ''));
    textSpanList.add(TextSpan(text: target11, style: TextStyle(color: Colors.blue) )); //, recognizer: TapGestureRecognizer()..onTapDown = (p) => {Navigator.pushNamed(context, '/conf/children')} ));
    textSpanList.add(TextSpan(text: '이(가) 하나님을 경외하고 복 받기를 원합니다.\n'));
    textSpanList.add(TextSpan(text: '\n'));
    textSpanList.add(TextSpan(text: '6) 하나님! 다른 사람의 죄를 용서해 준 것 같이 나의 죄를 용서하여 주옵소서.\n'));
    textSpanList.add(TextSpan(text: '하나님만이 죄를 사하는 권세가 있는 줄 믿습니다.\n'));
    textSpanList.add(TextSpan(text: '\n'));
    textSpanList.add(TextSpan(text: '7) 하나님! '));
    textSpanList.add(TextSpan(text: target11, style: TextStyle(color: Colors.blue) )); //, recognizer: TapGestureRecognizer()..onTapDown = (p) => {Navigator.pushNamed(context, '/conf/children')} ));
    textSpanList.add(TextSpan(text: '이(가) 시험에 들지 않기를 원합니다.\n'));
    textSpanList.add(TextSpan(text: '마귀에게 시험당하지 않기를 원합니다.\n'));
    textSpanList.add(TextSpan(text: '그러므로 마귀에게 시험을 허락지 마옵소서.\n'));
    textSpanList.add(TextSpan(text: '또 세상에서 시험당하지 않기를 원합니다.\n'));
    textSpanList.add(TextSpan(text: '가난이나 물질, 질병, 불행한 사고, 세상 명예, 돈, 권력으로 시험당하지 않기를 원합니다.\n'));
    textSpanList.add(TextSpan(text: '교회 생활에 시험 들지 않기를 원합니다.\n'));
    textSpanList.add(TextSpan(text: '목회자나 성도, 교회에서 맡겨진 일들로부터 시험 들지 않기를 원합니다.\n'));
    textSpanList.add(TextSpan(text: '\n'));
    textSpanList.add(TextSpan(text: '8) 하나님! '));
    textSpanList.add(TextSpan(text: target11, style: TextStyle(color: Colors.blue) )); //, recognizer: TapGestureRecognizer()..onTapDown = (p) => {Navigator.pushNamed(context, '/conf/children')} ));
    textSpanList.add(TextSpan(text: '을(를) 악에서 구원하여 주옵소서.\n'));
    textSpanList.add(TextSpan(text: ''));
    textSpanList.add(TextSpan(text: target11, style: TextStyle(color: Colors.blue) )); //, recognizer: TapGestureRecognizer()..onTapDown = (p) => {Navigator.pushNamed(context, '/conf/children')} ));
    textSpanList.add(TextSpan(text: '에게 하나님의 법을 지키지 않는 악이 있습니다.\n'));
    textSpanList.add(TextSpan(text: '이 악에서 '));
    textSpanList.add(TextSpan(text: target11, style: TextStyle(color: Colors.blue) )); //, recognizer: TapGestureRecognizer()..onTapDown = (p) => {Navigator.pushNamed(context, '/conf/children')} ));
    textSpanList.add(TextSpan(text: '을(를) 구원하여 주옵소서.\n'));
    textSpanList.add(TextSpan(text: ''));
    textSpanList.add(TextSpan(text: target11, style: TextStyle(color: Colors.blue) )); //, recognizer: TapGestureRecognizer()..onTapDown = (p) => {Navigator.pushNamed(context, '/conf/children')} ));
    textSpanList.add(TextSpan(text: '이(가) 세상의 악에 물들지 않도록 지켜 주옵소서.\n'));
    textSpanList.add(TextSpan(text: '악은 모양이라도 보지 않게 하옵소서.\n'));
    textSpanList.add(TextSpan(text: '세상의 악이 유혹을 해도 물리치고 이기게 하옵소서.\n'));
    textSpanList.add(TextSpan(text: ''));
    textSpanList.add(TextSpan(text: target11, style: TextStyle(color: Colors.blue) )); //, recognizer: TapGestureRecognizer()..onTapDown = (p) => {Navigator.pushNamed(context, '/conf/children')} ));
    textSpanList.add(TextSpan(text: '은(는) 연약하오니 하나님께서 악을 이길 수 있는 힘을 공급하여 주옵소서.\n'));
    textSpanList.add(TextSpan(text: '\n'));
    textSpanList.add(TextSpan(text: '9) 하나님의 나라와 권세와 영광이 영원히, 영원히 하나님 아버지께 있사오며,\n'));
    textSpanList.add(TextSpan(text: '10) 예수님의 이름으로 기도드립니다.\n'));
    textSpanList.add(TextSpan(text: '\n'));
    textSpanList.add(TextSpan(text: '아멘.\n\n\n'));

    textSpanList.add(TextSpan(text: '27. 질병을 치료하는기도\n\n', style: TextStyle(color: Colors.black, fontSize: 30)));
    textSpanList.add(TextSpan(text: '1) 하나님은 거룩하신 분이십니다.\n'));
    textSpanList.add(TextSpan(text: '하나님 아버지의 이름이 나를 통하여 거룩히 여김 받으시기를 원합니다.\n'));
    textSpanList.add(TextSpan(text: '\n'));
    textSpanList.add(TextSpan(text: '2) 하나님 나라를 창조하시고 믿음을 보시고 은혜로 주심을 감사드립니다.\n'));
    textSpanList.add(TextSpan(text: '나의 영혼이 믿음을 인정받고 하나님 나라를 선물로 받게 하옵소서.\n'));
    textSpanList.add(TextSpan(text: '그리고 하나님께서 나의 마음과 육체를 통치하여 주옵소서.\n'));
    textSpanList.add(TextSpan(text: '\n'));
    textSpanList.add(TextSpan(text: '3) 하나님의 뜻이 하늘에서 이루어진 것 같이 나를 통하여 이 땅에서 이루어지기를 원합니다.\n'));
    textSpanList.add(TextSpan(text: '\n'));
    textSpanList.add(TextSpan(text: '4) 매일 일용할 양식과 필요한 것을 공급하여 주심을 감사드립니다.\n'));
    textSpanList.add(TextSpan(text: '\n'));
    textSpanList.add(TextSpan(text: '5-1) 자신의 병을 치료하기 위한 기도\n', style: TextStyle(color: Colors.grey)));
    textSpanList.add(TextSpan(text: '하나님! '));
    textSpanList.add(TextSpan(text: target27, style: TextStyle(color: Colors.blue) ));
    textSpanList.add(TextSpan(text: '의 '));
    textSpanList.add(TextSpan(text: accident27, style: TextStyle(color: Colors.blue) ));
    textSpanList.add(TextSpan(text: '를 용서합니다.\n'));
    textSpanList.add(TextSpan(text: '예수님의 말씀에 순종하여 무조건 용서합니다.\n'));
    textSpanList.add(TextSpan(text: '그리고 그를 축복합니다.\n'));
    textSpanList.add(TextSpan(text: '그가 하나님을 경외하고 복 받기를 원합니다.\n'));
    textSpanList.add(TextSpan(text: '\n'));
    textSpanList.add(TextSpan(text: '5-2) 다른 사람의 병을 치료하기 위한 기도\n', style: TextStyle(color: Colors.grey)));
    textSpanList.add(TextSpan(text: '하나님! '));
    textSpanList.add(TextSpan(text: patient27, style: TextStyle(color: Colors.blue) ));
    textSpanList.add(TextSpan(text: '가 다른 사람의 죄를 용서해 주기를 원합니다.\n'));
    textSpanList.add(TextSpan(text: '가슴에 맺혀 있는 미움과 분노와 증오를 버리고 이 시간에 예수님의 말씀에 순종하여 무조건으로 용서해 주기를 바랍니다.\n'));
    textSpanList.add(TextSpan(text: '자신도 남에게 상처를 준 죄인인 것을 알게 하시고 회개의 영을 부어 주옵소서.\n'));
    textSpanList.add(TextSpan(text: '\n'));
    textSpanList.add(TextSpan(text: '6-1) 자신의 병을 치료하기 위한 기도\n', style: TextStyle(color: Colors.grey)));
    textSpanList.add(TextSpan(text: '하나님! 다른 사람의 죄를 용서해 준 것같이 나의 죄를 사하여 주옵소서.\n'));
    textSpanList.add(TextSpan(text: '내가 하나님을 믿지 않고 지은 죄를 용서하여 주옵소서.\n'));
    textSpanList.add(TextSpan(text: '내가 하나님의 말씀을 불순종한 것을 용서하여 주옵소서'));
    textSpanList.add(TextSpan(text: sin27, style: TextStyle(color: Colors.blue) ));
    textSpanList.add(TextSpan(text: '\n모든 죄를 예수님의 십자가의 보혈로 씻어 주옵소서.\n'));
    textSpanList.add(TextSpan(text: '다시는 같은 죄를 범하지 않겠습니다.\n'));
    textSpanList.add(TextSpan(text: '하나님만이 죄를 사하는 권세가 있는 줄 믿습니다.\n'));
    textSpanList.add(TextSpan(text: '\n'));
    textSpanList.add(TextSpan(text: '6-2) 다른 사람의 병을 치료하기 위한 기도\n', style: TextStyle(color: Colors.grey)));
    textSpanList.add(TextSpan(text: patient27, style: TextStyle(color: Colors.blue) ));
    textSpanList.add(TextSpan(text: '가 자신도 죄인 중에 괴수인 것을 깨닫게 하시고 진심으로 회개하는 마음을 주옵소서.\n'));
    textSpanList.add(TextSpan(text: '그리고 회개할 때 지금까지의 모든 죄를 예수님의 십자가의 보혈로 씻어 주옵소서.\n'));
    textSpanList.add(TextSpan(text: '다시는 같은 죄를 범하지 않도록 할 것입니다.\n'));
    textSpanList.add(TextSpan(text: '하나님만이 죄를 사하는 권세가 있는 줄 믿습니다.\n'));
    textSpanList.add(TextSpan(text: '하나님! 나('));
    textSpanList.add(TextSpan(text: patient27, style: TextStyle(color: Colors.blue) ));
    textSpanList.add(TextSpan(text: ')에게 건강을 선물로 주옵소서.\n'));
    textSpanList.add(TextSpan(text: '\n'));
    textSpanList.add(TextSpan(text: '예수님이 말씀하시기를 (막 16:17~18) "[17] 믿는 자들에게는 이런 표적이 따르리니 곧 그들이 내 이름으로 귀신을 쫓아내며 새 방언을 말하며 [18] 뱀을 집어올리며 무슨 독을 마실지라도 해를 받지 아니하며 병든 사람에게 손을 얹은즉 나으리라."고 하셨습니다.\n'));
    textSpanList.add(TextSpan(text: '\n'));
    textSpanList.add(TextSpan(text: '이 말씀대로 내게 이루어지게 하옵소서.\n'));
    textSpanList.add(TextSpan(text: '\'믿는 자들에게는 이런 표적이 따르리니 곧 그들이 내 이름으로 귀신을 쫓아내며,,,. 병든 사람에게 손을 얹은즉 나으리라 하신 말씀이 내게 이루어지기를 원합니다.\' (반복)\n'));
    textSpanList.add(TextSpan(text: '\n'));
    textSpanList.add(TextSpan(text: '\'예수님의 이름으로 명령하노니 내 몸속에 있는 '));
    textSpanList.add(TextSpan(text: disease27, style: TextStyle(color: Colors.blue) ));
    textSpanList.add(TextSpan(text: '은 없어져라! 병마는 떠나라! 귀신은 나가라!\' (계속 반복)\n'));
    textSpanList.add(TextSpan(text: '\''));
    textSpanList.add(TextSpan(text: disease27, style: TextStyle(color: Colors.blue) ));
    textSpanList.add(TextSpan(text: '은 치료될지어다! '));
    textSpanList.add(TextSpan(text: disease27, style: TextStyle(color: Colors.blue) ));
    textSpanList.add(TextSpan(text: '은 깨끗이 나을지어다!\' (반복)\n'));
    textSpanList.add(TextSpan(text: '하나님께서 치료해 주신 줄로 믿겠습니다.\n'));
    textSpanList.add(TextSpan(text: '\n'));
    textSpanList.add(TextSpan(text: '\'(막 11:24) \"그러므로 내가 너희에게 말하노니 무엇이든지 기도하고 구하는 것은 받은 줄로 믿으라 그리하면 너희에게 그대로 되리라.\" 예수님의 말씀대로 이루어질 줄 믿습니다.\' (반복)\n'));
    textSpanList.add(TextSpan(text: '\n'));
    textSpanList.add(TextSpan(text: '7) 하나님! 내가 마귀의 시험에 속아 넘어가지 않도록 지켜 주옵소서.\n'));
    textSpanList.add(TextSpan(text: '항상 마귀와 귀신을 물리치고 이기게 하옵소서.\n'));
    textSpanList.add(TextSpan(text: '\n'));
    textSpanList.add(TextSpan(text: '8) 하나님! 나를 여러 가지 악에서 구원해 주옵소서.\n'));
    textSpanList.add(TextSpan(text: '마음을 정결케 하시고, 꿈에서라도 악에 빠지지 않게 하옵소서.\n'));
    textSpanList.add(TextSpan(text: '\n'));
    textSpanList.add(TextSpan(text: '9) 하나님의 나라와 권세와 영광이 영원히 하나님 아버지께 있사오며,\n'));
    textSpanList.add(TextSpan(text: '\n'));
    textSpanList.add(TextSpan(text: '10) 예수님의 이름으로 기도드립니다.\n'));
    textSpanList.add(TextSpan(text: '\n'));
    textSpanList.add(TextSpan(text: '아멘.\n'));

    return textSpanList;
  }
}