import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/locale.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;

  NewTransaction(this.addTx);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleInputController = TextEditingController();
  final _amountInputCotroller = TextEditingController();
  DateTime? _selectedDate;

  void _addNewTx() {
    final enteredTitlle = _titleInputController.text;
    final enteredAmount = double.parse(_amountInputCotroller.text);

    if (enteredTitlle.isEmpty || enteredAmount <= 0 || _selectedDate == null) {
      return;
    }

    widget.addTx(
        _titleInputController.text, _amountInputCotroller.text, _selectedDate);

    Navigator.of(context).pop();
  }

  void _presentDatePiker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2020),
            lastDate: DateTime.now())
        .then((value) {
      if (value == null) return;
      setState(() {
        _selectedDate = value;
      });
    });

    print(DateFormat.yMd().format(_selectedDate!));
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5.6,
      child: Container(
          padding: const EdgeInsets.all(10),
          child: Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
            TextField(
              decoration: const InputDecoration(labelText: 'Title'),
              controller: _titleInputController,
              onSubmitted: (_) => _addNewTx(),
            ),
            TextField(
              decoration: const InputDecoration(labelText: 'Amount'),
              controller: _amountInputCotroller,
              keyboardType: TextInputType.number,
              onSubmitted: (_) => _addNewTx(),
            ),
            Container(
              height: 50,
              child: Row(
                children: [
                  Expanded(
                    child: Text((_selectedDate == null)
                        ? 'No date selected'
                        : 'Seleted Date: ${DateFormat.yMd().format(_selectedDate!)}'),
                  ),
                  TextButton(
                      onPressed: _presentDatePiker,
                      style: TextButton.styleFrom(
                          primary: Theme.of(context).primaryColor),
                      child: const Text(
                        'Choose Date',
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ))
                ],
              ),
            ),
            ElevatedButton(
              onPressed: _addNewTx,
              style: TextButton.styleFrom(
                primary: Colors.white,
              ),
              child: const Text('Add Transection'),
            )
          ])),
    );
  }
}
