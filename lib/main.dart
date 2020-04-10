import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wald_der_tiere/services/datastore.dart';

import 'pages/home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FutureProvider<Datastore>(
        
          create: (_) async { var store = Datastore(); await store.open(); return store;  },
          // dispose: (_, d) async => (await d).close(),
          child: MyHomePage(title: 'Wald der Tiere')),
    );
  }
}
