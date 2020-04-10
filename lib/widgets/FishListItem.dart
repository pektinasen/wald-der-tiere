import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:wald_der_tiere/domain.dart';

typedef OnDismissed = void Function(Fish _);
class FishListViewBuilder extends StatelessWidget {
  final List<Fish> fish;
  final OnDismissed onDismissed;


  const FishListViewBuilder(this.fish, { @required this.onDismissed, Key key}) : super(key: key);

  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: fish.length,
        itemBuilder: (context, index) {
          return Dismissible(
            key: Key(fish[index].uuid),
            onDismissed: (d) => onDismissed(fish[index]),
            background: Container(color: Colors.green),
            child: Column(
              children: <Widget>[
                ListTile(
                  subtitle: Text(fish[index].location),
                  leading: Image.asset('assets/images/${fish[index].image}'),
                  title: Text(fish[index].name),
                  trailing: Column(children: [
                    Text(fish[index].mkMonthsNorthern()),
                    Text(fish[index].time),
                    Text("${fish[index].price} 💲")
                  ], crossAxisAlignment: CrossAxisAlignment.end),
                ),
                Divider(
                  height: 2.0,
                ),
              ],
            ),
          );
        });
  }
}
