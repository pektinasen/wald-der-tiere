import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';
import 'package:wald_der_tiere/services/datastore.dart';

import 'domain.dart';
import 'pages/home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  static Future<List<T>> _read<T>(
      String fileName, T f(Map<String, dynamic> _)) async {
    print("reading");
    final contents = await rootBundle.loadString("assets/$fileName");
    return (jsonDecode(contents) as List).map((entry) => f(entry)).toList();
  }

  Future<List<Fish>> fishFuture() async {
    var fish = await _read<Fish>('fish.json', (f) => Fish.fromJson(f));
    fish.sort((a, b) => a.name.compareTo(b.name));
    return fish;
  }

  Future<List<Bug>> bugFuture() async {
    var bugs = await _read<Bug>('bugs.json', (f) => Bug.fromJson(f));
    bugs.sort((a, b) => a.name.compareTo(b.name));
    return bugs;
  }

  @override
  Widget build(BuildContext context) {
    final dbF = () async {
      var store = Datastore();
      await store.open();
      return store;
    }();
    final bugF = bugFuture();
    final fishF = fishFuture();
    final allF = Future.wait([dbF, bugF, fishF]).then((response) =>
        Tuple3<Datastore, List<Bug>, List<Fish>>(
            response[0], response[1], response[2]));

    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: FutureBuilder(
            future: allF,
            builder: (ctx, snaps) {
              switch (snaps.connectionState) {
                case ConnectionState.done:
                  Tuple3<Datastore, List<Bug>, List<Fish>> deps = snaps.data;
                  return MultiProvider(
                    providers: [
                      Provider(
                          create: (_) => deps.item1,
                          dispose: (_, db) => db.close()),
                      Provider.value(value: deps.item2),
                      Provider.value(value: deps.item3)
                    ],
                    child: MyHomePage(deps.item2, deps.item3,
                      title: "Wald der Tiere"),
                  );
                default:
                  return SplashScreen();
              }
            }));
  }
}

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.green,
    );
  }
}
