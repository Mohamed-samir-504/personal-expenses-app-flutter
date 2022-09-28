import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../widgets/new_transaction.dart';
import 'package:http/http.dart' as http;

class transactionItem  {
  String id;
  String title;
  double amount;
  DateTime date;

  transactionItem(
      {required this.id, required this.title, required this.amount, required this.date});
}

class transactions with ChangeNotifier{

  final List<transactionItem> userTransactions = [
    // transaction(
    //   id: 't1',
    //   title: 'New Shoes',
    //   amount: 69.99,
    //   date: DateTime.now(),
    // ),
    // transaction(
    //   id: 't2',
    //   title: 'Weekly Groceries',
    //   amount: 16.53,
    //   date: DateTime.now(),
    // ),
  ];

  Future<void> addNewTransaction(String txTitle, var txAmount, DateTime date) async{
    final url = Uri.parse("https://personal-expenses-c0d1c-default-rtdb.firebaseio.com/expenses.json");
    final response = await http.post(url,body: json.encode({
      "title": txTitle,
      "amount": txAmount,
      "date": date.toString()
    }));
    final newTx = transactionItem(
      title: txTitle,
      amount: txAmount,
      date: date,
      id: json.decode(response.body)["name"]
    );
    userTransactions.add(newTx);
    notifyListeners();
  }

  Future<void>fetchData()async{
    final url = Uri.parse("https://personal-expenses-c0d1c-default-rtdb.firebaseio.com/expenses.json");

    final response = await http.get(url);
    final extractedData = json.decode(response.body) as Map<String, dynamic>;
    if(extractedData == null)return;

    extractedData.forEach((key, value) {
      if(!userTransactions.any((element) => element.id == key)){
        userTransactions.add(transactionItem(id: key, title: value["title"], amount: value["amount"], date: DateTime.parse(value["date"])));
        notifyListeners();
      }
    });



  }



  Future<void> deleteTransaction(String id)async{
    final url = Uri.parse("https://personal-expenses-c0d1c-default-rtdb.firebaseio.com/expenses/$id.json");
    await http.delete(url);
    userTransactions.removeWhere((element) => element.id == id);
    notifyListeners();

  }

  List<transactionItem> get recentTransactions{
    return userTransactions.where((element) {
      return element.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
    notifyListeners();
  }

  List<Map<String,dynamic>> get groupedTransactionsvalues{
    return List.generate(7, (index) {
      double sum =0;
      final weekday = DateTime.now().subtract(Duration(days: index));

      for(int i = 0; i<recentTransactions.length;i++){
        if(recentTransactions[i].date.day == weekday.day &&
            recentTransactions[i].date.month == weekday.month&&
            recentTransactions[i].date.year == weekday.year) sum+=recentTransactions[i].amount;
      }
      return{'day': DateFormat.E().format(weekday).substring(0,1), 'amount': sum};
    }).reversed.toList();
  }

  double get totalSpending{
    return groupedTransactionsvalues.fold(0.0, (previousValue, element) {
      return previousValue + element['amount'];
    });
  }

  void startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return GestureDetector(
          onTap: () {},
          child: NewTransaction(),
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }

}