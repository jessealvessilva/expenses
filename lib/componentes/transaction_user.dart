import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'transaction_form.dart';
import 'transaction_list.dart';

class TransactionUser extends StatefulWidget {
  const TransactionUser({super.key});

  @override
  State<TransactionUser> createState() => _TransactionUserState();
}

class _TransactionUserState extends State<TransactionUser> {
  @override
  Widget build(BuildContext context) {
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

    return Column(
      children: [
        TransactionList(transaction: _transaction),
        TransactionForm(),
      ],
    );
  }
}
