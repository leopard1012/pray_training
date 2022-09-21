import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:grouped_list/grouped_list.dart';

import 'main_page.dart';

/*
 데이터 리스트
*/
List _elements = [
  {'index':1, 'name': '인간의 삶', 'url':'https://m.cafe.naver.com/ca-fe/web/cafes/30156311/menus/152', 'group': '1.삶 시리즈'},
  {'index':2, 'name': '새로운 삶', 'url':'https://m.cafe.naver.com/ca-fe/web/cafes/30156311/menus/153', 'group': '1.삶 시리즈'},
  {'index':3, 'name': '제자의 삶', 'url':'https://m.cafe.naver.com/ca-fe/web/cafes/30156311/menus/154', 'group': '1.삶 시리즈'},
  {'index':4, 'name': '축복의 삶', 'url':'https://m.cafe.naver.com/ca-fe/web/cafes/30156311/menus/155', 'group': '1.삶 시리즈'},
  {'index':1, 'name': '새가족 학교', 'url':'https://m.cafe.naver.com/ca-fe/web/cafes/30156311/menus/180', 'group': '2.학교 시리즈'},
  {'index':2, 'name': '기도 학교', 'url':'https://m.cafe.naver.com/ca-fe/web/cafes/30156311/menus/131', 'group': '2.학교 시리즈'},
  {'index':3, 'name': '전인치유 학교', 'url':'https://m.cafe.naver.com/ca-fe/web/cafes/30156311/menus/148', 'group': '2.학교 시리즈'},
  {'index':4, 'name': '성품치유 학교', 'url':'https://m.cafe.naver.com/ca-fe/web/cafes/30156311/menus/157', 'group': '2.학교 시리즈'},
  {'index':5, 'name': '목자예비 학교', 'url':'https://m.cafe.naver.com/ca-fe/web/cafes/30156311/menus/150', 'group': '2.학교 시리즈'},
  {'index':6, 'name': '목자 학교', 'url':'https://m.cafe.naver.com/ca-fe/web/cafes/30156311/menus/156', 'group': '2.학교 시리즈'},
  {'index':7, 'name': '전도 학교', 'url':'https://m.cafe.naver.com/ca-fe/web/cafes/30156311/menus/151', 'group': '2.학교 시리즈'},
  {'index':1, 'name': '교회 생활', 'url':'https://m.cafe.naver.com/ca-fe/web/cafes/30156311/menus/160', 'group': '3.생활 시리즈'},
  {'index':2, 'name': '가정 생활', 'url':'https://m.cafe.naver.com/ca-fe/web/cafes/30156311/menus/161', 'group': '3.생활 시리즈'},
  {'index':3, 'name': '헌신 생활', 'url':'https://m.cafe.naver.com/ca-fe/web/cafes/30156311/menus/162', 'group': '3.생활 시리즈'},
  {'index':4, 'name': '복된 생활', 'url':'https://m.cafe.naver.com/ca-fe/web/cafes/30156311/menus/163', 'group': '3.생활 시리즈'},
  {'index':1, 'name': '기도와 능력', 'url':'https://m.cafe.naver.com/ca-fe/web/cafes/30156311/menus/132', 'group': '4.기도 훈련'},
  {'index':2, 'name': '너희는 이렇게 기도하라', 'url':'https://m.cafe.naver.com/ca-fe/web/cafes/30156311/menus/133', 'group': '4.기도 훈련'},
];

class LinkList extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
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
          title: Text('양육교재'),
          centerTitle: true,
          leading:  IconButton(
              onPressed: (){
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => MainPage(false)), (route) => false
                );
              },
              icon: Icon(Icons.home_filled)),
        ),
        body: groupedList(), //grouped_list 함수
      ),
    );
  }
}

groupedList() {
  //각각의 항목 설명은 아래에 있다.
  return GroupedListView<dynamic, String>(
    elements: _elements, // 리스트에 사용할 데이터 리스트
    groupBy: (element) => element['group'], // 데이터 리스트 중 그룹을 지정할 항목
    groupComparator: (value1, value2) => value1.compareTo(value2), //groupBy 항목을 비교할 비교기
    itemComparator: (item1, item2) =>
        item1['index'].compareTo(item2['index']), // 그룹안의 데이터 비교기
    order: GroupedListOrder.ASC,
    useStickyGroupSeparators: false, //가장 위에 그룹 이름을 고정시킬 것인지
    groupSeparatorBuilder: (String value) => Padding(
      //그룹 타이틀 모양
      padding: const EdgeInsets.all(8.0),
      child: Text(
        value,
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    ),
    itemBuilder: (c, element) {
      var url = element['url'];
      //항목들 모양 처리
      return Card(
        elevation: 8.0,
        margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
        child: Container(
          child: ListTile(
            contentPadding:
            EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            leading: Icon(Icons.book),
            title: Text(element['name']),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {
              launch(url, forceSafariVC: false, forceWebView: false);
            },
          ),
        ),
      );
    },
  );
}