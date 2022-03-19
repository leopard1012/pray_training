import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class LinkList extends StatelessWidget {
  // SharedPreferences pref = SharedPreferences.getInstance() as SharedPreferences;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Drawer(
      child: ListView(
        children: <Widget>[
          ListTile(
            leading: Icon(
              Icons.adjust,
              color: Colors.grey[850],
            ),
            title: Text('01. 나라를 위한 기도'),
            onTap: () {
              // url_link('https://naver.com');
              launch('http://m.naver.com', forceWebView: false , forceSafariVC: true);
            },
            trailing: Icon(Icons.arrow_forward_ios),
          ),
          ListTile(
            leading: Icon(
              Icons.image,
              color: Colors.grey[850],
            ),
            title: Text('02. 교회를 위한 기도'),
            onTap: () {
              // Navigator.of(context).pushReplacementNamed('/church', arguments: '교회를 위한 기도');\
              Navigator.pushReplacementNamed(context, '/church', arguments: '교회를 위한 기도');
            },
            trailing: Icon(Icons.arrow_forward_ios),
          ),
        ],
      ),
    );
  }
}