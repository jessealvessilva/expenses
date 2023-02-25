import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  const TransactionList(
      {super.key, required this.transaction, required this.onRemove});

  final List<Transaction> transaction;
  final void Function(String) onRemove;
  final String teste = "";

  @override
  Widget build(BuildContext context) {
    return transaction.isEmpty
        ? LayoutBuilder(
            builder: (ctx, constraints) {
              return Column(
                children: <Widget>[
                  SizedBox(
                    height: constraints.maxHeight * 0.05,
                  ),
                  Container(
                    height: constraints.maxHeight * 0.30,
                    child: Text(
                      'Nenhuma transação cadastrada',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: constraints.maxHeight * 0.05,
                  ),
                  SizedBox(
                    height: constraints.maxHeight * 0.60,
                    child: Image.asset(
                      'assests/images/waiting.png',
                      fit: BoxFit.cover,
                    ),
                  )
                ],
              );
            },
          )
        : ListView.builder(
            itemCount: transaction.length,
            itemBuilder: (context, index) {
              final tr = transaction[index];
              return Card(
                elevation: 5,
                margin: EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 15,
                ),
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 30,
                    child: Padding(
                      padding: const EdgeInsets.all(6),
                      child:
                          FittedBox(child: Text('R\$${tr.value.toString()}')),
                    ),
                  ),
                  title: Text(
                    tr.title,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(DateFormat('d MMM y').format(tr.date)),
                  trailing: IconButton(
                    onPressed: () => onRemove(tr.id),
                    icon: Icon(Icons.delete),
                    color: Theme.of(context).errorColor,
                  ),
                ),
              );
            },
          );
  }
}
