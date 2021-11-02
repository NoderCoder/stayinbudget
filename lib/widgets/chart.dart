import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/models/transaction.dart';
import 'package:flutter_complete_guide/widgets/chart_bar.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  List<Transaction> recentTransactions;
  Chart(this.recentTransactions);

  List<Map<String, Object>> get groupedTransactionsvalues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));
      double totalAmount = 0;
      for (var i = 0; i < recentTransactions.length; i++) {
        if (recentTransactions[i].date.day == weekDay.day &&
            recentTransactions[i].date.month == weekDay.month &&
            recentTransactions[i].date.year == weekDay.year) {
          totalAmount = totalAmount + (recentTransactions[i].amount);
        }
      }
      print(DateFormat.E().format(weekDay));
      print(totalAmount);
      return {
        'day': DateFormat.E().format(weekDay).substring(0, 1),
        'amount': totalAmount
      };
    });
  }

  double get totalSpendings {
    return groupedTransactionsvalues.fold(0.0, (previousValue, element) {
      return element["amount"] != null
          ? previousValue + (element["amount"] as double)
          : double.parse("0.00");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: groupedTransactionsvalues.map((txData) {
          return Flexible(
            fit: FlexFit.tight,
            child: ChartBar(
                label: txData["day"],
                spendingAmount: txData["amount"],
                spendingPercentageOfTotal: totalSpendings == 0.0
                    ? 0.0
                    : ((txData["amount"] as double) / totalSpendings)),
          );
        }).toList(),
      ),
    );
  }
}
