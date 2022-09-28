import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:perosnal_expenses/models/transaction.dart';
import 'package:perosnal_expenses/widgets/chart.dart';
import 'package:perosnal_expenses/widgets/transaction_list.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatefulWidget {

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

var isloaded = false;

  double getTotal(){
    double total = 0;
    Provider.of<transactions>(context,).userTransactions.forEach((element) {
      total+=element.amount;
    });
    return total;
  }
  @override
  void initState() {
    isloaded = false;
    Future.delayed(Duration.zero).then((_) {
      Provider.of<transactions>(context,listen: false).fetchData().then((value) {
        setState(() {
          isloaded = true;
        });
      });
    });

    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Personal expenses'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => Provider.of<transactions>(context,listen: false).startAddNewTransaction(context),
          ),
        ],
      ),
      body: !isloaded?Center(child: CircularProgressIndicator()): SingleChildScrollView(
        child:  Column(
          // mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Center(
              child: Text("Total: ${getTotal()}",style: TextStyle(
                fontSize: 22,fontWeight: FontWeight.bold
              ),),
            ),
            Container(
                width: double.infinity,
                child: Chart(recentTransactions: Provider.of<transactions>(context,listen: false).recentTransactions,)
            ),
            TransactionList(),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => Provider.of<transactions>(context,listen: false).startAddNewTransaction(context),
      ),
    );
  }
}
