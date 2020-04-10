import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../domain.dart';
import '../services/datastore.dart';
import '../widgets/fish_list_view.dart';
import '../widgets/bug_list_view.dart';
import '../widgets/search_text_field.dart';

class MyHomePage extends StatefulWidget {
  final String title;
  final List<Bug> bugs;
  final List<Fish> fish;
  MyHomePage(this.bugs, this.fish, {Key key, this.title}) : super(key: key);

  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  TabController tabController;

  List<Fish> _fish;
  List<Bug> _bugs;

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

  @override
  Widget build(BuildContext context) {
    var db = Provider.of<Datastore>(context);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          actions: [
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                db.deleteItems();
                setState(() {
                  _fish = widget.fish;
                  _bugs = widget.bugs;
                });
              },
            ),
          ],
        ),
        body: Column(children: [
          Container(
            padding: EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
            child: SearchTextField(onChanged: (value) {
              var newFish = widget.fish
                  .where(
                      (f) => f.name.toLowerCase().contains(value.toLowerCase()))
                  .toList();
              var newBugs = widget.bugs
                  .where(
                      (b) => b.name.toLowerCase().contains(value.toLowerCase()))
                  .toList();
              setState(() {
                _fish = newFish;
                _bugs = newBugs;
              });
            }),
          ),
          Expanded(
            child: TabBarView(
              children: [
                FishListViewBuilder(
                  _fish,
                  onDismissed: (f) async {
                    await db.checkItem(f.uuid);
                    setState(() {
                      _fish =
                          _fish.where((item) => item.uuid != f.uuid).toList();
                    });
                  },
                ),
                BugsListViewBuilder(
                  _bugs,
                  onDismissed: (b) async {
                    await db.checkItem(b.uuid);
                    setState(() {
                      _bugs =
                          _bugs.where((item) => item.uuid != b.uuid).toList();
                    });
                  },
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
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
    );
  }
}
