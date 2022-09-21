import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:back_button_interceptor/back_button_interceptor.dart';

import '../main_page.dart';
import '../params.dart';

class PrayFull extends StatefulWidget {
  Future<Database> db;
  double initPos;

  PrayFull(this.db, this.initPos);

  @override
  State<StatefulWidget> createState() => _PrayFull();
}

class _PrayFull extends State<PrayFull> {
  ScrollController _scrollController = ScrollController();
  bool animatedActive = false;

  double initPos = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initPos = widget.initPos;
    BackButtonInterceptor.add(myInterceptor);
  }

  @override
  void dispose() {
    BackButtonInterceptor.remove(myInterceptor);
    _scrollController.dispose();
    super.dispose();
  }

  bool myInterceptor(bool stopDefaultButtonEvent, RouteInfo info) {
    _saveInitPos(_scrollController.offset);
    Navigator.pop(context); //뒤로가기
    return true;
  }
  
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
                _saveInitPos(_scrollController.offset);
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => MainPage(false)), (route) => false
                );
              },
              icon: Icon(Icons.home_filled)
          ),
          actions: [
            IconButton(
              onPressed: (){
                _scrollController.animateTo(
                    initPos,
                    duration: Duration(milliseconds: 1),
                    curve: Curves.linear
                );
              },
              icon: Icon(Icons.my_location_outlined))
          ],
        ),
        body:  Column(
          children: <Widget>[
            Expanded(
              child: GestureDetector(
                onTapDown: (TapDownDetails details) {
                  animatedActive = false;
                  _saveInitPos(_scrollController.offset);
                },
                child: SingleChildScrollView(
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
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // _inputButton(),
                Padding(
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                  child: ToggleSwitch(
                    minWidth: 35.0,
                    minHeight: 35.0,
                    fontSize: 20.0,
                    initialLabelIndex: 0,
                    activeBgColor: [Colors.green],
                    activeFgColor: Colors.white,
                    inactiveBgColor: Colors.grey,
                    inactiveFgColor: Colors.grey[900],
                    totalSwitches: 6,
                    labels: ['0', '1', '2', '3', '4', '5'],
                    onToggle: (index) {
                        int step = index!;
                        double targetPos;
                        if (step > 0) {
                          animatedActive = true;
                          targetPos = _scrollController.position.maxScrollExtent;
                        } else {
                          _saveInitPos(_scrollController.offset);
                          animatedActive = false;
                          targetPos = _scrollController.offset;
                          step = 1;
                        }
                        _scrollController.animateTo(
                            targetPos,
                            duration: Duration(seconds: ((targetPos - _scrollController.offset) / (10 * step)).round()),
                            curve: Curves.linear
                        );
                    },
                  ),
                ),
              ],
            )
          ]
        )
      ),
    );
  }

  // Widget _inputButton() {
  //   return Padding(
  //       padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
  //       child: OutlinedButton(
  //         // backgroundColor: Colors.grey,
  //         style: OutlinedButton.styleFrom(side: BorderSide(color:Colors.blue)),
  //         child: Text("기도\n입력", style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),),
  //         onPressed: (){
  //           _saveInitPos(_scrollController.offset);
  //           // Navigator.push(context, MaterialPageRoute(builder: (context) => ConfChurch(widget.db)),);
  //           Navigator.pushNamed(context, '/conf/church');
  //         },
  //       )
  //   );
  // }

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
    Params params12 = await getParams('personal_1');
    Params params13 = await getParams('personal_2');
    Params params14 = await getParams('repentance');
    Params params21 = await getParams('spouse');
    Params params26 = await getParams('devil');
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
    String? target12 = params12.param1 == null ? "다른 사람(OOO)" : params12.param1.toString();
    String? accident12 = params12.param2 == null ? "죄(어떤 죄)" : params12.param2.toString();
    String? target13 = params13.param1 == null ? "다른 사람(이름)" : params13.param1.toString();
    String? accident13 = params13.param3 == null ? "죄(구체적으로)" : params13.param3.toString();
    String? target14 = params14.param1 == null ? "다른 사람(이름)" : params14.param1.toString();
    String? accident14 = params14.param3 == null ? "죄(구체적으로)" : params14.param3.toString();
    String? param21 = params21.param1 ?? '남편(아내)';
    String? target27 = params27.param1 == null ? "다른 사람(이름)" : params27.param1.toString();
    String? accident27 = params27.param2 == null ? "죄(구체적으로)" : params27.param2.toString();
    String? patient27 = params27.param3 == null ? "이 환자" : params27.param3.toString();
    String? sin27 = params27.param4 == null ? "(구체적으로 죄를 말하며 회개하십시오)" : params27.param4.toString();
    String? target26 = params26.param1 == null ? "다른 사람(이름)" : params26.param1.toString();
    String? accident26 = params26.param3 == null ? "죄(구체적으로)" : params26.param3.toString();
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
    target12 = target12 == "" ? '다른 사람(OOO)' : target12;
    accident12 = accident12 == "" ? '죄(어떤 죄)' : accident12;
    target13 = target13 == "" ? '다른 사람(이름)' : target13;
    accident13 = accident13 == "" ? '죄(구체적으로)' : accident13;
    target14 = target14 == "" ? '다른 사람(이름)' : target14;
    accident14 = accident14 == "" ? '죄(구체적으로)' : accident14;
    String ext1 = param21 == '남편' ? '을' : '를';
    String ext2 = param21 == '남편' ? '이' : '가';
    String ext3 = param21 == '남편' ? '으로' : '로';
    target26 = target26 == "" ? '다른 사람(이름)' : target26;
    accident26 = accident26 == "" ? '죄(구체적으로)' : accident26;
    target27 = target27 == "" ? '다른 사람(이름)' : target27;
    accident27 = accident27 == "" ? '죄(구체적으로)' : accident27;
    patient27 = patient27 == "" ? '이 환자' : patient27;
    sin27 = sin27 == "" ? '(구체적으로 죄를 말하며 회개하십시오)' : sin27;
    disease27 = disease27 == "" ? '"위암(병명)' : disease27;

    List<TextSpan> textSpanList = [];
    textSpanList.add(TextSpan(text: '1. 나라를 위한 기도\n\n', style: TextStyle(fontSize: 30)));
    textSpanList.add(TextSpan(text: '1) 하나님 아버지는 거룩하십니다.\n'
        '하나님 아버지의 이름이 우리나라를 통하여 거룩히 여김 받으시기를 원합니다.\n'
        '그러므로 우리나라 지도자들과 백성들이 하나님의 이름을 거룩히 할 일만 행하게 하옵소서.\n'
        '\n'
        '2) 우리나라에 하나님의 나라가 이루어지기를 소원 합니다.\n'
        '그리하여 우리나라가 의와 평강과 희락이 있는 국가가 되게 하옵소서.\n'
        '우리나라가 하나님의 통치를 받아서 악이 없어지고 선을 행하는 하나님의 백성들이 되고 하나님 나라의 법을 지키며 살게 하옵시고, 세상의 영광 보다는 하나님 나라의 영광을 위하여 일하게 하옵소서.\n'
        '그리고 우리나라를 통하여 하나님 나라가 세상 모든 나라에 전파되기를 원합니다.\n'
        '\n'
        '3) 하나님의 뜻이 하늘에서 이루어진 것 같이 땅에서 우리나라에 이루어지기를 원합니다.\n'
        '또 우리나라를 통하여 하나님의 선하고 의로운 뜻이 이루어지기를 기도합니다.\n'
        '그리고 하나님의 뜻이 우리나라를 통하여 세계 만민에게 전파되기를 원합니다.\n'
        '\n'
        '4) 하나님께서 우리나라에 언제나 일용할 양식을 공급해 주시기를 원합니다.\n'
        '그리하여 가난한 사람이 없게 하옵소서.\n'
        '우리나라를 북한과 강대국들 사이에서 지켜 주옵소서.\n'
        '전쟁이 일어나지 않도록 보호하여 주옵소서.\n'
        '정치가 안정되게 하옵시고 노사가 안정되게 하옵소서.\n'
        '이기적인 마음을 버리고 서로 이해하고 사랑하는 풍토가 조성되게 하옵소서.\n'
        '또 경제 대국이 되어 믿는 사람들이 잘 살아 더 많은 선교를 할 수 있도록 축복하여 주옵소서.\n'
        '한국의 교회가 바르게 성장하게 하옵시고 많은 영혼을 구원하도록 하여 주옵소서.\n'
        '이 민족을 모두 구원하여 주옵소서.\n'
        '\n'
        '5) 하나님! 다른나라의 죄를 용서해 주시기 원합니다.\n'
        '우리나라에 상처를 주고 힘들게 하였던 사람들과 민족들을 용서해 주옵소서.\n'
        '예수님의 이름으로 용서해 주옵소서.\n'
        '그리고 그 민족과 사람들을 축복해 주옵소서.\n'
        '그 사람들이 하나님을 경외하고 복 받기를 원합니다.\n'
        '\n'
        '6) 하나님! 다른 나라들의 죄를 용서하여 준 것 같이 우리나라의 죄를 사하여 주옵소서.\n'
        '우리나라 지도자들과 백성들이 지은 죄가 많습니다.\n'
        '하나님만이 죄를 사하는 권세가 있는줄 믿습니다.\n'
        '\n'
        '7) 하나님! 우리나라가 시험에 들지 않기를 원합니다.\n'
        '마귀에게 시험당하지 않기를 원합니다.\n'
        '그러므로 마귀에게 시험을 허락지 마옵소서.\n'
        '우리나라가 전쟁, 지진, 홍수, 전염병, 내란, 기근, 가난 등으로 시험당하지 않기를 원합니다.\n'
        '교회에 핍박이 없게 하옵시고, 영적으로 사탄의 방해가 없도록 지켜 보호하여 주옵소서.\n'
        '천군천사를 보내 지켜 주옵소서.\n'
        '\n'
        '8) 하나님! 우리나라를 악에서 구원하여 주옵소서.\n'
        '우리나라에 하나님의 법을 지키지 않는 악이 가득합니다.\n'
        '이 악에서 우리나라를 구원하여 주옵소서.\n'
        '그리하여 하나님의 법을 지키는 선한 나라가 되게 하옵소서.\n'
        '우리나라가 타락한 세상의 악에 물들고 있습니다.\n'
        '어린아이, 청소년, 장년, 노년에 이르기까지 악에 물들고 있사오니 이 악에서 구원하여 주옵소서.\n'
        '모든 사람에게 악을 버릴 수 있는 마음을 주옵시며 악에서 구원하여 선한 백성들이 되게 하옵소서.\n'
        '하나님께서 이 백성에게 악을 이길 수 있는 힘을 공급하여 주옵소서.\n'
        '\n'
        '9) 하나님의 나라와 권세와 영광이 영원히, 영원히 하나님 아버지께 있사오며,\n'
        '\n'
        '10) 예수님의 이름으로 기도드립니다. 아멘.\n\n\n'));

    textSpanList.add(TextSpan(text: '2. 교회를 위한 기도\n\n', style: TextStyle(fontSize: 30)));
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

    textSpanList.add(TextSpan(text: '3. 담임목사님을 위한 기도\n\n', style: TextStyle(fontSize: 30)));
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

    textSpanList.add(TextSpan(text: '4. 목장과 목장원을 위한 기도\n\n', style: TextStyle(fontSize: 30)));
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

    textSpanList.add(TextSpan(text: '5. 태신자를 위한 기도\n\n', style: TextStyle(fontSize: 30)));
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

    textSpanList.add(TextSpan(text: '6. 사람을 위한 기도\n\n', style: TextStyle(fontSize: 30)));
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

    textSpanList.add(TextSpan(text: '7. 가정을 위한 기도\n\n', style: TextStyle(fontSize: 30)));
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

    textSpanList.add(TextSpan(text: '8. 남편을 위한 기도\n\n', style: TextStyle(fontSize: 30)));
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

    textSpanList.add(TextSpan(text: '9. 아내를 위한 기도\n\n', style: TextStyle(fontSize: 30)));
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

    textSpanList.add(TextSpan(text: '10. 부모님을 위한 기도\n\n', style: TextStyle(fontSize: 30)));
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

    textSpanList.add(TextSpan(text: '11. 자녀를 위한 기도\n\n', style: TextStyle(fontSize: 30)));
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

    textSpanList.add(TextSpan(text: '12. 개인기도\n\n', style: TextStyle(fontSize: 30)));
    textSpanList.add(TextSpan(text: '1) 하나님은 거룩한 분이십니다.\n'));
    textSpanList.add(TextSpan(text: '하나님 아버지의 이름이 나를 통하여 거룩히 여김 받으시기를 원합니다.\n'));
    textSpanList.add(TextSpan(text: '내가 하나님의 이름을 거룩히 할 일만 하게 하옵소서.\n'));
    textSpanList.add(TextSpan(text: '그리고 온 세상 사람들이 하나님의 이름을 거룩히 여기기를 원합니다.\n'));
    textSpanList.add(TextSpan(text: '\n'));
    textSpanList.add(TextSpan(text: '2) 하나님 나라를 창조하시고 사람의 믿음을 보시고 은혜로 주심을 감사합니다.\n'));
    textSpanList.add(TextSpan(text: '하나님의 나라가 내게 이루어지기를 원합니다.\n'));
    textSpanList.add(TextSpan(text: '그리하여 내 심령에 의와 평강과 희락이 항상 있어 마음의 천국이 이루어지고, 마귀에게 마음의 천국(의와 평강과 희락)을 빼앗기지 않게 하옵소서.\n'));
    textSpanList.add(TextSpan(text: '내가 하나님의 통치를 받으며 하나님의 백성답게 하나님 나라의 법을 지키며 살게 하옵시고, 몸은 세상에 있으나 마음은 하나님 나라를 이루고 사는 모습을 보이게 하옵소서.\n'));
    textSpanList.add(TextSpan(text: '그리고 나를 통하여 하나님의 나라가 세상 모든 사람들에게 전파되기를 원합니다.\n'));
    textSpanList.add(TextSpan(text: '\n'));
    textSpanList.add(TextSpan(text: '3) 하나님의 뜻이 하늘에서 이루어진 것 같이 땅에서 나에게 이루어지기를 원합니다.\n'));
    textSpanList.add(TextSpan(text: '또 내가 하나님의 뜻을 알고 이루어드리기를 기도합니다.\n'));
    textSpanList.add(TextSpan(text: '하나님의 뜻은 사람을 구원하는 일과 선과 의를 행하는 일인 줄로 압니다.\n'));
    textSpanList.add(TextSpan(text: '열심히 행하게 하옵소서.\n'));
    textSpanList.add(TextSpan(text: '하나님의 뜻이 나를 통하여 온 땅에 전파되기를 원합니다.\n'));
    textSpanList.add(TextSpan(text: '\n'));
    textSpanList.add(TextSpan(text: '4) 하나님께서 나에게 평생 동안 일용할 양식을 공급해 주시기를 원합니다.\n'));
    textSpanList.add(TextSpan(text: '또 세상에서 살아가는데 필요한 것을 공급해 주시기를 원합니다.\n'));
    textSpanList.add(TextSpan(text: '나에게 지금 필요한 것들이 많이 있습니다.\n'));
    textSpanList.add(TextSpan(text: '하나님께서 공급하여 주옵소서.\n'));
    textSpanList.add(TextSpan(text: '모든 것이 주께로부터 공급되는 줄을 믿습니다.\n'));
    textSpanList.add(TextSpan(text: '하나님을 사랑하고 이웃을 사랑하게 하옵소서.\n'));
    textSpanList.add(TextSpan(text: '성령 충만함과 믿음의 은사를 주시어 행하게 하옵소서.\n'));
    textSpanList.add(TextSpan(text: '또 나를 부인하고 나에게 주신 십자가를 지고 예수님의 뒤를 따르게 하옵소서.\n'));
    textSpanList.add(TextSpan(text: '나에게 버릴 것이 많이 있습니다.\n'));
    textSpanList.add(TextSpan(text: '세상의 악한 것들을 모두 버리게 하옵소서.\n'));
    textSpanList.add(TextSpan(text: '그리고 예수님의 마음을 배우게 하시며 온유와 겸손을 배워서 실천하게 하옵소서.\n'));
    textSpanList.add(TextSpan(text: '마음과 물질에 풍성하여 이웃들에게 나누어 주며 살게 하옵소서.\n'));
    textSpanList.add(TextSpan(text: '또한 나의 주변 사람들이 모두 구원받기를 원합니다.\n'));
    textSpanList.add(TextSpan(text: '그들을 구원하시어 하나님의 일꾼으로 사용하여 주옵소서.\n'));
    textSpanList.add(TextSpan(text: '\n'));
    textSpanList.add(TextSpan(text: '5) 하나님! '));
    textSpanList.add(TextSpan(text: target12, style: TextStyle(color: Colors.blue) )); //, recognizer: TapGestureRecognizer()..onTapDown = (p) => {Navigator.pushNamed(context, '/conf/personal_1')} ));
    textSpanList.add(TextSpan(text: '의 '));
    textSpanList.add(TextSpan(text: accident12, style: TextStyle(color: Colors.blue) )); //, recognizer: TapGestureRecognizer()..onTapDown = (p) => {Navigator.pushNamed(context, '/conf/personal_1')} ));
    textSpanList.add(TextSpan(text: '를 용서합니다.\n'));
    textSpanList.add(TextSpan(text: '나에게 상처를 주고 힘들게 했던 사람을 용서합니다.\n'));
    textSpanList.add(TextSpan(text: '나를 무시하고 멸시한 사람들을 용서합니다.\n'));
    textSpanList.add(TextSpan(text: '예수님의 이름으로 용서합니다.\n'));
    textSpanList.add(TextSpan(text: '그리고 그를 축복합니다.\n'));
    textSpanList.add(TextSpan(text: '그의 영혼이 잘되고 하나님을 경외하고 복 받기를 원합니다.\n'));
    textSpanList.add(TextSpan(text: '\n'));
    textSpanList.add(TextSpan(text: '6) 하나님! 다른 사람의 죄를 용서해 준 것 같이 나의 죄를 사하여 주옵소서.\n'));
    textSpanList.add(TextSpan(text: '나도 죄인 중에 괴수입니다.\n'));
    textSpanList.add(TextSpan(text: '그러므로 용서하여 주옵소서.\n'));
    textSpanList.add(TextSpan(text: '예수님의 십자가의 보혈로 씻어 주옵소서.\n'));
    textSpanList.add(TextSpan(text: '하나님만이 죄를 사하는 권세가 있는 줄 믿습니다.\n'));
    textSpanList.add(TextSpan(text: '\n'));
    textSpanList.add(TextSpan(text: '7) 하나님! 내가 시험에 들지 않기를 원합니다.\n'));
    textSpanList.add(TextSpan(text: '마귀에게 시험당하지 않기를 원합니다.\n'));
    textSpanList.add(TextSpan(text: '믿음의 시험이 없기를 원합니다.\n'));
    textSpanList.add(TextSpan(text: '욥과 같은 시험이 없기를 원합니다.\n'));
    textSpanList.add(TextSpan(text: '세상에서 시험당하지 않기를 원합니다.\n'));
    textSpanList.add(TextSpan(text: '물질이나 명예로 시험당하지 않기를 원합니다.\n'));
    textSpanList.add(TextSpan(text: '신앙생활에서 시험 들지 않기를 원합니다.\n'));
    textSpanList.add(TextSpan(text: '교회 생활에서 시험 들지 않기를 원합니다.\n'));
    textSpanList.add(TextSpan(text: '가정에서 시험 들지 않기를 원합니다.\n'));
    textSpanList.add(TextSpan(text: '하나님이 관심 없어 하는 것을 바라거나 가지려고 하지 않기를 원합니다.\n'));
    textSpanList.add(TextSpan(text: '하나님! 내가 시험에 들지 않도록 지켜 주옵소서.\n'));
    textSpanList.add(TextSpan(text: '\n'));
    textSpanList.add(TextSpan(text: '8) 하나님! 나를 악에서 구원하여 주옵소서.\n'));
    textSpanList.add(TextSpan(text: '나의 마음속에는 악이 가득합니다.\n'));
    textSpanList.add(TextSpan(text: '세상의 욕심과 부끄러운 마음이 있습니다.\n'));
    textSpanList.add(TextSpan(text: '버리지 못한 악한 습관들이 있습니다.\n'));
    textSpanList.add(TextSpan(text: '그러므로 이 악에서 나를 구원하여 선한 마음으로 인도하여 주옵소서.\n'));
    textSpanList.add(TextSpan(text: '나를 세상의 악에 물들지 않도록 지켜 주옵소서.\n'));
    textSpanList.add(TextSpan(text: '나는 연약하오니 하나님께서 악을 이길 수 있는 힘을 공급하여 주옵소서.\n'));
    textSpanList.add(TextSpan(text: '\n'));
    textSpanList.add(TextSpan(text: '9) 하나님의 나라와 권세와 영광이 영원히, 영원히 하나님 아버지께 있사오며,\n'));
    textSpanList.add(TextSpan(text: '\n'));
    textSpanList.add(TextSpan(text: '10) 예수님의 이름으로 기도드립니다.\n'));
    textSpanList.add(TextSpan(text: '\n'));
    textSpanList.add(TextSpan(text: '아멘.\n\n\n'));

    textSpanList.add(TextSpan(text: '13. 개인기도2\n\n', style: TextStyle(fontSize: 30)));
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
    textSpanList.add(TextSpan(text: target13, style: TextStyle(color: Colors.blue) )); //, recognizer: TapGestureRecognizer()..onTapDown = (p) => {Navigator.pushNamed(context, '/conf/personal_2')} ));
    textSpanList.add(TextSpan(text: '의 '));
    textSpanList.add(TextSpan(text: accident13, style: TextStyle(color: Colors.blue) )); //, recognizer: TapGestureRecognizer()..onTapDown = (p) => {Navigator.pushNamed(context, '/conf/personal_2')} ));
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
    textSpanList.add(TextSpan(text: '아멘\n\n\n'));

    textSpanList.add(TextSpan(text: '14. 회개기도\n\n', style: TextStyle(fontSize: 30)));
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
    textSpanList.add(TextSpan(text: target14, style: TextStyle(color: Colors.blue) )); //, recognizer: TapGestureRecognizer()..onTapDown = (p) => {Navigator.pushNamed(context, '/conf/repentance')} ));
    textSpanList.add(TextSpan(text : '의 '));
    textSpanList.add(TextSpan(text: accident14, style: TextStyle(color: Colors.blue) )); //, recognizer: TapGestureRecognizer()..onTapDown = (p) => {Navigator.pushNamed(context, '/conf/repentance')} ));
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
    textSpanList.add(TextSpan(text : '아멘.\n\n\n'));

    textSpanList.add(TextSpan(text: '15. 영적인 힘을 얻기 위한 기도\n\n', style: TextStyle(fontSize: 30)));
    textSpanList.add(TextSpan(text : '1) 전능하신 하나님! 하나님은 거룩한 분이십니다.\n'
        '하나님 아버지의 이름이 나를 통하여 거룩히 여김 받으시기를 원합니다.\n'
        '\n'
        '2) 하나님 나라를 창조하시고 사람의 믿음을 보시고 은혜로 구원하여 주심을 감사드립니다.\n'
        '영원한 하나님의 나라가 나에게 이루어지기를 원합니다.\n'
        '그리고 마음의 천국인 의와 평강과 희락이 마음속에 항상 있게 하옵소서.\n'
        '\n'
        '3) 하나님의 뜻이 하늘에서 이루어진 것 같이 나를 통하여 이 땅에서 이루어지기를 원합니다.\n'
        '\n'
        '4) 하나님, 이 시간에 내 마음속에 들어오셔서 나의 하나님이 되어주시고 나의 죄를 용서하시며 영생의 길로, 복된 길로 인도하여 주옵소서.\n'
        '하나님은 나의 하나님이십니다.\n'
        '하나님은 나의 전능자이십니다.\n'
        '하나님은 나의 창조주이십니다.\n'
        '하나님은 나의 구원자이십니다.\n'
        '하나님은 나의 치료자이십니다.\n'
        '하나님은 나의 생명이십니다.\n'
        '하나님은 나의 소망이십니다.\n'
        '하나님은 나의 평안이십니다.\n'
        '하나님은 나의 능력이십니다.\n'
        '하나님은 나의 축복이십니다.\n'
        '하나님은 나의 반석이시며, 산성이십니다.\n'
        '하나님은 나의 요새이시며, 피난처이십니다.\n'
        '나의 힘이 되신 하나님을 사랑합니다.\n'
        '나의 평생에 주의 인자하심과 성실하심 속에 거하게 하옵소서.\n'
        '\n'
        '5) 하나님! 다른 사람의 죄를 용서합니다.\n'
        '나에게 아픔과 상처를 주어 분노와 혈기를 일이키며 미움과 증오를 갖게 했던 사람을 용서합니다.\n'
        '그를 축복합니다.\n'
        '그 사람에게 말과 행동으로 분노와 혈기를 일으켰던 악한 영의 세력을 예수님의 이름으로 결박하사 그의 삶에서 물리쳐 주시고, 그의 행동과 입술의 열매가 믿음으로 아름답게 맺히도록 성령의 충만함으로 축복하옵소서.\n'
        '\n'
        '6) 하나님! 다른 사람의 죄를 용서해 준 것 같이 나의 말과 행동과 거짓과 욕심과 이기적인 마음과 혈기와 분노와 미움의 죄를 사하여 주옵소서.\n'
        '하나님만이 죄를 사하는 권세가 있는 줄 믿습니다.\n'
        '\n'
        '7) 하나님! 내가 이런 말과 행동으로 인하여 시험에 들지 않도록 내 마음을 지켜 주시기를 원합니다.\n'
        '사탄의 시험에 버려두지 마옵소서.\n'
        '\n'
        '8) 하나님! 나의 마음속에 있는 용서하지 못하는 악과 분노와 미움과 혈기의 악에서 구원하여 주옵소서.\n'
        '나는 연약하오니 하나님께서 악에 빠지지 않게 하옵소서.\n'
        '\n'
        '9) 하나님의 나라와 권세와 영광이 영원히 하나님 아버지께 있사오며,\n'
        '\n'
        '10) 예수님의 이름으로 기도드립니다. 아멘\n\n\n'));

    textSpanList.add(TextSpan(text: '16. 시험이 있을 때 드리는 기도\n\n', style: TextStyle(fontSize: 30)));
    textSpanList.add(TextSpan(text : '1) 하나님은 거룩하신 분이십니다.\n'
        '하나님 아버지의 이름이 나를 통하여 거룩히 여김 받으시기를 원합니다.\n'
        '\n'
        '2) 하나님의 나라가 나에게 이루어지기를 원합니다.\n'
        '나의 심령에 의와 평강과 희락이 항상 있게 하옵소서.\n'
        '\n'
        '3) 하나님의 뜻이 하늘에서 이루어진 것 같이 나를 통하여 이 땅에서 이루어지기를 원합니다.\n'
        '\n'
        '4) 하나님! 나의 기도를 방해하며 믿음을 훼방하고, 하나님을 찾지 못하게 하며 또 하나님께 예배하지 못하게 하고 말씀을 듣지도, 읽지도, 깨닫지도 못하게 하여 시험에 들게 하는 악한 영들을 물리쳐 주옵소서.\n'
        '나의 마음속에서 쫓아 주옵소서.\n'
        '그리고 내 삶의 현장인 가정과 직장과 사업장에서 시험 들게 하는 마귀를 물리쳐 주옵소서.\n'
        '마귀가 마음과 입술에 시험 들게 하나이다.\n'
        '물리쳐 주옵소서.\n'
        '나에게 시험이 올지라도 시험에 들지 않고 이기고 물리치는 믿음과 능력을 주옵소서.\n'
        '그리하여 매일 승리하여 감사함으로 살게 하옵소서.\n'
        '시험에 넘어지지 않게 하옵시고 시험을 통하여 연단되어 하나님께 인정받는 굳건한 믿음이 되게 하옵소서.\n'
        '\n'
        '성경 말씀을 믿고 기도합니다.\n'
        '\"시험을 가져오는 모든 악한 영들은 예수님의 이름으로 다 결박되어 내 영혼과 마음과 육체와 가정에서 떠나갈지어다!\n'
        '예수 그리스도의 이름으로 명하노니 떠나가라!\"\n'
        '하나님 아버지! 천군 천사들을 보내주셔서 모든 악한 영들을 진멸하며 가정과 우리의 삶을 보호해 주옵소서.\n'
        '시험과 모든 악으로 인해 연결된 죄의 사슬과 저주의 통로가 없어지게 하옵소서.\n'
        '그리고 축복의 통로가 열리게 하옵소서.\n'
        '\n'
        '5) 하나님! 다른사람의 죄를 용서합니다.\n'
        '나에게 상처를 주고 힘들게 했던 사람을 용서합니다. 예수님의 이름으로 용서합니다.\n'
        '그 사람을 축복합니다. 그 사람이 시험을 받을 때 이기는 사람이 되게 하옵소서.\n'
        '\n'
        '6) 하나님! 다른 사람의 죄를 용서해 준 것 같이 나의 죄를 용서하여 주옵소서.\n'
        '하나님만이 죄를 사하는 권세가 있는 줄 믿습니다.\n'
        '\n'
        '7) 하나님! 늘 시험에 들지 않도록 사탄의 시험에 버려두지 마옵소서.\n'
        '\n'
        '8) 하나님! 나를 악에서 구원하여 주옵소서.\n'
        '나의 마음속에 있는 여러 가지 악에서 구원하셔서 시험과 악을 통해 죄를 짓지 않도록 선한 마음으로 인도해 주옵소서.\n'
        '또한 세상의 수많은 악에 물들지 않도록 지켜 주옵소서.\n'
        '\n'
        '9) 하나님의 나라와 권세와 영광이 영원히 하나님 아버지께 있사오며,\n'
        '\n'
        '10) 예수님의 이름으로 기도드립니다.아멘\n\n\n'));

    textSpanList.add(TextSpan(text: '17. 기도가 잘 되지 않을 때 드리는 기도\n\n', style: TextStyle(fontSize: 30)));
    textSpanList.add(TextSpan(text : '1) 하나님은 거룩하신 분이십니다.\n'
        '하나님 아버지의 이름이 나를 통하여 거룩히 여김 받으시기를 원합니다.\n'
        '\n'
        '2) 하나님의 나라가 나에게 이루어지기를 원합니다.\n'
        '나의 심령에 의와 평강과 희락이 항상 있게 하옵소서.\n'
        '\n'
        '3) 하나님의 뜻이 하늘에서 이루어진 것 같이 나를 통하여 이 땅에서 이루어지기를 원합니다.\n'
        '\n'
        '4) 기도를 통해 하나님과의 대화의 길을 열어주신 주님, 기도의 말문이 막혀 기도하지 못하는 나의 입술을 열어 주시기를 간구합니다.\n'
        '바쁘다는 핑계로, 시간이 없다는 이유로, 여러 가지 다른 이유를 대고 하나님과 대화하는 기도 시간을 소홀히 하였습니다.\n'
        '신앙생활의 우선순위를 잊어버리고 사탄으로 하여금 틈을 타게 한 나의 악을 용서하여 주옵소서.\n'
        '영적인 호흡인 기도를 멈춤으로 인해 내 영이 목마른 가운데 있습니다.\n'
        '주님! 이 영혼을 불쌍히 여겨 주옵소서.\n'
        '늘 깨어 기도하라고 하셨는데 순간의 피곤함과 유혹을 이기지 못하는 나의 연약함을 도와주옵소서.\n'
        '이 시간 이후로는 기도가 즐거워지고 행복하게 하옵소서.\n'
        '기도의 은사를 주옵소서.\n'
        '기도의 능력을 주옵소서.\n'
        '내게 고난과 가난을 주심은 기도하라는 말씀이었는데 기도하지 못했음을 용서하여 주옵소서.\n'
        '이제는 새벽기도, 철야기도, 금식기도, 작정기도 하게 하옵소서.\n'
        '그리하여 다니엘처럼 기도의 사람이 되게 하옵소서.\n'
        '\n'
        '5) 하나님! 다른 사람의 죄를 용서합니다.\n'
        '나에게 상처를 주고 힘들게 했던 사람을 용서합니다.\n'
        '예수님의 이름으로 용서합니다.\n'
        '그를 축복합니다.\n'
        '\n'
        '6) 하나님! 다른 사람의 죄를 용서해 준 것 같이 나의 죄를 용서하여 주옵소서.\n'
        '기도의 중요성을 알면서도 게을러서 기도하지 못하고, 하나님의 기도하라는 뜻을 소홀히 한 죄를 용서하여 주옵소서.\n'
        '하나님만이 죄를 사하는 권세가 있는 줄 믿습니다.\n'
        '\n'
        '7) 하나님! 내가 시험에 들지 않기를 원합니다.\n'
        '사탄의 시험에 버려두지 마옵소서.\n'
        '\n'
        '8) 하나님! 나를 악에서 구원하여 주옵소서.\n'
        '나의 마음속에 있는 여러 가지 악에서 구원하셔서 선한 마음으로 인도해 주옵소서.\n'
        '또한 세상의 악에 물들지 않도록 지켜 주옵소서.\n'
        '\n'
        '9) 하나님의 나라와 권세와 영광이 영원히 하나님 아버지께 있사오며,\n'
        '\n'
        '10) 예수님의 이름으로 기도드립니다. 아멘\n\n\n'));

    textSpanList.add(TextSpan(text: '18. 삶에 지칠 때 드리는 기도\n\n', style: TextStyle(fontSize: 30)));
    textSpanList.add(TextSpan(text : '1) 하나님은 거룩하신 분이십니다.\n'
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
        '(요 14:1) "너희는 마음에 근심하지 말라. 하나님을 믿으니 또 나를 믿으라."고 하신 주님의 말씀을 믿습니다. 눈앞에 있는 일만 보고 힘들어 하지 말게 하시고 내가 생각하지 못하는 더 좋은 것을 예비하시는 주님의 뜻을 깨닫는 사람이 되게 하옵소서.\n'
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
        '10) 예수님의 이름으로 기도드립니다. 아멘\n\n\n'));

    textSpanList.add(TextSpan(text: '19. 감사할 때 드리는 기도\n\n', style: TextStyle(fontSize: 30)));
    textSpanList.add(TextSpan(text : '1) 하나님은 거룩하신 분이십니다.\n'
        '하나님 아버지의 이름이 나를 통하여 거룩히 여김 받으시기를 원합니다.\n'
        '\n'
        '2) 하나님의 나라가 나에게 이루어지기를 원합니다.\n'
        '나의 심령에 의와 평강와 희락이 항상 있게 하옵소서.\n'
        '\n'
        '3) 하나님의 뜻이 하늘에서 이루어진 것 같이 나를 통하여 이 땅에서 이루어지기를 원합니다.\n'
        '\n'
        '4) 나의 모든 것을 통해서 주님께 감사하는 삶을 살게 하옵소서.\n'
        '나의 영혼을 구원하여 주신 것을 감사드립니다.\n'
        '세상에 좋은 사람들이 많이 있는데 부족하고 천한 죄인을 불러주셔서 하나님을 알게 하시고 죄를 사하여 주시고 구원하여 주셔서 감사합니다.\n'
        '섬길 수 있는 교회를 주심에 감사하며, 마음껏 찬양하고 기도하며 예배드릴 수 있는 환경을 주심에 감사드립니다.\n'
        '함께 신앙생활 할 수 있는 지체들이 있게 하심을 감사하며, 구원받은 것도 감사한데 일꾼 삼아 주시니 더욱 감사합니다.\n'
        '그리고 성도들과 주변의 사람들을 통해 날마다 배우게 하심을 감사드립니다.\n'
        '하루의 양식과 꾸지 않을 만큼의 물질을 주신 것에 감사하고, 자녀들이 건강하게 자라게 하심을 감사드립니다.\n'
        '돕는 배필을 주심에 감사하고 일할 수 있는 직장을 주심에 감사드립니다.\n'
        '육신의 안식처를 주심에 감사하고, 하나님 나라의 소망을 주심을 감사드립니다.\n'
        '나에게 피해를 주었던 사람들을 통해서도 나의 모습을 돌아보고 회개하게 하심을 감사하고, 내가 어디를 가든지 어떤 일을 하든지 주님이 주신 것 이상을 바라지 않게 하심을 감사합니다.\n'
        '시련이나 육신의 아픔 중에 있을 때에라도 감사할 조건들을 찾을 수 있는 사람이 되게 하시고, 늘 감사가 나의 입에서 떠나지 않도록 하옵소서.\n'
        '\n'
        '5) 하나님! 다른 사람의 죄를 용서합니다.\n'
        '나에게 상처를 주고 힘들게 했던 사람을 용서합니다.\n'
        '그를 축복합니다.\n'
        '\n'
        '6) 하나님! 다른 사람의 죄를 용서해 준 것 같이 나의 죄를 용서하여 주옵소서.\n'
        '하나님만이 죄를 사하는 권세가 있는 줄 믿습니다.\n'
        '\n'
        '7) 하나님! 내가 시험에 들지 않기를 원합니다.\n'
        '하나님의 선하신 뜻을 헤아리지 못하고 한순간의 불평, 불만의 내뱉음으로 인해 내 앞의 축복을 쏟아버리게 하는 사탄의 시험에 들지 않게 하옵소서.\n'
        '\n'
        '8) 하나님! 나를 악에서 구원하여 주옵소서.\n'
        '나의 마음속에 있는 불평, 불만의 악에서 구원하셔서 감사하는 마음으로 넘치게 하옵소서.\n'
        '또한 세상의 수많은 악에 물들지 않도록 지켜 주옵소서.\n'
        '\n'
        '9) 하나님의 나라와 권세와 영광이 영원히 하나님 아버지께 있사오며,\n'
        '\n'
        '10) 예수님의 이름으로 기도드립니다. 아멘\n\n\n'));

    textSpanList.add(TextSpan(text: '20. 몸이 아플 때 드리는 기도\n\n', style: TextStyle(fontSize: 30)));
    textSpanList.add(TextSpan(text : '1) 하나님은 거룩하신 분이십니다.\n'
        '하나님 아버지의 이름이 나를 통하여 거룩히 여김 받으시기를 원합니다.\n'
        '\n'
        '2) 하나님의 나라가 나에게 이루어지기를 원합니다.\n'
        '나의 심령에 의와 평강과 희락이 항상 있게 하옵소서.\n'
        '\n'
        '3) 하나님의 뜻이 하늘에서 이루어진 것 같이 나를 통하여 이 땅에서 이루어지기를 원합니다.\n'
        '\n'
        '4) 생명을 주신 하나님, 주님이 주신 몸을 잘 관리하지 못함으로 인해 고통받고 있습니다.\n'
        '죄로 인해 건강을 해친 것이 아닌지 깨닫게 하여 주시고, 죄로 인한 것이라면 회개하오니 용서하여 주옵소서.\n'
        '그리고 나의 질병을 치료하여 주옵소서.\n'
        '사탄이 틈타서 질병이 생긴 것이라면 깨닫게 하시며 주님께서 말씀으로 물리쳐 주셔서 건강하게 하옵소서.\n'
        '그리고 나도 기도로 이기게 하옵소서.\n'
        '불순종으로 질병이 생겼으면 나로 깨닫게 하시며 회개하고 순종하게 하옵소서.\n'
        '하나님이 주신 육체의 관리를 잘못하여 질병이 생겼으면 깨닫게 하시고 치료하여 주옵소서.\n'
        '하나님은 치료의 하나님이심을 믿습니다.\n'
        '하나님은 문둥병자를 치료하시고 죽은 자를 살리시는 치료의 하나님이심을 믿습니다.\n'
        '이 시간에 나의 병을 깨끗하게 하실 수 있나이다.\n'
        '깨끗하게 치료하여 주옵소서.\n'
        '\n'
        '믿습니다! 믿습니다! 믿습니다! 아멘!\n'
        '나의 육신의 연약함으로 내 주변의 식구들을 너무 오랫동안 힘들게 하지 않도록 인도하여 주옵소서.\n'
        '내가 질병으로 짜증이나 불만, 불평의 말들을 하지 않도록 하옵소서.\n'
        '또한 육신의 연약함이 영적인 침체를 가져오지 않게 하옵소서.\n'
        '이제 이후로는 부지런히 일하며 영, 육간의 균형을 지혜롭게 관리하게 하셔서 질병으로부터 자유할 수 있도록 지켜 주옵소서.\n'
        '모든 연약한 자를 치유하신 주님의 사랑의 손길이 나에게도 임하시길 기도합니다.\n'
        '치유 받은 후로는 열심히 전도하며 하나님의 증인이 되겠습니다.\n'
        '\n'
        '5) 하나님! 다른 사람의 죄를 용서합니다.\n'
        '나에게 상처를 주고 힘들게 했던 사람을 용서합니다.\n'
        '예수님의 이름으로 용서합니다.\n'
        '그리고 그를 축복합니다.\n'
        '그가 하나님을 경외하고 복 받기를 원합니다.\n'
        '\n'
        '6) 하나님! 다른 사람의 죄를 용서해 준 것 같이 나의 죄를 사하여 주옵소서.\n'
        '하나님만이 죄를 사하는 권세가 있는 줄 믿습니다.\n'
        '\n'
        '7) 하나님! 내가 시험에 들지 않도록 사탄으로부터 지켜 주시기를 원합니다.\n'
        '육신의 연약함을 이용해 사탄이 틈타지 못하도록 지켜 주옵소서.\n'
        '\n'
        '8) 하나님! 나의 마음속에 있는 여러 가지 악에서 구원하셔서 선한 마음으로 인도해 주옵소서.\n'
        '또한 세상의 악에 물들지 않도록 지켜주옵소서.\n'
        '나는 연약하오니 하나님께서 악을 이길 수 있는 힘을 공급하여 주옵소서.\n'
        '악에 빠지지 않게 하옵소서.\n'
        '\n'
        '9) 하나님의 나라와 권세와 영광이 영원히 하나님 아버지께 있사오며,\n'
        '\n'
        '10) 예수님의 이름으로 기도드립니다. 아멘\n\n\n'));

    textSpanList.add(TextSpan(text: '21. 부부간에 불화가 있을 때 드리는 기도\n\n', style: TextStyle(fontSize: 30)));
    textSpanList.add(TextSpan(text : '1) 하나님은 거룩하신 분이십니다.\n'
        '하나님 아버지의 이름이 나를 통하여 거룩히 여김 받으시기를 원합니다.\n'
        '또한 나의 '+param21+ext1+' 통하여 거룩히 여김 받으시기를 원합니다.\n'
        '\n'
        '2) 하나님의 나라가 지금 이시간에 나에게 이루어지기를 원합니다.\n'
        '나와 '+param21+'의 심령에 의와 평강과 희락이 항상 있게 하옵소서.\n'
        '\n'
        '3) 하나님의 뜻이 하늘에서 이루어진 것 같이 나와 '+param21+ext1+' 통하여 이땅에 이루어지기를 원합니다.\n'
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
        '5) 하나님! '+param21+'의 죄를 용서합니다.\n'
        '나에게 상처를 주고 힘들게 했던 '+param21+ext1+' 용서합니다.\n'
        '예수님의 이름으로 용서합니다.\n'
        +param21+ext2+' 하나님의 뜻을 이루는 자가 되도록 축복하여 주옵소서.\n'
        '하나님이 나를 온전히 말없이 용서하여 주시는 것처럼 나도 용서하게 하옵소서.\n'
        '\n'
        '6) 하나님! '+param21+'의 죄를 용서해 주었으니 나의 죄를 용서하여 주옵소서.\n'
        '하나님만이 죄를 사하는 권세가 있는 줄 믿습니다.\n'
        '\n'
        '7) 하나님! 내가 '+param21+ext3+' 인해 시험에 들지 않기를 원합니다.\n'
        '우리 부부를 사탄의 시험에 버려두지 마옵소서.\n'
        '\n'
        '8) 하나님! 우리 부부를 악에서 구원하여 주옵소서.\n'
        '우리의 마음속에 있는 여러가지 악에서 구원하셔서 선한 마음으로 인도해 주옵소서.\n'
        '또한 세상의 악에 물들지 않도록 지켜주옵소서.\n'
        '\n'
        '9) 하나님의 나라와 권세와 영광이 영원히 하나님 아버지께 있사오며,\n'
        '\n'
        '10) 예수님의 이름으로 기도드립니다. 아멘\n\n\n'));

    textSpanList.add(TextSpan(text: '22. 물질적인 어려움에 있을 때 드리는 기도\n\n', style: TextStyle(fontSize: 30)));
    textSpanList.add(TextSpan(text: '1) 하나님은 거룩하신 분이십니다.\n'
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
        '10) 예수님의 이름으로 기도드립니다. 아멘\n\n\n'));

    textSpanList.add(TextSpan(text: '23. 사업을 위한 기도\n\n', style: TextStyle(fontSize: 30)));
    textSpanList.add(TextSpan(text: '1) 하나님은 거룩하신 분이십니다.\n'
        '하나님 아버지의 이름이 우리 사업장을 통하여 거룩히 여김 받으시기를 원합니다.\n'
        '그러므로 우리 사업장이 하나님의 이름을 거룩히 할 일만 행하게 하옵소서.\n'
        '\n'
        '2) 하나님의 나라가 우리 사업장에 이루어지기를 원합니다.\n'
        '그리하여 우리 사업장에 의와 평강과 희락이 항상 있게 하옵소서.\n'
        '우리 사업장이 하나님의 통치를 받으며 하나님 나라의 법을 지키게 하옵시고, 하나님 나라의 영광을 위하여 일하게 하옵소서.\n'
        '그리고 우리 사업장을 통하여 하나님의 나라가 세상 모든 사람들에게 전파되기를 원합니다.\n'
        '\n'
        '3) 하나님의 뜻이 하늘에서 이루어진 것 같이 땅에서 우리 사업장에 이루어지기를 원합니다.\n'
        '또 우리 사업장을 통하여 하나님의 선하신 뜻이 이루어지기를 기도합니다.\n'
        '하나님의 뜻이 우리 사업장을 통하여 온 땅에 전파되기를 원합니다.\n'
        '\n'
        '4) 하나님께서 우리 사업장에 평생 동안 일할 수 있도록 모든 것을 공급해 주시기를 원합니다.\n'
        '우리 사업장에 현재 필요한 것들이 많이 있습니다.\n'
        '우수한 인재들과 자금을 공급하여 주옵소서.\n'
        '그리하여 하나님 나라를 확장하는 데 물질로 공헌하게 하옵소서.\n'
        '나를 위한 사업이 아니라 하나님을 위한 사업이 되도록 하겠습니다.\n'
        '이 사업장을 통하여 하나님이 큰일을 행하시고, 여기서 얻어지는 이익을 하나님의 나라를 확장하고 하나님의 교회를 세우며 전도와 선교하는 데 사용하게 하옵소서.\n'
        '모든 것이 주께로부터 왔사오니 하나님이 영광을 받으시옵소서.\n'
        '이 사업장을 통하여 교회에 유익이 되고 복음 전파의 큰일을 감당하게 하옵소서.\n'
        '하나님은 주인이시고 나는 청지기일 뿐입니다.\n'
        '그리고 우리 사업장에 있는 사람들이 모두 하나님을 믿고 구원받기를 원합니다.\n'
        '그들이 각각 섬기는 교회에서 일꾼들이 되기를 원합니다.\n'
        '이 사업장이 성장하면서 많은 사람들을 구원시키는 장소가 되게 하옵소서.\n'
        '\n'
        '5) 하나님! 다른 사람의 죄를 용서합니다.\n'
        '우리 사업장에 상처를 주고 힘들게 하였던 사람들을 용서합니다.\n'
        '예수님의 이름으로 용서합니다.\n'
        '그리고 그들을 축복합니다.\n'
        '그들이 하나님을 경외하고 복 받기를 원합니다.\n'
        '\n'
        '6) 하나님! 다른 사람의 죄를 용서해 준 것 같이 우리 사업장의 죄를 사하여 주옵소서.\n'
        '하나님만이 죄를 사하는 권세가 있는 줄 믿습니다.\n'
        '\n'
        '7) 하나님! 우리 사업장이 시험에 들지 않기를 원합니다.\n'
        '마귀에게 시험당하지 않기를 원합니다.\n'
        '그러므로 마귀에게 시험을 허락지 마옵소서.\n'
        '또 세상에 시험당하지 않기를 원합니다.\n'
        '사업하면서 신앙생활에 지장이 없기를 원합니다.\n'
        '언제나 신앙생활이 먼저 되게 하옵소서.\n'
        '기도가 먼저 되게 하옵소서.\n'
        '맡겨진 사역이 먼저 되게 하옵소서.\n'
        '하나님 중심, 교회 중심, 가정 중심 순으로 살아가게 하옵소서.\n'
        '사업의 욕심 때문에 시험 드는 일이 없기를 원합니다.\n'
        '사업을 하는 데 있어 어리석은 생각이나 미련함이 없기를 원합니다.\n'
        '사업장에서 사고나 불행한 일이 생기지 않기를 원합니다.\n'
        '우리 사업장에서 시험이 없기를 기도합니다.\n'
        '\n'
        '8) 하나님! 우리 사업장을 악에서 구원하여 주옵소서.\n'
        '우리 사업장에 하나님의 법을 지키지 않는 악이 들어오지 못하게 하옵소서.\n'
        '그리하여 하나님의 법을 지키는 선한 사업장이 되게 하옵소서.\n'
        '우리 사업장이 세상의 악에 물들지 않도록 지켜 주옵소서.\n'
        '악은 모양이라도 보지 않게 하옵소서.\n'
        '우리 사업장은 연약하오니 하나님께서 악을 이길 수 있는 힘을 공급하여 주옵소서.\n'
        '\n'
        '9) 하나님의 나라와 권세와 영광이 영원히 하나님 아버지께 있사오며,\n'
        '\n'
        '10) 예수님의 이름으로 기도드립니다. 아멘.\n\n\n'));

    textSpanList.add(TextSpan(text: '24. 하루를 시작하며 드리는 기도\n\n', style: TextStyle(fontSize: 30)));
    textSpanList.add(TextSpan(text: '1) 하나님은 거룩하신 분이십니다.\n'
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

        '아멘.\n\n\n'));

    textSpanList.add(TextSpan(text: '25. 하루를 마감하며 드리는 기도\n\n', style: TextStyle(fontSize: 30)));
    textSpanList.add(TextSpan(text: '1) 하나님은 거룩하신 분이십니다.\n'
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
        '10) 예수님의 이름으로 기도드립니다. 아멘\n\n\n'));

    textSpanList.add(TextSpan(text: '26. 마귀를 물리치는 기도\n\n', style: TextStyle(fontSize: 30)));
    textSpanList.add(TextSpan(text: '1) 하나님은 거룩하신 분이십니다.\n'));
    textSpanList.add(TextSpan(text: '내가 하나님의 이름을 거룩하게 할 일만 하게 하옵소서.\n'));
    textSpanList.add(TextSpan(text: '내가 하는 일로 하나님의 이름이 사람들에게서 거룩하게 되기를 원합니다.\n'));
    textSpanList.add(TextSpan(text: '\n'));
    textSpanList.add(TextSpan(text: '2) 하나님 나라를 창조하시고 믿음을 보시고 은혜로 주심을 감사드립니다.\n'));
    textSpanList.add(TextSpan(text: '나의 영혼이 믿음을 인정받고 하나님 나라를 선물로 받게 하옵소서.\n'));
    textSpanList.add(TextSpan(text: '그리고 하나님께서 나를 통치하여 주옵소서.\n'));
    textSpanList.add(TextSpan(text: '\n'));
    textSpanList.add(TextSpan(text: '3) 하나님의 뜻이 하늘에서 이루어진 것 같이 나를 통하여 이 땅에서 이루어지기를 원합니다.\n'));
    textSpanList.add(TextSpan(text: '\n'));
    textSpanList.add(TextSpan(text: '4) 날마다 일용할 양식을 주심을 감사드립니다.\n'));
    textSpanList.add(TextSpan(text: '계속하여 양식과 필요한 것들을 공급하여 주옵소서.\n'));
    textSpanList.add(TextSpan(text: '\n'));
    textSpanList.add(TextSpan(text: '5) 하나님! '));
    textSpanList.add(TextSpan(text: target26, style: TextStyle(color: Colors.blue) )); //, recognizer: TapGestureRecognizer()..onTapDown = (p) => {Navigator.pushNamed(context, '/conf/devil')} ));
    textSpanList.add(TextSpan(text: '의 '));
    textSpanList.add(TextSpan(text: accident26, style: TextStyle(color: Colors.blue) )); //, recognizer: TapGestureRecognizer()..onTapDown = (p) => {Navigator.pushNamed(context, '/conf/devil')} ));
    textSpanList.add(TextSpan(text: '를 용서합니다.\n'));
    textSpanList.add(TextSpan(text: '예수님의 말씀에 순종하여 무조건 용서합니다.\n'));
    textSpanList.add(TextSpan(text: '그리고 그를 축복합니다.\n'));
    textSpanList.add(TextSpan(text: '그가 하나님을 경외하고 복 받기를 원합니다.\n'));
    textSpanList.add(TextSpan(text: '\n'));
    textSpanList.add(TextSpan(text: '6) 하나님! 다른 사람의 죄를 용서해 준 것 같이 나의 죄를 사하여 주옵소서.\n'));
    textSpanList.add(TextSpan(text: '나 또한 다른 사람에게 아무렇지 않게 상처 주는 일들을 하였음을 고백합니다.\n'));
    textSpanList.add(TextSpan(text: '용서하여 주옵소서.\n'));
    textSpanList.add(TextSpan(text: '예수님의 십자가의 보혈로 씻어 주옵소서.\n'));
    textSpanList.add(TextSpan(text: '하나님만이 죄를 사하는 권세가 있는 줄 믿습니다.\n'));
    textSpanList.add(TextSpan(text: '하나님! 마귀와 악령과 귀신을 물리쳐 주옵소서.\n'));
    textSpanList.add(TextSpan(text: '하나님! 나에게 전신갑주를 입혀 주옵소서.\n'));
    textSpanList.add(TextSpan(text: '(약 4:7) "그런즉 너희는 하나님께 복종할지어다. 마귀를 대적하라. 그리하면 너희를 피하리라."라고 말씀하셨습니다.\n'));
    textSpanList.add(TextSpan(text: '이 말씀을 믿고 기도합니다.\n'));
    textSpanList.add(TextSpan(text: '\n'));
    textSpanList.add(TextSpan(text: '<명령하십시오.>\n'));
    textSpanList.add(TextSpan(text: '\'마귀와 악령과 귀신은 내 몸속에서 나가라! 나는 하나님을 믿는다. 더러운 귀신아! 내 몸속에서 나가라!\' (반복)\n'));
    textSpanList.add(TextSpan(text: '\'나는 이제부터 하나님의 자녀요, 백성이다. 그러니 내 몸속에서 나가라!\' (반복)\n'));
    textSpanList.add(TextSpan(text: '\'하나님께서 마귀를 물리치라고 하셨느니라. 그러니 내 몸에서 나가라! 예수 그리스도 이름으로 명령하노니 당장에 나가라!\' (반복)\n'));
    textSpanList.add(TextSpan(text: '\'예수 그리스도께서 말씀하셨느니라. (막 16:17) "믿는 자들에게는 이런 표적이 따르리니 곧 그들이 내 이름으로 귀신을 쫓아내며"라고 하셨느니라. 그러니 귀신아, 내 몸에서 나가라!\' (반복)\n'));
    textSpanList.add(TextSpan(text: '\n'));
    textSpanList.add(TextSpan(text: '7) 하나님! 내가 마귀에게서 시험에 들지 않도록 인도하여 주옵소서.\n'));
    textSpanList.add(TextSpan(text: '\n'));
    textSpanList.add(TextSpan(text: '8) 하나님! 마귀가 주는 여러 가지 악에서 구원해 주옵소서.\n'));
    textSpanList.add(TextSpan(text: '마음을 정결케 하시고 꿈에서라도 악에 빠지지 않게 하옵소서.\n'));
    textSpanList.add(TextSpan(text: '\n'));
    textSpanList.add(TextSpan(text: '9) 하나님의 나라와 권세와 영광이 영원히 하나님 아버지께 있사오며,\n'));
    textSpanList.add(TextSpan(text: ' \n'));
    textSpanList.add(TextSpan(text: '10) 예수님의 이름으로 기도드립니다.\n'));
    textSpanList.add(TextSpan(text: '\n'));
    textSpanList.add(TextSpan(text: '아멘.\n\n\n'));

    textSpanList.add(TextSpan(text: '27. 질병을 치료하는 기도\n\n', style: TextStyle(fontSize: 30)));
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
    textSpanList.add(TextSpan(text: '아멘.\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n'));

    return textSpanList;
  }

  Future<bool> _saveInitPos(double pos) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.setDouble('initPos', pos);
  }
}