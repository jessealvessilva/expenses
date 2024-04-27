import 'package:flutter/material.dart';
import '/models/transaction.dart';

main() => runApp(const ExpensesApp());

class ExpensesApp extends StatelessWidget {
  const ExpensesApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: MyHomePage());
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({Key? key}) : super(key: key);

  final _transactions = [
    Transaction(
      id: "T1",
      title: "Novo Tênis",
      value: 310.16,
      date: DateTime.now(),
    ),
    Transaction(
      id: "T2",
      title: "Conta de Luz",
      value: 211.30,
      date: DateTime.now(),
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Despesas Pessoais'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            width: double.infinity,
            child: Card(
              color: Colors.blue,
              child: Text("Gráfico"),
              elevation: 5,
            ),
          ),
          Column(
            children: <Widget>[
              ..._transactions.map((tr) => Card(
                    child: Text(tr.title),
                  ))
            ].toList(),
          )
        ],
      ),
    );
  }
}
