import 'package:flutter/material.dart';
import 'package:pray_training/pray_list.dart';

class PrayForHusband extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final Object? args = ModalRoute.of(context)!.settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text('08. 남편을 위한 기도'),
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