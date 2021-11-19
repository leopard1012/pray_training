import 'package:flutter/material.dart';
import 'package:pray_training/pray_list.dart';

class PrayForParents extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final Object? args = ModalRoute.of(context)!.settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text('10. 부모님을 위한 기도'),
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