import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';
import '../componentes/chart_bar.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransaction;

  const Chart({required this.recentTransaction, Key? key}) : super(key: key);

  List<Map<String, Object>> get groupedTransaction {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(
        Duration(days: index),
      );

      // print("Dia ${index} da semana :  ${weekDay} ");

      double totalSum = 0.0;

      for (var i = 0; i < recentTransaction.length; i++) {
        bool sameDay = recentTransaction[i].date.day == weekDay.day;
        bool sameMonth = recentTransaction[i].date.month == weekDay.month;
        bool sameYear = recentTransaction[i].date.year == weekDay.year;

        if (sameDay && sameMonth && sameYear) {
          totalSum += recentTransaction[i].value;
        }
      }

      print("Day :  ${DateFormat.E().format(weekDay)}/ Total : ${totalSum}");
      // print(totalSum);

      return {
        'day': DateFormat.E().format(weekDay)[0],
        'value': 9.99,
      };
    });
  }

  @override
  Widget build(BuildContext context) {
    List history = groupedTransaction;

    print("Lista ${groupedTransaction}");
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Row(
        children: history.map((tr) {
          return Text('${tr['day']}:${tr['value']}');
        }).toList(),
      ),
    );
  }
}
