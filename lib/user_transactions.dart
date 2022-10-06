import 'package:flutter/material.dart';
import './transaction_list.dart';
import './new_transaction.dart';
import './models/transection.dart';

class UserTransactions extends StatefulWidget {
  const UserTransactions({Key? key}) : super(key: key);

  @override
  State<UserTransactions> createState() => _UserTransactionsState();
}

class _UserTransactionsState extends State<UserTransactions> {
  final List<Transection> _userTransaction = [
    // Transection(id: '1', title: 'Rent', amount: 300, date: DateTime.now()),
    // Transection(id: '2', title: 'Tickets ', amount: 50, date: DateTime.now()),
  ];

  void _addNewTransaction(String title, String amount) {
    final newTx = Transection(
        id: _userTransaction.length.toString(),
        title: title,
        amount: double.parse(amount),
        date: DateTime.now());

    setState(() {
      _userTransaction.add(newTx);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // NewTransaction(_addNewTransaction),
        // TransactionList(_userTransaction)
      ],
    );
  }
}
