import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';
import 'package:flutter_format_money_vietnam/flutter_format_money_vietnam.dart';

class TransactionItem extends StatelessWidget {
  const TransactionItem(
    this._userTransaction,
    this.deleteTransaction,
    this.index,
  );

  final List<Transaction> _userTransaction;
  final Function deleteTransaction;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Card(
        elevation: 2,
        child: ListTile(
          leading: Container(
            width: 100,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.teal),
              borderRadius: BorderRadius.circular(15),
              color: Colors.teal,
            ),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: FittedBox(
                fit: BoxFit.none,
                child: Text(
                  _userTransaction[index].amount.toStringAsFixed(0).toVND(),
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 15, color: Colors.white),
                ),
              ),
            ),
          ),
          title: Text(_userTransaction[index].title),
          subtitle: Text(
            DateFormat.yMMMd().format(_userTransaction[index].date),
          ),
          trailing: MediaQuery.of(context).size.width > 380
              ? TextButton.icon(
                  onPressed: () =>
                      deleteTransaction(_userTransaction[index].id),
                  label: const Text(
                    'Delete',
                    style: TextStyle(color: Colors.red),
                  ),
                  icon: Icon(
                    Icons.delete,
                    color: Theme.of(context).errorColor,
                  ),
                )
              : IconButton(
                  onPressed: () =>
                      deleteTransaction(_userTransaction[index].id),
                  icon: const Icon(Icons.delete),
                ),
        ),
      ),
    );
  }
}
