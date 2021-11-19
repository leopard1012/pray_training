import 'package:flutter/material.dart';
import 'package:pray_training/pray_list.dart';

class PrayForWife extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final Object? args = ModalRoute.of(context)!.settings.arguments;

    final String prayContent =
        '1) 하나님 아버지는 거룩하신 분입니다.\n'
        '하나님 아버지의 이름이 아내('+'아내이름'+')을 통하여 거룩히 여김 받으시기를 원합니다.\n'
    '그리고 아내가 하나님의 이름을 거룩히 여기는 일을 찾아서 하기를 원합니다.\n'
    '\n'
    '2) 하나님의 나라가 아내에게 이루어지기를 원합니다.\n'
    '그리하여 어려움 중에도 아내의 심령에 의와 평강과 희락이 항상 있어 마음의 천국이 이루어지게 하옵소서.\n'
    '늘 하나님이 주시는 은혜로 살아가게 하옵소서.\n'
    '그리고 아내가 하나님의 통치를 받으며 하나님 나라의 법을 지키며 살게 하옵시고, 하나님 나라의 영광을 위하여 일하게 하옵소서.\n'
    '그리고 아내를 통하여 하나님의 나라가 세상 모든 사람들에게 전파되기를 원합니다.\n'
    '\n'
    '3) 하나님의 뜻이 하늘에서 이루어진 것 같이 땅에서 아내에게 이루어지기를 원합니다.\n'
    '또 아내가 하나님의 뜻을 깨닫고 이루어드리기를 기도합니다.\n'
    '하나님의 뜻이 아내를 통하여 온 땅에 전파되기를 원합니다.\n'
    '\n'
    '4) 하나님게서 아내에게 평생 동안 일용할 양식을 공급해 주시기를 원합니다.\n'
    '또 세상에 살아가는데 필요한 것을 공급하여 주시기를 원합니다.\n'
    '아내가 하는 일들을 축복하여 주옵소서.\n'
    '그리고 큰 믿음과 건강을 주옵시며, 항상 하나님을 기쁘게 하는 사람이 되게 하옵소서.\n'
    '또 아내의 기도를 들어 주옵소서.\n'
    '\n'
    '중보기도\n'
    '아내에게 풍성한 물질을 주셔서 하나님을 위하여 언제나 마음껏 드리게 하옵시며, 모법적으로 충성하고 헌신하는 사람이 되게 하옵소서.\n'
    '목사님께 순종하며 섬기는 믿음을 주옵시고, 성도를 사랑하며 겸손히 섬기는 신앙을 주옵소서.\n'
    '가정에 충실하고 믿음의 사람이 되어 가정을 신앙으로 이끌게 하옵소서.\n'
    '남편과 자녀에게 현모양처가 되게 하옵소서.\n'
    '세상에서 믿음으로 살고 존경과 신뢰를 얻는 사람이 되게 하옵소서.\n'
    '지혜와 명철을 주옵시고, 사랑과 온유와 오래 참음의 은사들을 공급하여 주옵소서.\n'
    '또 풍성하여 이웃들에게 나누어 주며 살게 하옵소서.\n'
    '또한 아내의 주변 사람들이 모두 구원받기를 원합니다.\n'
    '그들을 구원하시어 하나님의 일꾼으로 사용하여 주옵소서.\n'
    '\n'
    '5) 하나님! 아내의 죄를 용서합니다.\n'
    '나에게 상처를 주고 힘들게 했던 아내를 용서합니다.\n'
    '예수님의 이름으로 용서합니다.\n'
    '그리고 아내를 축복합니다.\n'
    '아내가 하나님을 경외하고 복 받기를 원합니다.\n'
    '\n'
    '6) 하나님! 다른 사람의 죄를 용서해 준 것 같이 나의 죄를 사하여 주옵소서.\n'
    '나도 하나님 앞에 죄인입니다.\n'
    '하나님만이 죄를 사하는 권세가 있는 줄 믿습니다.\n'
    '\n'
    '7) 하나님! 아내가 시험에 들지 않기를 원합니다.\n'
    '마귀에게 시험을 허락지 마옵소서.\n'
    '또 아내가 나에게 시험당하지 않기를 원합니다.\n'
    '세상에 시험당하지 않기를 원합니다.\n'
    '물질이나 명예로 시험당하지 않기를 원합니다.\n'
    '사람들로 인해 시험 들지 않기를 원합니다.\n'
    '신앙생활에서 시험이 들지 않기를 원합니다.\n'
    '교회 생활과 교인들로 인하여 시험 들지 않기를 원합니다.\n'
    '가정에서 시험에 들지 않기를 원합니다.\n'
    '아내가 시험에 들지 않도록 지켜 주옵소서.\n'
    '\n'
    '8) 하나님! 아내를 악에서 구원하여 주옵소서.\n'
    '아내의 마음속에는 악이 가득합니다.\n'
    '악을 주는 사탄의 세력을 쫓아 주옵소서.\n'
    '그리고 악에서 아내를 구원하여 선한 마음으로 인도하여 주옵소서.\n'
    '아내가 세상의 악에 물들지 않도록 지켜 주옵소서.\n'
    '아내는 연약하오니 하나님께서 악을 물리치고 이길 수 있는 힘을 공급하여 주옵소서.\n'
    '\n'
    '9) 하나님의 나라와 권세와 영광이 영원히, 영원히 하나님 아버지께 있사오며,\n'
    '\n'
    '1) 예수님의 이름으로 기도드립니다. 아멘.';

    return Scaffold(
      appBar: AppBar(
        title: Text('09. 아내를 위한 기도'),
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