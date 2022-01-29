import 'package:flutter/material.dart';
import 'package:pray_training/pray_list.dart';
import 'package:pray_training/bottom_navi.dart';

class PrayForHomeland extends StatefulWidget {
  List<Map<String,dynamic>> list;

  PrayForHomeland(this.list);

  @override
  State<StatefulWidget> createState() => _PrayForHomeland();
}

class _PrayForHomeland extends State<PrayForHomeland> {
  late List<Map<String,dynamic>> list;
  int index = -1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    list = widget.list;
    index = getIndex(list, 'homeland');
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('01. 나라를 위한 기도'),
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
        '1) 하나님 아버지는 거룩하십니다.\n'
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
        '하나님! 우리나라가 시험에 들지 않기를 원합니다.\n'
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
        '10) 예수님의 이름으로 기도드립니다. 아멘.';

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