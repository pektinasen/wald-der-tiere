import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:wald_der_tiere/domain.dart';

class BugsListViewBuilder extends StatelessWidget {
  final List<Bug> bugs;

  const BugsListViewBuilder(this.bugs, {Key key}) : super(key: key);

  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: bugs.length,
      itemBuilder: (context, index) => Column(
        children: <Widget>[
          ListTile(
            subtitle: Text(bugs[index].location),
            leading: Image.asset('assets/images/${bugs[index].image}'),
            title: Text(bugs[index].name),
            trailing: Column(children: [
              Text(bugs[index].time),
              Text("${bugs[index].price} 💲")
            ],
            crossAxisAlignment: CrossAxisAlignment.end,),
          ),
          Divider(
            height: 2.0,
          ),
        ],
      ),
    );
  }
}
