import 'package:flutter/material.dart';
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
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Switch(
              value: isSwitched,
              onChanged: (value) {
                setState(() {
                  isSwitched = value;
                });
                _saveWinList(pray);
              },
              activeColor: Colors.green,
            ),
            SizedBox(
              width: 50,
              height: 30,
              child: FloatingActionButton.extended(
                label: Text('- 100'),
                onPressed: () {
                  setState(() {
                    counter = counter - 100;
                    counter = counter < 0 ? 0 : counter;
                    _saveWinCounter(pray, counter);
                  });
                }
              )
            ),
            SizedBox(
                width: 40,
                height: 30,
                child: FloatingActionButton.extended(
                    label: Text('- 10'),
                    onPressed: () {
                      setState(() {
                        counter = counter - 10;
                        counter = counter < 0 ? 0 : counter;
                        _saveWinCounter(pray, counter);
                      });
                    }
                )
            ),
            SizedBox(
                width: 30,
                height: 30,
                child: FloatingActionButton.extended(
                    label: Text('- 1'),
                    onPressed: () {
                      setState(() {
                        counter = counter - 1;
                        counter = counter < 0 ? 0 : counter;
                        _saveWinCounter(pray, counter);
                      });
                    }
                )
            ),
            SizedBox(
              width: 60,
              // child: TextField(
              //   keyboardType: TextInputType.number,
              //   controller: _inputTextController,
              //   // onChanged: _saveWinCounter(pray, int.parse(_inputTextController.text)),
              //   onChanged: _saveWinCounter(pray, 1),
              // ),
              child: FutureBuilder(
                  future: _loadWinCounter(pray),
                  builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
                    counter = snapshot.data ?? 0;
                    return Text(
                      '${snapshot.data}',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    );
                    // _inputTextController.text = '${snapshot.data}';
                    // return TextField(
                    //   keyboardType: TextInputType.number,
                    //   controller: _inputTextController,
                    //   onChanged: _saveWinCounter(pray, int.parse(_inputTextController.text)),
                    // );
                  }
              ),
            ),
            SizedBox(
                width: 30,
                height: 30,
                child: FloatingActionButton.extended(
                    label: Text('+ 1'),
                    onPressed: () {
                      setState(() {
                        counter = counter + 1;
                        counter = counter < 0 ? 0 : counter;
                        _saveWinCounter(pray, counter);
                      });
                    }
                )
            ),
            SizedBox(
                width: 40,
                height: 30,
                child: FloatingActionButton.extended(
                    label: Text('+ 10'),
                    onPressed: () {
                      setState(() {
                        counter = counter + 10;
                        counter = counter < 0 ? 0 : counter;
                        _saveWinCounter(pray, counter);
                      });
                    }
                )
            ),
            SizedBox(
                width: 50,
                height: 30,
                child: FloatingActionButton.extended(
                    label: Text('+ 100'),
                    onPressed: () {
                      setState(() {
                        counter = counter + 100;
                        counter = counter < 0 ? 0 : counter;
                        _saveWinCounter(pray, counter);
                      });
                    }
                )
            ),
          ],
        )
      ]
    );
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
    setState(() {
      // if (value == null) {
      //   _inputTextController.text = '0';
      // } else {
      //   _inputTextController.text = value.toString();
      // }
    });
    return value;
  }
}