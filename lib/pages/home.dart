import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';

import '../domain.dart';
import '../services/datastore.dart';
import '../widgets/bug_list_view.dart';
import '../widgets/fish_list_view.dart';
import '../widgets/search_text_field.dart';

class MyHomePage extends StatefulWidget {
  final String title;
  final List<Bug> bugs;
  final List<Fish> fish;
  final Datastore db;
  MyHomePage(this.db, this.bugs, this.fish, {Key key, this.title})
      : super(key: key);

  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  TabController tabController;
  List<Fish> _fish;
  List<Bug> _bugs;

  void onIconButtonPressed(Datastore db) {
    db.deleteItems();
    setState(() {
      _fish = widget.fish;
      _bugs = widget.bugs;
    });
  }

  void onSearchTextChanged(value) {
    var newFish = widget.fish
        .where((f) => f.name.toLowerCase().contains(value.toLowerCase()))
        .toList();
    var newBugs = widget.bugs
        .where((b) => b.name.toLowerCase().contains(value.toLowerCase()))
        .toList();
    setState(() {
      _fish = newFish;
      _bugs = newBugs;
    });
  }

  void onFishDismissed(Datastore db, Fish fish) async {
    await db.checkItem(fish.uuid);
    setState(() {
      _fish = _fish.where((item) => item.uuid != fish.uuid).toList();
    });
  }

  void onBugDismissed(Datastore db, Bug bug) async {
    await db.checkItem(bug.uuid);
    setState(() {
      _bugs = _bugs.where((item) => item.uuid != bug.uuid).toList();
    });
  }

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
    _fish = widget.fish;
    _bugs = widget.bugs;
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  Future<Tuple2<List<Bug>, List<Fish>>> getData(Datastore db) {}

  @override
  Widget build(BuildContext context) {
    var db = Provider.of<Datastore>(context);

    return FutureBuilder<Tuple2<List<Bug>, List<Fish>>>(
      initialData: Tuple2(_bugs, _fish),
      future: (() => db.allChecked().then((Set<String> checked) {
            print("checked: " + checked.toString());
            var bugs = _bugs.where((b) => !checked.contains(b.uuid)).toList();
            var fish = _fish.where((f) => !checked.contains(f.uuid)).toList();
            return Tuple2(bugs, fish);
          }))(),
      builder: (_, AsyncSnapshot<Tuple2<List<Bug>, List<Fish>>> snaps) {
        List<Bug> bb = snaps.data.item1;
        List<Fish> ff = snaps.data.item2;

        return SafeArea(
          child: Scaffold(
            appBar: AppBar(
              title: Text(widget.title),
              actions: [
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () => onIconButtonPressed(db),
                ),
              ],
            ),
            body: Column(children: [
              Container(
                  padding: EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
                  child: SearchTextField(
                      // onChanged: (v) => onSearchTextChanged(v)
                      )),
              Expanded(
                child: TabBarView(
                  children: [
                    FishListViewBuilder(
                      ff,
                      onDismissed: (fish) => onFishDismissed(db, fish),
                    ),
                    BugsListViewBuilder(
                      bb,
                      onDismissed: (bug) => onBugDismissed(db, bug),
                    ),
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
                ],
                controller: tabController,
              ),
            ),
            floatingActionButton: FloatingActionButton(
                onPressed: null, child: Icon(Icons.filter_list)),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
          ),
        );
      },
    );
  }
}
