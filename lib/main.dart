import 'package:flutter/material.dart';
import 'package:expenses/models/transaction.dart';
import 'package:flutter/src/material/colors.dart';
import './componentes/transaction_form.dart';
import 'componentes/transaction_list.dart';
import 'models/transaction.dart';
import 'componentes/chart.dart';
import 'package:flutter/services.dart';
import 'dart:math';

main() => runApp(ExpensesApp());

class ExpensesApp extends StatelessWidget {
  const ExpensesApp({super.key});

  @override
  Widget build(BuildContext context) {
    // SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeRight]);
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return MaterialApp(
      home: MyHomePage(),
      theme: ThemeData(
        primarySwatch: Colors.purple,
        accentColor: Colors.amber,
        fontFamily: 'Quicksand',
        textTheme: const TextTheme(
            bodyText1: TextStyle(
              fontFamily: 'OpenSans',
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            button: TextStyle(color: Colors.green)),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // final List<Transaction> _transactions = [];
  bool _showChart = false;

  final List<Transaction> _transactions = [
    Transaction(
      id: 't0',
      title: 'Conta Antiga',
      value: 400.00,
      date: DateTime.now().subtract(const Duration(days: 3)),
    ),
    Transaction(
      id: 't1',
      title: 'Novo Tênis de Corrida',
      value: 310.76,
      date: DateTime.now().subtract(const Duration(days: 3)),
    ),
    Transaction(
      id: 't2',
      title: 'Conta de Luz',
      value: 211.30,
      date: DateTime.now().subtract(const Duration(days: 4)),
    ),
    Transaction(
      id: 't3',
      title: 'Conta de Internet',
      value: 199.90,
      date: DateTime.now().subtract(const Duration(days: 0)),
    ),
  ];
  List<Transaction> get _recentTransactions {
    return _transactions.where((tr) {
      return tr.date.isAfter(DateTime.now().subtract(Duration(
        days: 7,
      )));
    }).toList();
  }

  _addTransaction(String title, double value, DateTime date) {
    final newTransaction = Transaction(
      id: Random().nextDouble().toString(),
      title: title,
      value: value,
      date: date,
    );

    setState(() {
      _transactions.add(newTransaction);
    });
    Navigator.of(context).pop();
  }

  _removeTransaction(String id) {
    setState(() {
      _transactions.removeWhere((tr) => tr.id == id);
    });
  }

  _openTransactionFormModal(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (_) => TransactionForm(onSubmit: _addTransaction));
  }

  @override
  Widget build(BuildContext context) {
    bool isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    final appBar = AppBar(
      title: Text('Despesas Pessoais',
          // style: Theme.of(context).textTheme.bodyText1,
          style:
              TextStyle(fontSize: 20 * MediaQuery.of(context).textScaleFactor)),
      actions: <Widget>[
        if (isLandscape)
          IconButton(
            onPressed: () {
              setState(() {
                _showChart = !_showChart;
                print("Valor 1 : " + _showChart.toString());
              });
            },
            icon: Icon(_showChart ? Icons.list : Icons.pie_chart),
          ),
        IconButton(
          onPressed: () => _openTransactionFormModal(context),
          icon: Icon(Icons.add),
        ),
      ],
    );

    final availableHeight = MediaQuery.of(context).size.height -
        appBar.preferredSize.height -
        MediaQuery.of(context).padding.top;
    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            if (isLandscape)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Exibir Gráfico'),
                  Switch(
                      value: _showChart,
                      onChanged: (value) {
                        setState(() {
                          _showChart = value;
                        });
                      }),
                ],
              ),
            if (_showChart || !isLandscape)
              Container(
                height: availableHeight * (isLandscape ? 0.7 : 0.3),
                child: Chart(recentTransaction: _transactions),
              ),
            if (!_showChart || !isLandscape)
              Container(
                height: availableHeight * 0.7,
                child: TransactionList(
                  transaction: _transactions,
                  onRemove: _removeTransaction,
                ),
              ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _openTransactionFormModal(context),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
