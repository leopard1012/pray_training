import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'main.dart';

class BottomNavi extends StatelessWidget {
  List<Map<String,dynamic>> prayList = [];

  int _index = 0;

  BottomNavi(List<Map<String,dynamic>> list, int i) {
    prayList = list;
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
        int targetIdx = -1;
        bool goMain = false;
        switch (index) {
          case 0:
            targetIdx = _index-1;
            break;
          case 1:
            goMain = true;
            // Navigator.pushReplacementNamed(context, '/', arguments: 'MainPage');
            Navigator.pop(context, true);
            break;
          case 2:
            targetIdx = _index+1;
            break;
        }

        if (!goMain && (targetIdx < 0 || targetIdx >= 27)) {
          Fluttertoast.showToast(msg: '더이상 이동할 수 없습니다.');
        } else if (!goMain) {
          Navigator.pushReplacementNamed(context, '/' + prayList[targetIdx].keys.first);
        }
      },
      items: const [
        BottomNavigationBarItem(
            title: Text('PREV'),
            icon: Icon(Icons.arrow_back_ios),
        ),
        BottomNavigationBarItem(
            title: Text('LIST'),
            icon: Icon(Icons.list_alt)
        ),
        BottomNavigationBarItem(
            title: Text('NEXT'),
            icon: Icon(Icons.arrow_forward_ios)
        )
      ],
    );
  }
}