import 'package:flutter/material.dart';
import 'package:pray_training/pray_list.dart';

class PrayForDisease extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final Object? args = ModalRoute.of(context)!.settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text('27. 질병을 치료하는 기도'),
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