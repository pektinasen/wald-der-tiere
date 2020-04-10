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
                FishListTile(fish: fish[index]),
                Divider(
                  height: 2.0,
                ),
              ],
            ),
          );
        });
  }
}

class FishListTile extends StatelessWidget {
  final Fish fish;

  const FishListTile({Key key, @required this.fish}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      subtitle: Text(fish.location),
      leading: Image.asset('assets/images/${fish.image}'),
      title: Text(fish.name),
      trailing: Column(children: [
        Text(fish.mkMonthsNorthern()),
        Text(fish.time),
        Text("${fish.price} 💲")
      ], crossAxisAlignment: CrossAxisAlignment.end),
    );
  }
}