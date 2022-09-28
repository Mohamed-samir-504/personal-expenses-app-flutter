
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:perosnal_expenses/widgets/chart_bar.dart';
import 'package:provider/provider.dart';

import '../models/transaction.dart';

class Chart extends StatelessWidget {
  const Chart({Key? key, required this.recentTransactions}) : super(key: key);

  final List<transactionItem> recentTransactions;


  @override
  Widget build(BuildContext context) {
    final transactiondata = Provider.of<transactions>(context);
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Padding(
        padding: EdgeInsets.only(top: 13,bottom: 13),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: transactiondata.groupedTransactionsvalues.map((data) {
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(label: data['day'], spendingamount: data['amount'],
                  percentage: transactiondata.totalSpending == 0.0?0.0:data['amount']/transactiondata.totalSpending),
            );
          }).toList(),

        ),
      ),

    );
  }
}
