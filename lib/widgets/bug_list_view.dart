import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:wald_der_tiere/domain.dart';

typedef OnDismissed = void Function(Bug _);

class BugsListViewBuilder extends StatelessWidget {
  final List<Bug> bugs;
  final OnDismissed onDismissed;

  const BugsListViewBuilder(this.bugs, {Key key, @required this.onDismissed})
      : super(key: key);

  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: bugs.length,
      itemBuilder: (context, index) => Dismissible(
        key: Key(bugs[index].uuid),
        onDismissed: (d) => onDismissed(bugs[index]),
        background: Container(color: Colors.green),
        child: Column(
          children: <Widget>[
            BugListTile(bug: bugs[index]),
            Divider(
              height: 2.0,
            ),
          ],
        ),
      ),
    );
  }
}

class BugListTile extends StatelessWidget {
  const BugListTile({
    Key key,
    @required this.bug,
  }) : super(key: key);

  final Bug bug;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      subtitle: Text(bug.location),
      leading: Image.asset('assets/images/${bug.image}'),
      title: Text(bug.name),
      trailing: Column(children: [
        Text(bug.mkMonthsNorthern()),
        Text(bug.time),
        Text("${bug.price} 💲")
      ], crossAxisAlignment: CrossAxisAlignment.end),
    );
  }
}
