import 'dart:ffi';
import 'dart:math';

import 'package:flutter/material.dart';
import '../models/transaction.dart';
import '../components/transaction_list.dart';
import '../components/transaction_form.dart';

class TransactionUser extends StatefulWidget {
  const TransactionUser({super.key});

  @override
  State<TransactionUser> createState() => _TransactionUserState();
}

class _TransactionUserState extends State<TransactionUser> {
  final _transactions = [
    Transaction(
      id: 't1',
      title: 'Novo Tênis de Corrida',
      value: 310.76,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't2',
      title: 'Conta de Luz',
      value: 211.30,
      date: DateTime.now(),
    ),
  ];

  _addTransaction(String titile, double value) {
    print("Conta recebida : ${titile}");
    print("Valor da Conta recebido: ${value}");

    final newTransaction = Transaction(
      id: Random().nextDouble().toString(),
      title: titile,
      value: value,
      date: DateTime.now(),
    );

    setState(() {
      _transactions.add(newTransaction);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TransactionForm(onSubmit: _addTransaction),
        TransactionList(transactions: _transactions),
        // TransactionForm(onSubmit: _addTransaction),
      ],
    );
  }
}
