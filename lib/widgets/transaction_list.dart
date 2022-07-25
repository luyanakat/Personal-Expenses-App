// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import '../models/transaction.dart';
import './transaction_item.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> _userTransaction;
  Function deleteTransaction;

  TransactionList(this._userTransaction, this.deleteTransaction);

  @override
  Widget build(BuildContext context) {
    return _userTransaction.isEmpty
        ? SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                    height: MediaQuery.of(context).size.height * 0.4,
                    child: Image.asset('assets/images/emptylist.png')),
                Text(
                  'Hiện tại List đang trống ạ !!',
                  style: TextStyle(
                    fontSize: 18 * MediaQuery.of(context).textScaleFactor,
                  ),
                ),
              ],
            ),
          )
        : ListView.builder(
            itemBuilder: ((context, index) {
              return TransactionItem(
                  _userTransaction, deleteTransaction, index);
            }),
            itemCount: _userTransaction.length,
          );
  }
}
