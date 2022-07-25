import 'dart:math';

import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';
import 'package:flutter_format_money_vietnam/flutter_format_money_vietnam.dart';

class TransactionItem extends StatefulWidget {
  const TransactionItem(this._Transaction, this.deleteTransaction,
      {required UniqueKey key});

  final Transaction _Transaction;
  final Function deleteTransaction;

  @override
  State<TransactionItem> createState() => _TransactionItemState();
}

class _TransactionItemState extends State<TransactionItem> {
  // Colors? _bgColors;

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   const avaiableColors = [
  //     Colors.blue,
  //     Colors.black,
  //     Colors.pink,
  //     Colors.purple,
  //   ];

  //   _bgColors = avaiableColors[Random().nextInt(4)] as Colors;
  //   super.initState();
  // }

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
                  widget._Transaction.amount.toStringAsFixed(0).toVND(),
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 15, color: Colors.white),
                ),
              ),
            ),
          ),
          title: Text(widget._Transaction.title),
          subtitle: Text(
            DateFormat.yMMMd().format(widget._Transaction.date),
          ),
          trailing: MediaQuery.of(context).size.width > 380
              ? TextButton.icon(
                  onPressed: () =>
                      widget.deleteTransaction(widget._Transaction.id),
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
                      widget.deleteTransaction(widget._Transaction.id),
                  icon: const Icon(Icons.delete),
                ),
        ),
      ),
    );
  }
}
