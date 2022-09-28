import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  const ChartBar({Key? key, required this.label, required this.spendingamount, required this.percentage}) : super(key: key);
   final String label;
  final double spendingamount;
  final double percentage;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(height: 20, child: FittedBox(child: Text("${spendingamount}"))),
        SizedBox(height: 4,),
        Container(
          height: 60,
          width: 10,
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey,width: 1),
                  color: Color.fromRGBO(220, 220, 220, 1),
                  borderRadius: BorderRadius.circular(10)
                ),
              ),
              FractionallySizedBox(heightFactor: percentage,
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(10)
                ),
              ),)
            ],
          ),
          
        ),
        SizedBox(height: 4,),
        Text(label)
      ],
    );
  }
}
