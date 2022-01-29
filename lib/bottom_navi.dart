import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class BottomNavi extends StatelessWidget {
  // SharedPreferences pref = SharedPreferences.getInstance() as SharedPreferences;
  final _prayCodeList = ['',
    'homeland','church','pastor','cell','believer','person','home','husband','wife',
    'parents','children','personal_1','personal_2','repentance','spiritual_power','temptations','tarry','tired',
    'thanks','healing','spouse','money','business','dawn','night','devil','disease'
  ];

  int _index = 0;

  BottomNavi(int i) {
    _index = i;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.grey,
      selectedItemColor: Colors.black,
      unselectedItemColor: Colors.black,
      onTap: (int index) {
        int targetIdx = 0;
        bool goMain = false;
        switch (index) {
          case 0:
            targetIdx = _index-1;
            break;
          case 1:
            goMain = true;
            Navigator.pushReplacementNamed(context, '/', arguments: 'MainPage');
            break;
          case 2:
            targetIdx = _index+1;
            break;
        }

        if (!goMain && (targetIdx <= 0 || targetIdx >= 28)) {
          Fluttertoast.showToast(msg: '더이상 이동할 수 없습니다.');
        } else if (!goMain) {
          Navigator.pushReplacementNamed(context, '/' + _prayCodeList[targetIdx]);
        }
      },
      items: const [
        BottomNavigationBarItem(
            title: Text('PREV'),
            icon: Icon(Icons.arrow_back_ios),
        ),
        BottomNavigationBarItem(
            title: Text('MAIN'),
            icon: Icon(Icons.home)
        ),
        BottomNavigationBarItem(
            title: Text('NEXT'),
            icon: Icon(Icons.arrow_forward_ios)
        )
      ],
    );
  }
}