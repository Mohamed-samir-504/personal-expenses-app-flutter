import 'package:flutter/material.dart';
import 'package:perosnal_expenses/widgets/chart.dart';
import 'package:provider/provider.dart';

import './widgets/new_transaction.dart';
import './widgets/transaction_list.dart';
import './models/transaction.dart';
import 'home_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(create: (context) => transactions(),
    child: MaterialApp(
      theme: ThemeData(
          primarySwatch: Colors.purple,
          accentColor: Colors.amber
      ),

      title: 'Personal expenses',
      home: MyHomePage(),
    ),);

  }
}

