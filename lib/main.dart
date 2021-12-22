import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:pray_training/confs/conf_believer.dart';
import 'package:pray_training/confs/conf_children.dart';
import 'package:pray_training/confs/conf_church.dart';
import 'package:pray_training/confs/conf_devil.dart';
import 'package:pray_training/confs/conf_disease.dart';
import 'package:pray_training/confs/conf_home.dart';
import 'package:pray_training/confs/conf_husband.dart';
import 'package:pray_training/confs/conf_parents.dart';
import 'package:pray_training/confs/conf_personal_1.dart';
import 'package:pray_training/confs/conf_personal_2.dart';
import 'package:pray_training/confs/conf_repentance.dart';
import 'package:pray_training/confs/conf_wife.dart';
import 'package:pray_training/params.dart';
import 'dart:io';
import 'package:pray_training/pray_list.dart';
import 'package:pray_training/prays/pray_for_Tarry.dart';
import 'package:pray_training/prays/pray_for_believer.dart';
import 'package:pray_training/prays/pray_for_business.dart';
import 'package:pray_training/prays/pray_for_cell.dart';
import 'package:pray_training/prays/pray_for_children.dart';
import 'package:pray_training/prays/pray_for_church.dart';
import 'package:pray_training/prays/pray_for_dawn.dart';
import 'package:pray_training/prays/pray_for_devil.dart';
import 'package:pray_training/prays/pray_for_disease.dart';
import 'package:pray_training/prays/pray_for_healing.dart';
import 'package:pray_training/prays/pray_for_home.dart';
import 'package:pray_training/prays/pray_for_homeland.dart';
import 'package:pray_training/prays/pray_for_husband.dart';
import 'package:pray_training/prays/pray_for_money.dart';
import 'package:pray_training/prays/pray_for_night.dart';
import 'package:pray_training/prays/pray_for_parents.dart';
import 'package:pray_training/prays/pray_for_pastor.dart';
import 'package:pray_training/prays/pray_for_person.dart';
import 'package:pray_training/prays/pray_for_personal_1.dart';
import 'package:pray_training/prays/pray_for_personal_2.dart';
import 'package:pray_training/prays/pray_for_repentance.dart';
import 'package:pray_training/prays/pray_for_spiritual_power.dart';
import 'package:pray_training/prays/pray_for_spouse.dart';
import 'package:pray_training/prays/pray_for_temptations.dart';
import 'package:pray_training/prays/pray_for_thanks.dart';
import 'package:pray_training/prays/pray_for_tired.dart';
import 'package:pray_training/prays/pray_for_wife.dart';
import 'package:sqflite/sqflite.dart';

import 'confs/conf_cell.dart';
import 'confs/conf_pastor.dart';
import 'confs/conf_person.dart';
import 'main_page.dart';


void main() {
  runApp(MyApp());
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp,
  //   DeviceOrientation.portraitDown
  // ]).then((_) => runApp(MaterialApp(
  //   title: "My App",
  //   home: MyApp(),
  // ));
}

class MyApp extends StatelessWidget {
  static const String _title = 'Widget Example';

  @override
  Widget build(BuildContext context) {
    Future<Database> database = initDatabase();

    return MaterialApp(
      title: _title,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blue
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => MainPage(database),
        '/homeland': (context) => PrayForHomeland(),
        '/church': (context) => PrayForChurch(database),
        '/pastor': (context) => PrayForPastor(database),
        '/cell': (context) => PrayForCell(database),
        '/believer': (context) => PrayForBeliever(database),
        '/person': (context) => PrayForPerson(database),
        '/home': (context) => PrayForHome(database),
        '/husband': (context) => PrayForHusband(database),
        '/wife': (context) => PrayForWife(database),
        '/parents': (context) => PrayForParents(database),
        '/children': (context) => PrayForChildren(database),
        '/personal_1': (context) => PrayForPersonal1(database),
        '/personal_2': (context) => PrayForPersonal2(database),
        '/repentance': (context) => PrayForRepentance(database),
        '/spiritual_power': (context) => PrayForSpiritualPower(),
        '/temtations': (context) => PrayForTemptations(),
        '/tarry': (context) => PrayForTarry(),
        '/tired': (context) => PrayForTired(),
        '/thanks': (context) => PrayForThanks(),
        '/healing': (context) => PrayForHealing(),
        '/spouse': (context) => PrayForSpouse(database),
        '/money': (context) => PrayForMoney(),
        '/business': (context) => PrayForBusiness(),
        '/dawn': (context) => PrayForDawn(),
        '/night': (context) => PrayForNight(),
        '/devil': (context) => PrayForDevil(database),
        '/disease': (context) => PrayForDisease(database),
        '/conf/church': (context) => ConfChurch(database),
        '/conf/pastor': (context) => ConfPastor(database),
        '/conf/person': (context) => ConfPerson(database),
        '/conf/cell': (context) => ConfCell(database),
        '/conf/believer': (context) => ConfBeliever(database),
        '/conf/home': (context) => ConfHome(database),
        '/conf/husband': (context) => ConfHusband(database),
        '/conf/parents': (context) => ConfParents(database),
        '/conf/wife': (context) => ConfWife(database),
        '/conf/children': (context) => ConfChildren(database),
        '/conf/personal_1': (context) => ConfPersonal1(database),
        '/conf/personal_2': (context) => ConfPersonal2(database),
        '/conf/repentance': (context) => ConfRepentance(database),
        // '/conf/spouse': (context) => ConfSpo(database),
        '/conf/devil': (context) => ConfDevil(database),
        '/conf/disease': (context) => ConfDisease(database),

      },
    );
  }

  Future<Database> initDatabase() async {
    return openDatabase(
      join(await getDatabasesPath(), 'params_database.db'),
      onCreate: (db, version) {
        return db.execute("CREATE TABLE params(pray TEXT PRIMARY KEY, param1 TEXT, param2 TEXT, param3 TEXT, param4 TEXT, param5 TEXT)",);
      },
      version: 1
    );
  }

  // Future<List<Params>> getParams() async {
  //   final Database database = await database;
  //   final List<Map<String, dynamic>> maps = await database.query('params');
  // }
}
