import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'main.dart';

class PrayBody extends StatefulWidget {
  List<String> winList;
  String pray;
  int counter;
  Future<List<TextSpan>> prayContents;
  Function callback;

  PrayBody(this.winList, this.pray, this.counter, this.prayContents, this.callback);

  @override
  State<StatefulWidget> createState() => _PrayBody();
}

class _PrayBody extends State<PrayBody> {
  List<String> winList = [];
  String pray = '';
  int counter = 0;
  late Future<List<TextSpan>> prayContents;

  final _inputTextController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    winList = widget.winList;
    pray = widget.pray;
    counter = widget.counter;
    prayContents = widget.prayContents;

    if (counter > 0) {
      _inputTextController.text = counter.toString();
    } else {
      _inputTextController.text = '0';
    }
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
    // var isSwitched = winList.contains(pray) ? true : false;
    var isSwitched = false;
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
            Switch(
              value: isSwitched,
              onChanged: (value) {
                setState(() {
                  isSwitched = value;
                  // value = !isSwitched;

                });
                // _saveWinList(pray);
              },
              activeColor: Colors.green,
            ),
            FloatingActionButton(
              child: Icon(Icons.remove),
              onPressed: () {
                setState(() {
                  counter--;
                });
              }
            ),
            const SizedBox(
              width: 100,
              child: TextField(
                keyboardType: TextInputType.number,
              ),
            ),
            FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: () {
                setState(() {
                  counter++;
                });
              }
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

}