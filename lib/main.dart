import 'package:flutter/material.dart';
import '../models/transaction.dart';
import '../componentes/transaction_list.dart';

main() => runApp(ExpensesApp());

class ExpensesApp extends StatelessWidget {
  const ExpensesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  String title = '';
  String value = '';

  MyHomePage({super.key});

  final _transaction = [
    Transaction(
      id: 't1',
      title: 'Novo Tênis',
      value: 310.76,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't2',
      title: 'Conta de Luz',
      value: 211.30,
      date: DateTime.now(),
    )
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Despesas Pessoais'),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SizedBox(
              child: Card(
                color: Colors.blue,
                child: Text(
                  'Gráfico',
                ),
                elevation: 5,
              ),
            ),
            TransactionList(transaction: _transaction),
            Card(
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    TextField(
                      onChanged: (newValue) => title = newValue,
                      decoration: InputDecoration(
                        labelText: 'Título',
                      ),
                    ),
                    TextField(
                      onChanged: (newValue) => value = newValue,
                      decoration: InputDecoration(
                        labelText: 'Valor (R\$)',
                        hintText: 'Enter a search term',
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            print(title);
                            print(value);
                          },
                          child: Text(
                            'Nova Transação',
                            style: TextStyle(
                              color: Colors.purple,
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ));
  }
}
