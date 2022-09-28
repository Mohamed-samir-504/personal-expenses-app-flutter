import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:perosnal_expenses/models/transaction.dart';
import 'package:provider/provider.dart';

class NewTransaction extends StatefulWidget {

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();

  final amountController = TextEditingController();

   DateTime selectedDate = DateTime.now();

  Future<void> submitData() async{
    final enteredtitle = titleController.text;
    final enteredamount = double.parse(amountController.text);

    if(enteredtitle.isEmpty || enteredamount<=0 || selectedDate == null)return;

    await Provider.of<transactions>(context,listen: false).addNewTransaction(enteredtitle, enteredamount, selectedDate);


    Navigator.of(context).pop();
  }

  void datePicker(){
    showDatePicker(context: context, initialDate: DateTime.now(),
        firstDate: DateTime(2022), lastDate: DateTime.now()).then((value) {
          if(value == null)return;
          setState(() {
            selectedDate = value;
          });

    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TextField(
              decoration: InputDecoration(labelText: 'Title'),
              controller: titleController,

              // onChanged: (val) {
              //   titleInput = val;
              // },
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Amount'),
              controller: amountController,
              keyboardType: TextInputType.number,

              // onChanged: (val) => amountInput = val,
            ),

            Container(
              height: 70,
              child: Row(
                children: [
                  Text(selectedDate == null? 'No date chosen' : DateFormat.yMMMd().format(selectedDate)),
                  FlatButton(
                    onPressed: datePicker
                    , child: Text("Choose date",style: TextStyle(fontWeight: FontWeight.bold),),
                  textColor: Theme.of(context).primaryColor,)
                ],
              ),
            ),
            RaisedButton(
              child: Text('Add Transaction'),
              textColor: Colors.white,
              color: Theme.of(context).primaryColor,
              onPressed: submitData
            ),
          ],
        ),
      ),
    );
  }
}
