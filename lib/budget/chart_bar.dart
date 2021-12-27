import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double spendingAmount;
  final double spendingPercentageOfTotal;

  ChartBar({this.label, this.spendingAmount, this.spendingPercentageOfTotal});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
            height: 10,
            child: FittedBox(
                child: Text("\$ ${spendingAmount.toStringAsFixed(0)}"))),
        SizedBox(
          height: 4,
        ),
        Container(
          height: 60,
          width: 10,
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey, width: 1.0),
                ),
              ),
              FractionallySizedBox(
                heightFactor: spendingPercentageOfTotal,
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Theme.of(context).primaryColorDark),
                ),
              )
            ],
          ),
        ),
        SizedBox(
          height: 4,
        ),
        Text(label)
      ],
    );
  }
}
