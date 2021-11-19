import 'package:flutter/material.dart';
import 'package:pray_training/pray_list.dart';

class PrayForPerson extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final Object? args = ModalRoute.of(context)!.settings.arguments;
    
    String param = '';

    final String prayContent =
        '1) 하나님 아버지는 거룩하십니다.\n'
        '하나님 아버지의 이름이 '+param+' 통하여 거룩히 여김 받으시기를 원합니다.\n'
    '그리고 '+param+' 하나님의 이름을 거룩히 여기는 일을 찾아서 하기를 원합니다.\n'
    '\n'
    '2) 하나님의 나라가 '+param+' 이루어지기를 원합니다.'
    '그리하여'+param+' 심령에 의와 평강과 희락이 항상 있어 마음의 천국이 이루어지게 하옵소서.'
    '그리고 '+param+' 하나님의 통치를 받으며 하나님 나라의 법을 소중히 여기고 지키며 살게 하옵시고, 하나님 나라의 영광을 위하여 일하게 하옵소서.'
    '그리고 '+param+' 통하여 하나님 나라가 세상 모든 param들에게 전파되기를 원합니다.'
    ''
    '3) 하나님의 뜻이 하늘에서 이루어진 것 같이 땅에서 '+param+' 이루어지기를 원합니다.'
    '또 '+param+' 하나님의 뜻인 전도와 선과 의를 행하며 이웃에게 피해를 주지 않고 도움이 되는 삶을 살기를 기도합니다.'
    '하나님의 뜻이 '+param+' 통하여 온 땅에 전파되기를 원합니다.'
    ''
    '4) 하나님께서 '+param+' 평생 동안 일용할 양식을 공급해 주시기를 원합니다.'
    '또 세상에서 살아가는데 필요한 것을 공급하여 주시기를 원합니다.'
    ' '+param+' 하는 일들을 축복하여 주옵소서.'
    '그리고 큰 믿음과 건강을 주옵시며, 항상 하나님을 기쁘게 하는 param이 되게 하옵소서.'
    ''
    '중보기도'
    ' '+param+' 풍성한 물질을 주셔서 하나님을 위하여 언제나 즐거운 마음으로 풍성하게 드리게 하옵시며, 모범적으로 충성하고 헌신하는 param이 되게 하옵소서.'
    '목사님에게 순종하며 섬기는 믿음을 주옵시고, 성도를 사랑하며 겸손히 섬기는 신앙을 주옵소서.'
    '가정에 충실하고 믿음의 param이 되어 가정을 신앙으로 이끌게 하옵소서.'
    '예수님의 가르침대로 온유하고 겸손한 param이 되어 param들에게 좋은 본이 되게 하옵소서.'
    '그리고 세상에서 믿음으로 살며 존경과 신뢰를 얻는 param이 되게 하옵소서.'
    '지혜와 명철함을 주옵시고, 사랑과 오래 참음의 은사들을 공급하여 주옵소서.'
    '또 풍성하여 이웃들에게 나누어 주며 살게 하옵소서.'
    '또한 '+param+' 주변 param들이 모두 구원받기를 원합니다.'
    '그들을 구우너하시어 하나님의 일꾼으로 사용하여 주옵소서.'
    ''
    '5) 하나님! 다른 param의 죄를 용서합니다.'
    '나에게 상처를 주고 힘들게 하였던 '+param+' 용서합니다.'
    ' '+param+' 일로 나에게 상처를 주었습니다.'
    '하지만 예수님의 말씀에 순종하여 용서합니다.'
    '그리고 '+param+' 축복합니다.'
    ' '+param+' 하나님을 경외하고 복 받기를 원합니다.'
    ''
    '6) 하나님! 다른 param의 죄를 용서하여 준 것 같이 나의 죄를 사하여 주옵소서.'
    '하나님만이 죄를 사하는 권세가 있는줄 믿습니다.'
    ''
    '7) 하나님! '+param+' 시험에 들지 않기를 원합니다.'
    '마귀에게 시험당하지 않기를 원합니다.'
    '세상에서 시험당하지 않기를 원합니다.'
    '물질이나 명예로 시험당하지 않기를 원합니다.'
    'param들로 인해 시험 들지 않기를 원합니다.'
    '신앙생활에 시험이 들지 않기를 원합니다.'
    '사업장의 생활과 교인들로 인하여 시험 들지 않기를 원합니다.'
    '가정에서 시험에 들지 않기를 원합니다.'
    ' '+param+' 시험에 들지 않도록 지켜 주옵소서.'
    ''
    '8) 하나님! '+param+' 를 악에서 구원하여 주옵소서.'
    '우리에게는 악이 가득합니다.'
    '사탄이 망므속에 악을 넣었습니다.'
    '그래서 불평, 불만, 미움, 시기, 질투, 욕심, 원망, 정죄, 비판, 욕, 저주, 거짓, 불신앙, 불충, 불성실, 불순종, 인색함, 음란, 음행, 간음, 낙심, 슬픔, 우울함, 실망, 자살, 교만, 오만, 거역, 이기심, 나태, 게으름, 무사안일, 혈기, 신경질, 자랑, 더러운 마음, 배신 등의 악이 가득합니다.'
    '이러한 악에서  '+param+' 구원받기를 원합니다.'
    '악을 주는 사탄의 세력을 쫓아 주옵소서.'
    '그리고 악에서  '+param+' 구원하여 교회로 인도하여 주옵소서.'
    ' '+param+' 세상의 악에 물들지 않도록 지켜 주옵소서.'
    ' '+param+' 연약하오니 하나님께서 악을 물리치고 이길 수 있는 힘을 공급하여 주옵소서.'
    ''
    '9) 하나님의 나라와 권세와 영광이 영원히, 영원히 하나님 아버지께 있사오며,'
    ''
    '10) 예수님의 이름으로 기도드립니다. 아멘.';

    return Scaffold(
      appBar: AppBar(
        title: Text('06. param을 위한 기도'),
      ),
      drawer: PrayList(),
      body: Container(
        child: Center(
          child: Text(args.toString()),
        ),
      ),
    );
  }
}