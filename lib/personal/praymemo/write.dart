import 'package:flutter/material.dart';
import 'package:pray_training/personal/database/memo.dart';
import 'package:pray_training/personal/database/db.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';

import 'list.dart'; // for the utf8.encode method

class WritePage extends StatelessWidget {
  String title = '';
  String text = '';
  late BuildContext _context;
  @override
  Widget build(BuildContext context) {
    _context = context;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.save),
              onPressed: saveDB,
            )
          ],
        ),
        body: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            children: <Widget>[
              TextField(
                maxLines: 1,
                onChanged: (String title) {
                  this.title = title;
                },
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
                //obscureText: true,
                decoration: InputDecoration(
                  //border: OutlineInputBorder(),
                  hintText: '기도문의 제목을 적어주세요.',
                ),
              ),
              Padding(padding: EdgeInsets.all(10)),
              TextField(
                maxLines: 20,
                onChanged: (String text) {
                  this.text = text;
                },
                //obscureText: true,
                decoration: InputDecoration(
                  //border: OutlineInputBorder(),
                  hintText: '기도문의 내용을 적어주세요.',
                ),
              ),
            ],
          ),
        ));
  }

  Future<void> saveDB() async {
    DBHelper sd = DBHelper();

    var fido = Memo(
      id: str2Sha512(DateTime.now().toString()), // String
      title: this.title,
      text: this.text,
      createTime: DateTime.now().toString(),
      editTime: DateTime.now().toString(),
    );

    await sd.insertMemo(fido);

    print(await sd.memos());
    // Navigator.pop(_context);
    // Navigator.pushReplacement(_context, MaterialPageRoute(builder: (context) => PrayMemoList(title: 'memo')));
    Navigator.pushAndRemoveUntil(_context, MaterialPageRoute(builder: (context) => PrayMemoList(title: 'memo')), (route) => false);
  }

  String str2Sha512(String text) {
    var bytes = utf8.encode(text); // data being hashed
    var digest = sha512.convert(bytes);
    return digest.toString();
  }
}
