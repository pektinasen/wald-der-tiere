import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:path_provider/path_provider.dart';
import 'domain.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Wald der Tiere'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  Future<List<T>> _read<T>(String fileName, T f(Map<String, dynamic> _)) async {
    final contents = await rootBundle.loadString("assets/$fileName");
    return (jsonDecode(contents) as List).map((entry) => f(entry)).toList();
  }

  Widget _createListView<T>(List<T> data, String f(T)) {
    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (context, index) => Column(
        children: <Widget>[
          ListTile(
            subtitle: Text('subtitle'),
            leading: Icon(Icons.account_balance),
            title: Text(f(data[index])),
            trailing: Text('trailing'),
          ),
          Divider(
            height: 2.0,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    FutureBuilder<List<T>> futureBuilder<T>(
        Future<List<T>> future, String f(T), int c(T a, T b)) {
      return FutureBuilder(
          future: future,
          builder: (context, snaps) {
            switch (snaps.connectionState) {
              case ConnectionState.none:
              case ConnectionState.waiting:
                return Text("loading...");
              default:
                if (snaps.hasError) {
                  return Text("Error" + snaps.error.toString());
                } else {
                  return _createListView(
                      snaps.data
                          .build()
                          .rebuild((l) => l..sort((a, b) => c(a, b)))
                          .toList(),
                      f);
                }
            }
          });
    }

    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text(widget.title),
        ),
        body: TabBarView(
          children: [
            futureBuilder(
              _read<Fish>('fish.json', (f) => Fish.fromJson(f)),
              (fish) => fish.name,
              (a, b) => a.name.compareTo(b.name)),
            futureBuilder(
                _read<Bug>("bugs.json", (b) => Bug.fromJson(b)),
                (bug) => bug.name,
                (a, b) => a.name.compareTo(b.name)),
            futureBuilder(
                Future.value([
                  {"name": "bar"}
                ]),
                (fish) => fish['name'],
                (a, b) => a['name'].compareTo(b['name'])),
          ],
          controller: tabController,
        ),
        bottomNavigationBar: Material(
          color: Colors.blue,
          child: TabBar(
            tabs: <Tab>[
              Tab(
                text: 'Fish',
                icon: Icon(Icons.pool),
              ),
              Tab(
                text: 'Bugs',
                icon: Icon(Icons.bug_report),
              ),
              Tab(
                text: 'Furniture',
                icon: Icon(Icons.beach_access),
              ),
            ],
            controller: tabController,
          ),
        ),
      ),
    );
  }
}
