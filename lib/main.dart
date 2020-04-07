import 'dart:async';
import 'dart:convert';
import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:wald_der_tiere/widgets/FishListItem.dart';
import 'package:wald_der_tiere/widgets/BugsListItemBuilder.dart';
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
  String _searchTerm;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
    _searchTerm = "";
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

  FutureBuilder<List<T>> _futureBuilder<T>(
      Future<List<T>> future,
      Widget listViewBuilder(List<T> _),
      bool filter(T),
      int compare(T _, T __)) {
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
                return listViewBuilder(snaps.data
                    .build()
                    .rebuild((l) => l
                      ..where((a) => filter(a))
                      ..sort((a, b) => compare(a, b)))
                    .toList());
              }
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text(widget.title),
        ),
        body: Column(children: [
          TextField(
              decoration: InputDecoration(
                  border: InputBorder.none, hintText: 'Enter a search term'),
              onChanged: (value) {
                if (value.length >= 3) {
                  setState(() {
                    _searchTerm = value;
                  });
                } else {
                  setState(() {
                    _searchTerm = "";
                  });
                }
              }),
          Expanded(
            child: TabBarView(
              children: [
                _futureBuilder(
                    _read<Fish>('fish.json', (f) => Fish.fromJson(f)),
                    (fishs) => FishListViewBuilder(fishs),
                    (fish) => fish.name
                        .toLowerCase()
                        .startsWith(_searchTerm.toLowerCase()),
                    (a, b) => a.name.compareTo(b.name)),
                _futureBuilder(
                  _read<Bug>("bugs.json", (b) => Bug.fromJson(b)),
                  (bugs) => BugsListViewBuilder(bugs),
                  (bug) => bug.name
                      .toLowerCase()
                      .startsWith(_searchTerm.toLowerCase()),
                  (a, b) => a.name.compareTo(b.name),
                ),
                // futureBuilder(
                //     Future.value([
                //       {"name": "bar"}
                //     ]),
                //     (fish) => fish['name'],
                //     (a, b) => a['name'].compareTo(b['name']),
                //     (_) => Icon(Icons.access_alarm),
                //     (_) => true)
              ],
              controller: tabController,
            ),
          ),
        ]),
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
              // Tab(
              //   text: 'Furniture',
              //   icon: Icon(Icons.beach_access),
              // ),
            ],
            controller: tabController,
          ),
        ),
      ),
    );
  }
}
