import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import './models/transection.dart';

class TransactionList extends StatelessWidget {
  final List<Transection> _userTransaction;
  final Function deleteTx;

  TransactionList(this._userTransaction, this.deleteTx);

  Widget itemRender(Transection transection, BuildContext context) {
    return Card(
        elevation: 5.6,
        child: Row(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(8),
              margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
              decoration: BoxDecoration(
                  border: Border.all(
                color: Theme.of(context).primaryColor,
                width: 2,
              )),
              child: Text(
                'Rp: ${transection.amount.toStringAsFixed(1)}',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: Theme.of(context).primaryColor),
              ),
            ),
            Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(transection.title,
                      style: Theme.of(context).textTheme.titleMedium),
                  Text(
                    DateFormat.yMMMMEEEEd().format(transection.date),
                    style: const TextStyle(fontSize: 12),
                  )
                ])
          ],
        ));
  }

  Widget itemTileRender(Transection transection, BuildContext context) {
    return Card(
      elevation: 6,
      child: ListTile(
        leading: CircleAvatar(
          radius: 30,
          child: Padding(
            padding: const EdgeInsets.all(6.0),
            child: FittedBox(child: Text('Rp${transection.amount}')),
          ),
        ),
        title: Text(
          transection.title,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        subtitle: Text(DateFormat.yMMMMEEEEd().format(transection.date),
            style: const TextStyle(fontSize: 12)),
        trailing: IconButton(
          icon: Icon(Icons.delete),
          color: Theme.of(context).errorColor,
          onPressed: () => deleteTx(transection.id),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 500,
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: _userTransaction.isEmpty
            ? Column(
                children: [
                  Image.asset('assets/images/images.png'),
                  Text(
                    'Please add somne data!',
                    style: Theme.of(context).textTheme.titleMedium,
                  )
                ],
              )
            : ListView.builder(
                itemBuilder: ((context, index) {
                  return itemTileRender(_userTransaction[index], context);
                }),
                itemCount: _userTransaction.length,
              ));
  }
}
