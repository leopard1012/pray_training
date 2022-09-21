import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PrayBody extends StatefulWidget {
  List<String> winList;
  String pray;
  Future<List<TextSpan>> prayContents;
  Function callback;

  PrayBody(this.winList, this.pray, this.prayContents, this.callback);

  @override
  State<StatefulWidget> createState() => _PrayBody();
}

class _PrayBody extends State<PrayBody> {
  List<String> winList = [];
  String pray = '';
  int counter = 0;
  bool isSwitched = false;
  late Future<List<TextSpan>> prayContents;
  List<String> confList = ['believer','cell','children','church','devil','disease','home','husband','parents','pastor','person','personal_1','personal_2','repentance','spouse','wife'];

  final _inputTextController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    winList = widget.winList;
    pray = widget.pray;
    prayContents = widget.prayContents;
    isSwitched = winList.contains(pray) ? true : false;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _inputTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
        children: <Widget>[
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(8.0),
            scrollDirection: Axis.vertical,
            child: FutureBuilder(
              future: prayContents,
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
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _inputButton(confList.contains(pray)),
            Padding(
            padding: EdgeInsets.fromLTRB(20, 0, 10, 0),
              child: FlutterSwitch(
                value: isSwitched,
                onToggle: (value) {
                  setState(() {
                    isSwitched = value;
                  });
                  _saveWinList(pray);
                },
                activeColor: Colors.green,
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(30, 0, 10, 0),
                child: SizedBox(
                  width: 30,
                  height: 30,
                  child: FloatingActionButton(
                      child: Icon(Icons.remove),
                      onPressed: () {
                        setState(() {
                          counter = counter - 1;
                          counter = counter < 0 ? 0 : counter;
                          _inputTextController.text = '$counter';
                          _saveWinCounter(pray, counter);
                        });
                      }
                  )
              )
            ),
            SizedBox(
              width: 50,
              child: FutureBuilder(
                  future: _loadWinCounter(pray),
                  builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
                    counter = snapshot.data ?? 0;
                    _inputTextController.text = '${snapshot.data}';
                    return TextField(
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      controller: _inputTextController,
                      onChanged: (text) {
                        _saveWinCounter(pray, int.parse(text));
                      },
                    );
                  }
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(10, 0, 30, 0),
              child: SizedBox(
                  width: 30,
                  height: 30,
                  child: FloatingActionButton(
                      child: Icon(Icons.add),
                      onPressed: () {
                        setState(() {
                          counter = counter + 1;
                          counter = counter < 0 ? 0 : counter;
                          _inputTextController.text = '$counter';
                          _saveWinCounter(pray, counter);
                        });
                      }
                  )
              ),
            ),
          ],
        )
      ]
    );
  }

  Widget _inputButton(bool contains) {
    if (contains) {
      return Padding(
          padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
          child: OutlinedButton(
            // backgroundColor: Colors.grey,
            style: OutlinedButton.styleFrom(side: BorderSide(color:Colors.blue)),
            child: Text("기도\n입력", style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),),
            onPressed: () {
              if (confList.contains(pray)) {
                Navigator.pushNamed(context, '/conf/' + pray);
              }
            },
          )
      );
    } else {
      return Padding(
        padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
      );
    }
  }

  _saveWinList(String pray) async {
    final prefs = await SharedPreferences.getInstance();
    const key = 'winList';
    List<String>? value = prefs.getStringList(key) ?? [];
    if (value.contains(pray)) {
      value.remove(pray);
    } else {
      value.add(pray);
    }
    prefs.setStringList(key, value);
    widget.callback(value);
  }

  _saveWinCounter(String pray, int counter) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setInt(pray, counter);
  }

  Future<int> _loadWinCounter(String pray) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var value = pref.getInt(pray) ?? 0;
    return value;
  }
}