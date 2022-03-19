import 'package:flutter/material.dart';

class PrayList extends StatelessWidget {
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
              // Navigator.of(context).pushNamed(context, '/nation', arguments: '나라를 위한 기도');
              // Navigator.pushReplacementNamed(context, '/nation', arguments: '나라를 위한 기도');
              Navigator.pushReplacementNamed(context, '/homeland', arguments: '나라를 위한 기도');
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
          ListTile(
            leading: Icon(
              Icons.border_color,
              color: Colors.grey[850],
            ),
            title: Text('03. 담임목사님을 위한 기도'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/pastor');
            },
            trailing: Icon(Icons.arrow_forward_ios),
          ),
          ListTile(
            leading: Icon(
              Icons.border_color,
              color: Colors.grey[850],
            ),
            title: Text('04. 목장과 목장원을 위한 기도'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/cell');
            },
            trailing: Icon(Icons.arrow_forward_ios),
          ),
          ListTile(
            leading: Icon(
              Icons.border_color,
              color: Colors.grey[850],
            ),
            title: Text('05. 태신자를 위한 기도'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/believer');
            },
            trailing: Icon(Icons.arrow_forward_ios),
          ),
          ListTile(
            leading: Icon(
              Icons.border_color,
              color: Colors.grey[850],
            ),
            title: Text('06. 사람을 위한 기도'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/person');
            },
            trailing: Icon(Icons.arrow_forward_ios),
          ),
          ListTile(
            leading: Icon(
              Icons.border_color,
              color: Colors.grey[850],
            ),
            title: Text('07. 가정을 위한 기도'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/home');
            },
            trailing: Icon(Icons.arrow_forward_ios),
          ),
          ListTile(
            leading: Icon(
              Icons.border_color,
              color: Colors.grey[850],
            ),
            title: Text('08. 남편을 위한 기도'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/husband');
            },
            trailing: Icon(Icons.arrow_forward_ios),
          ),
          ListTile(
            leading: Icon(
              Icons.border_color,
              color: Colors.grey[850],
            ),
            title: Text('09. 아내를 위한 기도'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/wife');
            },
            trailing: Icon(Icons.arrow_forward_ios),
          ),
          ListTile(
            leading: Icon(
              Icons.border_color,
              color: Colors.grey[850],
            ),
            title: Text('10. 부모님을 위한 기도'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/parents');
            },
            trailing: Icon(Icons.arrow_forward_ios),
          ),
          ListTile(
            leading: Icon(
              Icons.border_color,
              color: Colors.grey[850],
            ),
            title: Text('11. 자녀를 위한 기도'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/children');
            },
            trailing: Icon(Icons.arrow_forward_ios),
          ),
          ListTile(
            leading: Icon(
              Icons.border_color,
              color: Colors.grey[850],
            ),
            title: Text('12. 개인기도1'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/personal_1');
            },
            trailing: Icon(Icons.arrow_forward_ios),
          ),
          ListTile(
            leading: Icon(
              Icons.border_color,
              color: Colors.grey[850],
            ),
            title: Text('13. 개인기도2'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/personal_2');
            },
            trailing: Icon(Icons.arrow_forward_ios),
          ),
          ListTile(
            leading: Icon(
              Icons.border_color,
              color: Colors.grey[850],
            ),
            title: Text('14. 회개기도'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/repentance');
            },
            trailing: Icon(Icons.arrow_forward_ios),
          ),
          ListTile(
            leading: Icon(
              Icons.border_color,
              color: Colors.grey[850],
            ),
            title: Text('15. 영적인 힘을 얻기 위한 기도'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/spiritual_power');
            },
            trailing: Icon(Icons.arrow_forward_ios),
          ),
          ListTile(
            leading: Icon(
              Icons.border_color,
              color: Colors.grey[850],
            ),
            title: Text('16. 시험이 있을 때 드리는 기도'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/temptations');
            },
            trailing: Icon(Icons.arrow_forward_ios),
          ),
          ListTile(
            leading: Icon(
              Icons.border_color,
              color: Colors.grey[850],
            ),
            title: Text('17. 기도가 잘 되지 않을 때 드리는 기도'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/tarry');
            },
            trailing: Icon(Icons.arrow_forward_ios),
          ),
          ListTile(
            leading: Icon(
              Icons.border_color,
              color: Colors.grey[850],
            ),
            title: Text('18. 삶에 지칠 때 드리는 기도'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/tired');
            },
            trailing: Icon(Icons.arrow_forward_ios),
          ),
          ListTile(
            leading: Icon(
              Icons.border_color,
              color: Colors.grey[850],
            ),
            title: Text('19. 감사할 때 드리는 기도'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/thanks');
            },
            trailing: Icon(Icons.arrow_forward_ios),
          ),
          ListTile(
            leading: Icon(
              Icons.border_color,
              color: Colors.grey[850],
            ),
            title: Text('20. 몸이 아플 때 드리는 기도'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/healing');
            },
            trailing: Icon(Icons.arrow_forward_ios),
          ),
          ListTile(
            leading: Icon(
              Icons.border_color,
              color: Colors.grey[850],
            ),
            title: Text('21. 부부간에 불화가 있을 때 드리는 기도'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/spouse' ,arguments: '아내');//pref.get('/spouse'));
            },
            trailing: Icon(Icons.arrow_forward_ios),
          ),
          ListTile(
            leading: Icon(
              Icons.border_color,
              color: Colors.grey[850],
            ),
            title: Text('22. 물질적인 어려움에 있을 때 드리는 기도'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/money');
            },
            trailing: Icon(Icons.arrow_forward_ios),
          ),
          ListTile(
            leading: Icon(
              Icons.border_color,
              color: Colors.grey[850],
            ),
            title: Text('23. 사업을 위한 기도'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/business');
            },
            trailing: Icon(Icons.arrow_forward_ios),
          ),
          ListTile(
            leading: Icon(
              Icons.border_color,
              color: Colors.grey[850],
            ),
            title: Text('24. 하루를 시작하며 드리는 기도'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/dawn');
            },
            trailing: Icon(Icons.arrow_forward_ios),
          ),
          ListTile(
            leading: Icon(
              Icons.border_color,
              color: Colors.grey[850],
            ),
            title: Text('25. 하루를 마감하며 드리는 기도'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/night');
            },
            trailing: Icon(Icons.arrow_forward_ios),
          ),
          ListTile(
            leading: Icon(
              Icons.border_color,
              color: Colors.grey[850],
            ),
            title: Text('26. 마귀를 물리치는 기도'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/devil');
            },
            trailing: Icon(Icons.arrow_forward_ios),
          ),
          ListTile(
            leading: Icon(
              Icons.border_color,
              color: Colors.grey[850],
            ),
            title: Text('27. 질병을 치료하는 기도'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/disease');
            },
            trailing: Icon(Icons.arrow_forward_ios),
          ),
        ],
      ),
    );
  }
}