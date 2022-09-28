import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../models/transaction.dart';


class TransactionList extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final transactionsData = Provider.of<transactions>(context).userTransactions;
    return Container(
      height: 450,
      child:transactionsData.isEmpty? Container(
        margin: EdgeInsets.only(left: 20),
        child: Text("There are no items yet",style: TextStyle(
            fontSize: 25
        ),),
      ): ListView.builder(
        itemBuilder: (ctx, index) {
          return Card(
            child: ListTile(
              leading: CircleAvatar(
                radius: 30,
                child: Padding(
                  padding: EdgeInsets.all(6),
                  child: FittedBox(
                    child: Text('${transactionsData[index].amount} E£'),
                  ),
                ),
              ),
              title: Text(
                transactionsData[index].title,

              ),
              subtitle: Text(
                DateFormat.yMMMd().format(transactionsData[index].date),
              ),
              trailing: IconButton(icon: Icon(Icons.delete,color: Colors.red,), onPressed: () {
                Provider.of<transactions>(context,listen: false).deleteTransaction(transactionsData[index].id);
              },),
            ),
          );
        },
        itemCount: transactionsData.length,
      ),
    );
  }
}
