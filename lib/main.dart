import 'package:expence_app/new_transaction.dart';
import 'package:expence_app/widget/chart.dart';
import 'package:flutter/material.dart';
import './transaction_list.dart';
import './new_transaction.dart';
import './models/transection.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expance App',
      theme: ThemeData(
          primarySwatch: Colors.purple,
          accentColor: Colors.amberAccent,
          errorColor: Colors.redAccent,
          fontFamily: 'Quicksand',
          textTheme: ThemeData.light().textTheme.copyWith(
              titleMedium: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 18,
                  fontWeight: FontWeight.bold)),
          appBarTheme: AppBarTheme(
              textTheme: ThemeData.light().textTheme.copyWith(
                  titleSmall: TextStyle(
                      fontFamily: 'OpenSans',
                      fontSize: 40,
                      fontWeight: FontWeight.bold)))),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final String title = 'Expance App';

  final List<Transection> _userTransaction = [
    // Transection(id: '1', title: 'Rent', amount: 300, date: DateTime.now()),
    // Transection(id: '2', title: 'Tickets ', amount: 50, date: DateTime.now()),
  ];

  List<Transection> get _recentTransections {
    return _userTransaction.where((element) {
      return element.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  void startAddNewTransactions(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (_) {
          return GestureDetector(
            child: NewTransaction(_addNewTransaction),
            behavior: HitTestBehavior.opaque,
            onTap: (() {}),
          );
        });
  }

  void _addNewTransaction(String title, String amount, DateTime selectedDate) {
    final newTx = Transection(
        id: DateTime.now().toString(),
        title: title,
        amount: double.parse(amount),
        date: selectedDate);

    setState(() {
      _userTransaction.add(newTx);
    });
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransaction.removeWhere((element) {
        return element.id == id;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(title),
          actions: [
            IconButton(
                onPressed: () => startAddNewTransactions(context),
                icon: const Icon(Icons.add))
          ],
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () => startAddNewTransactions(context),
        ),
        body: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Chart(_recentTransections),
              TransactionList(_userTransaction, _deleteTransaction),
            ]));
  }
}
