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
            ListTile(
              subtitle: Text(bugs[index].location),
              leading: Image.asset('assets/images/${bugs[index].image}'),
              title: Text(bugs[index].name),
              trailing: Column(children: [
                Text(bugs[index].mkMonthsNorthern()),
                Text(bugs[index].time),
                Text("${bugs[index].price} 💲")
              ], crossAxisAlignment: CrossAxisAlignment.end),
            ),
            Divider(
              height: 2.0,
            ),
          ],
        ),
      ),
    );
  }
}
