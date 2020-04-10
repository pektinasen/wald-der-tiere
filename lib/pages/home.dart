import 'dart:convert';

import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';

import '../domain.dart';
import '../services/datastore.dart';
import '../widgets/BugsListItemBuilder.dart';
import '../widgets/FishListItem.dart';

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

  static Future<List<T>> _read<T>(
      String fileName, T f(Map<String, dynamic> _)) async {
    print("reading");
    final contents = await rootBundle.loadString("assets/$fileName");
    return (jsonDecode(contents) as List).map((entry) => f(entry)).toList();
  }

  FutureBuilder<List<T>> _futureBuilder<T>(
      Future<List<T>> future,
      Widget listViewBuilder(List<T> _),
      bool filter(T _),
      int compare(T _, T __)) {
    return FutureBuilder(
        future: future,
        builder: (context, snaps) {
          switch (snaps.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              // return Text("loading...");
            default:
              if (snaps.hasError) {
                return Text("Error: " + snaps.error.toString());
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

  Future<List<Fish>> newFishFuture(Datastore db) async {
    List<Fish> fishFile = await fishFuture;
    List<Tuple2<String, bool>> checkedList = (await db.allChecked());
    Set<String> checked =
        Set.from(checkedList.where((c) => c.item2).map((c) => c.item1));
    return fishFile.where((f) => !checked.contains(f.uuid)).toList();
  }

  final Future<List<Fish>> fishFuture =
      _read<Fish>('fish.json', (f) => Fish.fromJson(f));
  final Future<List<Bug>> bugFuture =
      _read<Bug>('bugs.json', (f) => Bug.fromJson(f));

  @override
  Widget build(BuildContext context) {
    var db = Provider.of<Datastore>(context);

    db.allChecked().then((i) => print(i));

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Column(children: [
          Container(
            padding: EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
            child: TextField(
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(left: 20, right: 20),
                    border: OutlineInputBorder(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(50.0)),
                    ),
                    hintText: 'Enter a search term'),
                onChanged: (value) {
                  setState(() {
                    _searchTerm = value;
                  });
                }),
          ),
          Expanded(
            child: TabBarView(
              children: [
                _futureBuilder(
                    newFishFuture(db),
                    (fishs) => FishListViewBuilder(
                          fishs,
                          onDismissed: (f) async {
                            await db.checkItem(f.uuid);
                            setState(() {
                              fishs.removeWhere((item) => item.uuid == f.uuid);
                            });
                          },
                        ),
                    (fish) => fish.name
                        .toLowerCase()
                        .contains(_searchTerm.toLowerCase()),
                    (a, b) => a.name.compareTo(b.name)),
                _futureBuilder(
                  bugFuture,
                  (bugs) => BugsListViewBuilder(bugs),
                  (bug) => bug.name
                      .toLowerCase()
                      .contains(_searchTerm.toLowerCase()),
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
        bottomNavigationBar: BottomAppBar(
          shape: const CircularNotchedRectangle(),
          color: Colors.blue,
          child: TabBar(
            tabs: <Tab>[
              Tab(
                // text: 'Fish',
                icon: Icon(Icons.pool),
              ),
              Tab(
                // text: 'Bugs',
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
        floatingActionButton: FloatingActionButton(
            onPressed: null, child: Icon(Icons.filter_list)),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
    );
  }
}
