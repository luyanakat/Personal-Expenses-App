import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import './adaptive_button.dart';

class AddNewTransaction extends StatefulWidget {
  final Function addTransaction;
  @override
  State<AddNewTransaction> createState() => _AddNewTransactionState();

  AddNewTransaction(this.addTransaction);
}

class _AddNewTransactionState extends State<AddNewTransaction> {
  final _addTitle = TextEditingController();
  final _addAmount = TextEditingController();
  DateTime? _selectedDate;

  void _datePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2022),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  void _closeNotiDateP() {
    Navigator.of(context).pop();
  }

  void _notiPickedDate(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (_) {
          return SizedBox(
            height: 300,
            child: Card(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Xin hãy chọn ngày mua đã ạ ><',
                    style: TextStyle(fontSize: 18),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 10),
                    child: ElevatedButton(
                      onPressed: () => _closeNotiDateP(),
                      child: const Text(
                        'Đóng',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        child: Padding(
          padding: EdgeInsets.only(
            top: 8,
            left: 8,
            right: 8,
            bottom: MediaQuery.of(context).viewInsets.bottom + 20,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextField(
                decoration: const InputDecoration(labelText: 'Title'),
                textCapitalization: TextCapitalization.words,
                controller: _addTitle,
              ),
              TextField(
                decoration: const InputDecoration(labelText: 'Amount'),
                keyboardType: TextInputType.number,
                controller: _addAmount,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(
                          _selectedDate == null
                              ? 'No chosen Date!'
                              : DateFormat.yMMMd()
                                  .format(_selectedDate as DateTime),
                        ),
                        AdaptiveFlatButton('Choose Date', _datePicker),
                      ],
                    ),
                    SizedBox(
                      child: TextButton(
                        onPressed: () => _selectedDate == null
                            ? _notiPickedDate(context)
                            : widget.addTransaction(
                                _addTitle.text,
                                double.parse(_addAmount.text),
                                _selectedDate,
                              ),
                        child: const Text('Add Transaction'),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
