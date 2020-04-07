import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:wald_der_tiere/domain.dart';

class FishListViewBuilder extends StatelessWidget {
  final List<Fish> fish;

  const FishListViewBuilder(this.fish, {Key key}) : super(key: key);

  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: fish.length,
      itemBuilder: (context, index) {
        print(fish[index]);
        return Column(
          children: <Widget>[
            ListTile(
              subtitle: Text(fish[index].location),
              leading: Image.asset('assets/images/${fish[index].image}'),
              title: Text(fish[index].name),
              trailing: Column(
                children: [
                  Text(fish[index].time),
                  Text("${fish[index].price} 💲")
                ],
                crossAxisAlignment: CrossAxisAlignment.end
              ),
            ),
            Divider(
              height: 2.0,
            ),
          ],
        );
      }
    );
  }
}
